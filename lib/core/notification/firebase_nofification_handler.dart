import 'dart:io';

import 'package:get/get.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

import '../../data/sources/local/shared_prefs.dart';
import '../di/di_manager.dart';

class FirebaseNotifications {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  void setUp() {
    NotificationHandler.initNotification();
    firebaseCloudMessagingListener();
  }

  Future firebaseCloudMessagingListener() async {
    await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
      provisional: false,
    );

    _messaging.getToken().then((token) {
      Logger().d(token);
      DIManager.findDep<SharedPrefs>().setFcmToken(token!);
    });

    FirebaseMessaging.onMessage.listen((remoteMessage) {
      Logger().d('received this message: ${remoteMessage}');

      FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
        if (Platform.isIOS) {
          Get.dialog(CupertinoAlertDialog(
            title: Text(remoteMessage.notification!.title!),
            content: Text(remoteMessage.notification!.body!),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('ok'),
                onPressed: () {
                  DIManager.findNavigator().pop();
                },
              )
            ],
          ));
        }
      });

      if (Platform.isAndroid) {
        showNotification(
            remoteMessage.data['title'], remoteMessage.data['body']);
      } else if (Platform.isIOS) {
        showNotification(remoteMessage.notification!.title,
            remoteMessage.notification!.body);
      }
    });
  }

  static Future showNotification(title, body) async {
    const androidChannel = AndroidNotificationDetails(
      'widetechnology.royake',
      'new message',
      autoCancel: true,
      ongoing: true,
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );
    const iOS = DarwinNotificationDetails();

    const platform = NotificationDetails(android: androidChannel, iOS: iOS);
    await NotificationHandler.flutterLocalNotificationsPlugin
        .show(0, title, body, platform, payload: 'my payload');
  }
}

class NotificationHandler {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initNotification() {
    const initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const initSettings =
        InitializationSettings(android: initAndroid, iOS: initIOS);

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
    );
  }

  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    Get.dialog(CupertinoAlertDialog(
      title: Text(title!),
      content: Text(body!),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('ok'),
          onPressed: () {
            DIManager.findNavigator().pop();
          },
        )
      ],
    ));
  }
}
