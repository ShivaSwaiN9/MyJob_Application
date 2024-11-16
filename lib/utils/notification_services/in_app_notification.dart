import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:my_job_flutter/app_configs/app_colors.dart';
import 'package:path_provider/path_provider.dart';

import 'fcm_services.dart';

const String channelId = 'com.myjob.user/notification';
const String channelName = 'My-Job-Notification';
const String channelDescription = 'My Job Notification Channel';
const String notificationTicker = 'ticker';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

NotificationAppLaunchDetails? notificationAppLaunchDetails;

class InAppNotification {
  static Future<void> configureInAppNotification(
      {bool reqAlert = true,
      bool reqBadge = true,
      bool reqSound = true}) async {
    await Firebase.initializeApp();

    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: reqAlert,
        requestBadgePermission: reqBadge,
        requestSoundPermission: reqSound,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          if (payload != null) onNotificationTapped(json.decode(payload));
        });
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) async =>
            {if (payload != null) onNotificationTapped(json.decode(payload))});
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getToken().then((value) {
      print("FCMID $value");
    });
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
          channelId,
          channelName,
          description: channelDescription,
          importance: Importance.high,
        ));
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(backgroundMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(backgroundMessageHandler);
    // FirebaseMessaging.instance.configure(
    //     onMessage: backgroundMessageHandler,
    //     onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
    //     onLaunch: (message) async {
    //       try {
    //         Map<dynamic, dynamic> data = message['data'];
    //         // Get.offAndToNamed(DashboardPage.routeName);
    //         log('onLaunch $data');
    //         // Get.offAndToNamed(DashboardPage.routeName);
    //         // Future.delayed(Duration(seconds: 2)).then((value) {
    //         //   onNotificationTapped(
    //         //       ActivityDatum.fromJson(Map<String, dynamic>.from(data)));
    //         // });
    //       } catch (e, s) {
    //         debugPrint('$e $s');
    //       }
    //     },
    //     onResume: (message) async {
    //       try {
    //         Map<dynamic, dynamic> data = message['data'];
    //         log('onResume $data');
    //
    //         // onNotificationTapped(
    //         //     ActivityDatum.fromJson(Map<String, dynamic>.from(data)));
    //       } catch (e, s) {
    //         debugPrint('$e $s');
    //       }
    //     });
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true, provisional: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {});
  }

  ///request IOS notification permission
  static void requestIOSPermissions(
      {bool alert = true, bool badge = true, bool sound = true}) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: alert,
          badge: badge,
          sound: sound,
        );
  }

  static Future<void> showNotification(
      {String title = 'My Job',
      String description = 'New notification.',
      String imageUrl = 'http://via.placeholder.com/128x128/00FF00/000000',
      String? data}) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        icon: '@mipmap/ic_launcher',
        styleInformation: DefaultStyleInformation(true, true),
        importance: Importance.max,
        priority: Priority.max,
        ticker: notificationTicker,
        enableLights: true,
        color: AppColors.brightPrimary,
        ledColor: AppColors.brightPrimary,
        ledOnMs: 1000,
        ledOffMs: 500);
    const iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentSound: true,
        presentAlert: true,
        presentBadge: true,
        badgeNumber: 1);
    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    try {
      await flutterLocalNotificationsPlugin.show(
          title.hashCode, title, description, platformChannelSpecifics,
          payload: data);
    } catch (e, s) {
      log('Error showing $e $s');
    }
  }
}
