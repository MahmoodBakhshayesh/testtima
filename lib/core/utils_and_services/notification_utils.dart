import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../firebase_options.dart';

/// Global instance for local notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Android channel (ignored on iOS but needed for Android)
const String highImportanceChannelId = 'high_importance_channel';
const String highImportanceChannelName = 'High Importance Notifications';
const String highImportanceChannelDescription =
    'Used for important notifications.';

const AndroidNotificationChannel highImportanceChannel =
AndroidNotificationChannel(
  highImportanceChannelId,
  highImportanceChannelName,
  description: highImportanceChannelDescription,
  importance: Importance.max,
);

/// Background handler - we will NOT try to show local notifications here,
/// let APNs/Android handle background notifications.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('🌙 onBackgroundMessage: ${message.messageId}');
  log('🌙 data: ${message.data}');
  log('🌙 notification: ${message.notification?.title} | ${message.notification?.body}');
}

/// Call this BEFORE runApp in main()
Future<void> initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Background handler must be registered early
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // iOS: allow alert/sound/badge even when app is in foreground
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Init local notifications (Android + iOS)
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      // You can add callbacks here if you want to handle taps
      // onDidReceiveNotificationResponse: ...
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // Android: create channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(highImportanceChannel);

    // Ask for permission (iOS + Android 13+)
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

    final String? apnsToken =
    await FirebaseMessaging.instance.getAPNSToken();
    log('🍏 APNs token: $apnsToken');

    final RemoteMessage? initMsg =
    await FirebaseMessaging.instance.getInitialMessage();
    log('🚀 init message: $initMsg');

    await setupFcmDebug();

    // 🔔 SELF-TEST: show a local notification 3 seconds after startup
    // so we know flutter_local_notifications works on iOS foreground.
    Future.delayed(const Duration(seconds: 3), () async {
      log('🧪 Showing test local notification...');
      await flutterLocalNotificationsPlugin.show(
        9999,
        'Test local notification',
        'If you see this, local notifications work',
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
      );
    });
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

  // FOREGROUND messages – always show a local notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    log('🔥 onMessage: ${message.messageId}');
    log('🔥 data: ${message.data}');
    log('🔥 notification: ${message.notification?.title} | ${message.notification?.body}');

    final RemoteNotification? notification = message.notification;

    // Prefer notification payload, fall back to data
    final String title =
        notification?.title ??
            message.data['title'] as String? ??
            'New message';
    final String body =
        notification?.body ??
            message.data['body'] as String? ??
            'You have a new notification';

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
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log('📬 onMessageOpenedApp: ${message.messageId}');
    // TODO: handle navigation
  });

  final RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    log('🚀 getInitialMessage: ${initialMessage.messageId}');
  }
}
