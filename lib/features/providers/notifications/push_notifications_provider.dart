import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/firebase_options.dart';
import 'package:multi_store_app/settings/local_notifications/local_notifications_config.dart';

final notificationsProvider = StateNotifierProvider((ref) => NotificationsProvider(
      NotificationsController(),
    ));

class NotificationsProvider extends StateNotifier<NotificationsController> {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationsProvider(
    super.state,
  );

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final notificationsAuth = await _requestPermission();
    if (notificationsAuth) {
      _getFCMToken();
      _onForegroundMessage();
      // _onBackgroundMessage();
    }
  }

  static Future<void> _getFCMToken() async {
    final token = await messaging.getToken();
    debugPrint(token);
    // emailLoginController.text = token ?? "------";
  }

  static Future<bool> _requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
    } else {
      return false;
    }
  }

  static void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  static void handleRemoteMessage(RemoteMessage message) {
    int generarNumeroRandom() {
      Random random = Random();
      int numero = random.nextInt(9000) + 1000; // Genera un número entre 1000 y 9999
      return numero;
    }

    if (message.data.isEmpty) return;
    LocalNotifications.showLocalNotification(
        groupKey: message.data['groupKey'] ?? "",
        id: generarNumeroRandom(),
        title: message.data['title'] ?? "",
        body: message.data['body'] ?? "",
        channelId: message.data['channelId'] ?? "");
    // print('TITULOOOOOO ${message.notification?.title ?? "--------"}');
    // print('BODYYYYYYYYYY ${message.notification?.body ?? "--------"}');

    // final notification = PushMessage(
    //   messageId: message.messageId
    //     ?.replaceAll(':', '').replaceAll('%', '')
    //     ?? '',
    //   title: message.notification!.title ?? '',
    //   body: message.notification!.body ?? '',
    //   sentDate: message.sentTime ?? DateTime.now(),
    //   data: message.data,
    //   imageUrl: Platform.isAndroid
    //     ? message.notification!.android?.imageUrl
    //     : message.notification!.apple?.imageUrl
    // );

    // add( NotificationReceived(notification) );
  }
}

class NotificationsController {}
