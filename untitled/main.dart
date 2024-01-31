// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/app_theme/app_theme.dart';
import 'package:haatinhandseller/firebase_options.dart';
import 'package:haatinhandseller/screens/splash_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'haatinhandseller_high_51', // id
      'Important Notification', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
      playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    debugPrint('User granted provisional permission');
  } else {
    debugPrint('User declined or has not accepted permission');
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
    if (message != null) {
      debugPrint("Message Received One");
      if (message.notification != null) {
        // await AudioPlayer().play(AssetSource('sound/notifications.mp3'));
        RemoteNotification notification = message.notification!;
        AndroidNotification? android = message.notification?.android;

        if (android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: '@drawable/ic_launcher',
                    playSound: true,
                    enableVibration: true),
              ));
        }
      }
    }
  });
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'haatinhandseller_high_51', // id
    'Important Notification', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
    if (message != null) {
      debugPrint("Message Received Two");
      if (message.notification != null) {
        // await AudioPlayer().play(AssetSource('sound/notifications.mp3'));
        RemoteNotification notification = message.notification!;
        AndroidNotification? android = message.notification?.android;

        if (android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: '@drawable/ic_launcher',
                    playSound: true,
                    enableVibration: true),
              ));
        }
      }
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
      overlayColor: AppColorConstant.overlayColor,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Seller',
        theme: AppTheme.getTheme(),
        home: const SplashScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
