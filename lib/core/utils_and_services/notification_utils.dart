import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Make sure Firebase is initialized here too
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('🌙 onBackgroundMessage: ${message.messageId}');
}

const AndroidNotificationChannel highImportanceChannel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // name
  description: 'Used for important notifications.',
  importance: Importance.max,
);

Future<void> initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    ); // iOS only

    // 🔔 Init local notifications (Android + iOS)
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // Create Android channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(highImportanceChannel);

    // Ask for permission
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    log('Auth status: ${settings.authorizationStatus}');

    final fcmToken = await FirebaseMessaging.instance.getToken();
    log('FCM token: $fcmToken');

    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    log('APNs token: $apnsToken');

    final initmesg = await FirebaseMessaging.instance.getInitialMessage();
    log('initmesgn: $initmesg');

    setupFcmDebug();
  } catch (e, st) {
    log("initFirebase error: $e\n$st");
  }
}

Future<void> checkNotificationPermission() async {
  // This will *ask* for permission if not asked before
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false, // set true if you want provisional on iOS
  );

  log('Auth status: ${settings.authorizationStatus}');
}

Future<void> setupFcmDebug() async {
  // 🔔 Android 13+ permission
  final androidImpl = flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await androidImpl?.requestNotificationsPermission();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    log('🔥 onMessage: ${message.messageId}');
    log('🔥 data: ${message.data}');
    log('🔥 notification: ${message.notification?.title} | ${message.notification?.body}');

    final notification = message.notification;
    final android = notification?.android;

    if (notification != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            highImportanceChannel.id,
            highImportanceChannel.name,
            channelDescription: highImportanceChannel.description,
            importance: Importance.max,
            priority: Priority.high,
            icon: android?.smallIcon ?? '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data['route'] ?? '',
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log('📬 onMessageOpenedApp: ${message.messageId}');
  });

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    log('🚀 getInitialMessage: ${initialMessage.messageId}');
  }
}
