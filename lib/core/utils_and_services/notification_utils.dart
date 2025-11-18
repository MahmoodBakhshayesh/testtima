import 'dart:developer';

import 'package:abds/core/utils_and_services/button_keys.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/screens/inbox/inbox_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

/// Background message handler
/// Must be a top-level function and annotated with @pragma
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Init Firebase in background isolate
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('🌙 onBackgroundMessage: ${message.messageId}');
  log('🌙 data: ${message.data}');
  log('🌙 notification: ${message.notification?.title} | ${message.notification?.body}');

  // ✅ IMPORTANT:
  // Do NOT show a local notification here for messages that already have
  // a `notification` payload, otherwise you get double notifications,
  // because the OS (APNs/Android) will also show it.
  final RemoteNotification? notification = message.notification;

  if (notification != null) {
    // Let the system (APNs / FCM) handle it in background/terminated.
    log('ℹ️ Background message has notification payload; letting OS show it.');
    return;
  }

  // Optional: for DATA-ONLY messages in background you *can* show your own notification.
  if (message.data.isNotEmpty) {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();
    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    final String title =
        message.data['title'] as String? ?? 'New message (background)';
    final String body =
        message.data['body'] as String? ?? 'You have a new notification';

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

/// Call this BEFORE runApp in main()
Future<void> initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Background handler MUST be set before any other messaging usage
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // iOS: how to present notifications when app is in foreground
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Init local notifications (Android + iOS)
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();
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

    final String? apnsToken =
    await FirebaseMessaging.instance.getAPNSToken();
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
    log('🔥 notification: ${message.notification?.title} | ${message.notification?.body}');

    final RemoteNotification? notification = message.notification;
    final AndroidNotification? android = notification?.android;

    // Foreground: you usually want to show your own local notification
    // so the user sees something even when app is open.
    // (System may or may not show one depending on settings.)

    final String title =
        notification?.title ??
            message.data['title'] as String? ??
            'New message';
    final String body =
        notification?.body ??
            message.data['body'] as String? ??
            'You have a new notification';

    // await flutterLocalNotificationsPlugin.show(
    //   notification?.hashCode ?? message.hashCode,
    //   title,
    //   body,
    //   NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       highImportanceChannel.id,
    //       highImportanceChannel.name,
    //       channelDescription: highImportanceChannel.description,
    //       importance: Importance.max,
    //       priority: Priority.high,
    //       icon: android?.smallIcon ?? '@mipmap/ic_launcher',
    //     ),
    //     iOS: const DarwinNotificationDetails(
    //       presentAlert: true,
    //       presentBadge: true,
    //       presentSound: true,
    //     ),
    //   ),
    //   payload: message.data['route'] as String? ?? '',
    // );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    log('📬 onMessageOpenedApp: ${message.messageId}');
    String? refCode = message.data["refCode"];
    String? route = getIt<HomeController>().navigation.currentRoute?.name;
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      log('🚀 getInitialMessage: ${initialMessage.messageId}');
    }
    if(route == "login" ){
      ButtonKeys.loginButtonKeyPhone.currentState?.triggerTap();
      // getIt<HomeController>().getRefHistoryLog(code: refCode, showCode: null);
    }else{
      if(refCode!=null){
        getIt<HomeController>().getRefHistoryLog(code: refCode, showCode: null);
      }
    }
    // getIt<HomeController>().getRefHistoryLog(code: refCode, showCode: null);
    // TODO: navigation if needed
  });


}
