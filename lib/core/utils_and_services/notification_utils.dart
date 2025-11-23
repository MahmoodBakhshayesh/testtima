import 'dart:developer';
import 'dart:typed_data';
import 'dart:io';

import 'package:abds/core/utils_and_services/button_keys.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/screens/inbox/inbox_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../firebase_options.dart';

/// Global instance for local notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Channel constants
const String highImportanceChannelId = 'high_importance_channel';
const String highImportanceChannelName = 'High Importance Notifications';
const String highImportanceChannelDescription =
    'Used for important notifications.';

const AndroidNotificationChannel highImportanceChannel =
AndroidNotificationChannel(
  highImportanceChannelId, // id
  highImportanceChannelName, // name
  description: highImportanceChannelDescription,
  importance: Importance.max,
);

/// Base URL for airline images
/// Example full URL: https://imagedcs.abomis.com/api/airlineimage/QI
const String airlineImageBaseUrl =
    'https://imagedcs.abomis.com/api/airlineimage/';

/// Build full airline image URL from short code (e.g. "QI" -> ".../QI")
String? _buildAirlineImageUrl(String? code) {
  if (code == null || code.isEmpty) return null;
  return '$airlineImageBaseUrl$code';
}

/// Helper: download image bytes from URL (Android largeIcon)
Future<Uint8List?> _downloadImageBytes(String? url) async {
  if (url == null || url.isEmpty) {
    log('📷 No image URL provided');
    return null;
  }

  try {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    log('📷 GET $url -> ${response.statusCode}, content-type: ${response.headers['content-type']}');

    if (response.statusCode != 200) {
      log('❌ Image request failed (${response.statusCode})');
      return null;
    }

    final contentType = response.headers['content-type'] ?? '';
    if (!contentType.startsWith('image/')) {
      final preview = String.fromCharCodes(response.bodyBytes.take(120));
      log(
          '❌ Not an image. content-type=$contentType, body starts with: $preview');
      return null;
    }

    if (response.bodyBytes.isEmpty) {
      log('❌ Image body is empty');
      return null;
    }

    return response.bodyBytes;
  } catch (e, st) {
    log('❌ Error downloading image from $url: $e\n$st');
    return null;
  }
}

/// Helper: download image and save to a temporary file (for iOS attachments)
Future<String?> _downloadAndSaveImageFile(String? url, String fileName) async {
  final bytes = await _downloadImageBytes(url);
  if (bytes == null) return null;

  try {
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    log('📁 Saved image to $filePath');
    return filePath;
  } catch (e, st) {
    log('❌ Error saving image file: $e\n$st');
    return null;
  }
}

/// Background message handler
/// Must be a top-level function and annotated with @pragma
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log('🌙 onBackgroundMessage: ${message.messageId}');
  log('🌙 data: ${message.data}');
  log(
      '🌙 notification: ${message.notification?.title} | ${message.notification?.body}');

  final RemoteNotification? notification = message.notification;

  // If the message has a notification payload, let the OS show it.
  if (notification != null) {
    log('ℹ️ Background message has notification payload; letting OS show it.');
    return;
  }

  // For DATA-ONLY messages in background we manually show a local notification.
  if (message.data.isNotEmpty) {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInit =
    DarwinInitializationSettings();
    const InitializationSettings initSettings =
    InitializationSettings(android: androidInit, iOS: iosInit);

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    final String title =
        message.data['title'] as String? ?? 'New message (background)';
    final String body =
        message.data['body'] as String? ?? 'You have a new notification';

    // "airline" in data is the airline code, e.g. "QI"
    final String? airlineCode = message.data['airline'] as String?;
    final String? imageUrl = _buildAirlineImageUrl(airlineCode);

    // Android: use bytes as largeIcon
    final Uint8List? imageBytes = await _downloadImageBytes(imageUrl);
    log('📷 [BG] imageBytes length: ${imageBytes?.lengthInBytes}');

    // iOS: save file and attach
    final String? attachmentPath = await _downloadAndSaveImageFile(
      imageUrl,
      'bg_airline_${airlineCode ?? "unknown"}.png',
    );

    try {
      await flutterLocalNotificationsPlugin.show(
        message.hashCode,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            highImportanceChannelId,
            highImportanceChannelName,
            channelDescription: highImportanceChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            largeIcon: imageBytes != null
                ? ByteArrayAndroidBitmap(imageBytes)
                : null,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            attachments: attachmentPath != null
                ? [DarwinNotificationAttachment(attachmentPath)]
                : null,
          ),
        ),
        payload: message.data['route'] as String? ?? '',
      );
    } catch (e, st) {
      log('❌ Failed to show background notification with image: $e\n$st');
      // Fallback without image
      await flutterLocalNotificationsPlugin.show(
        message.hashCode,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            highImportanceChannelId,
            highImportanceChannelName,
            channelDescription: highImportanceChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data['route'] as String? ?? '',
      );
    }
  }
}

/// Call this BEFORE runApp in main()
Future<void> initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Background handler MUST be set before any other messaging usage
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // iOS: how to present notifications when app is in foreground
    // Disable system alert so we only show our custom local notification.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false, // <--- key change to avoid duplicate notifications
      badge: true,
      sound: false,
    );

    // Init local notifications (Android + iOS)
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInit =
    DarwinInitializationSettings();
    const InitializationSettings initSettings =
    InitializationSettings(android: androidInit, iOS: iosInit);

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // Android: create channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(highImportanceChannel);

    // Ask for permission (iOS + Android 13+ behavior)
    final NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    log('🔐 Auth status: ${settings.authorizationStatus}');

    // Tokens
    final String? fcmToken = await FirebaseMessaging.instance.getToken();
    log('📲 FCM token: $fcmToken');

    final String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    log('🍏 APNs token: $apnsToken');

    final RemoteMessage? initMsg =
    await FirebaseMessaging.instance.getInitialMessage();
    log('🚀 init message: $initMsg');

    // Setup foreground / opened-app listeners
    await setupFcmDebug();
  } catch (e, st) {
    log("❌ initFirebase error: $e\n$st");
  }
}

Future<void> checkNotificationPermission() async {
  final NotificationSettings settings =
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  log('🔐 Auth status (manual check): ${settings.authorizationStatus}');
}

Future<void> setupFcmDebug() async {
  // Android 13+ permission
  final AndroidFlutterLocalNotificationsPlugin? androidImpl =
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  await androidImpl?.requestNotificationsPermission();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    log('🔥 onMessage: ${message.messageId}');
    log('🔥 data: ${message.data}');
    log(
        '🔥 notification: ${message.notification?.title} | ${message.notification?.body}');

    final RemoteNotification? notification = message.notification;

    final String title =
        notification?.title ?? message.data['title'] as String? ?? 'New message';
    final String body =
        notification?.body ?? message.data['body'] as String? ?? 'You have a new notification';

    // "airline" in data is the airline code, e.g. "QI"
    final String? airlineCode = message.data['airline'] as String?;
    final String? imageUrl = _buildAirlineImageUrl(airlineCode);

    // Android: use bytes as largeIcon
    final Uint8List? imageBytes = await _downloadImageBytes(imageUrl);
    log('📷 [FG] imageBytes length: ${imageBytes?.lengthInBytes}');

    // iOS: save file and attach
    final String? attachmentPath = await _downloadAndSaveImageFile(
      imageUrl,
      'fg_airline_${airlineCode ?? "unknown"}.png',
    );

    try {
      await flutterLocalNotificationsPlugin.show(
        notification?.hashCode ?? message.hashCode,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            highImportanceChannelId,
            highImportanceChannelName,
            channelDescription: highImportanceChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            largeIcon: imageBytes != null
                ? ByteArrayAndroidBitmap(imageBytes)
                : null,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            attachments: attachmentPath != null
                ? [DarwinNotificationAttachment(attachmentPath)]
                : null,
          ),
        ),
        payload: message.data['route'] as String? ?? '',
      );
    } catch (e, st) {
      log('❌ Failed to show foreground notification with image: $e\n$st');
      // Fallback without image
      await flutterLocalNotificationsPlugin.show(
        notification?.hashCode ?? message.hashCode,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            highImportanceChannelId,
            highImportanceChannelName,
            channelDescription: highImportanceChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data['route'] as String? ?? '',
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    log('📬 onMessageOpenedApp: ${message.messageId}');
    String? refCode = message.data["refCode"];
    String? route = getIt<HomeController>().navigation.currentRoute?.name;
    final RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      log('🚀 getInitialMessage: ${initialMessage.messageId}');
    }
    if (route == "login") {
      ButtonKeys.loginButtonKeyPhone.currentState?.triggerTap();
    } else {
      if (refCode != null) {
        getIt<HomeController>()
            .getRefHistoryLog(code: refCode, showCode: null);
      }
    }
  });
}
