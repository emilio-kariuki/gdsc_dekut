import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsRepository {
  AndroidNotificationChannel notificationChannel =
      const AndroidNotificationChannel(
    '1',
    'High Importance Notifications',
    description: 'this channel is used for important notifications.',
    importance: Importance.high,
  );

  AndroidNotificationChannel normalChannel = const AndroidNotificationChannel(
    '2',
    'low normal Notifications',
    description: 'this channel is used for normal notifications.',
    importance: Importance.low,
  );

  Future<void> showImportantNotification({
    required String message,
    required String title,
  }) async {
    
    return FlutterLocalNotificationsPlugin().show(
      0,
      title,
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "1",
          'High Importance Notifications',
          channelDescription: "This is the notifications message channel",
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        ),
      ),
    );
  }

  Future<void> showNormalNotification({
    required String message,
    required String title,
  }) async {
    return FlutterLocalNotificationsPlugin().show(
      0,
      title,
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "2",
          'Low normal Notifications',
          channelDescription: "This is the notifications normal channel",
          importance: Importance.min,
          priority: Priority.low,
          showWhen: false,
        ),
      ),
    );
  }

  Future<bool> createPushNotification({
    required String title,
    required String message,
    required String image,
  }) async {
    try {
      final client = http.Client();
      const postUrl = 'https://fcm.googleapis.com/fcm/send';

      final data = {
        "to": "/topics/test",
        "mutable_content": true,
        'notification': {
          'title': title,
          'body': message,
        },
        'priority': 'high',
        'data': {
          "content": {
            "id": 1,
            "badge": 42,
            "channelKey": "event_key",
            "displayOnForeground": true,
            "notificationLayout": "BigPicture",
            "largeIcon": image,
            "bigPicture": image,
            "showWhen": false,
            "autoDismissible": true,
            "privacy": "Public",
            "payload": {"secret": "Awesome Notifications Rocks!"}
          },
          "actionButtons": [
            {
              "key": "REDIRECT",
              "label": "Redirect",
              "autoDismissible": true,
            },
            {
              "key": "DISMISS",
              "label": "Dismiss",
              "actionType": "DismissAction",
              "isDangerousOption": true,
              "autoDismissible": true
            }
          ],
          "Android": {
            "content": {
              "title": "Android! The eagle has landed!",
              "payload": {"android": "android custom content!"}
            }
          },
        },
      };

      final headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAta6X3Qk:APA91bGweK3WrC4RhucqVV29O__UAyeCbu-Jen34MTdaxlzux6QvwENfPCRwoPXMDnHQJTJ_f3lsvafud24OnQzbri2o12Y_YB7dXWdPcA71aHc00Cds5ZnF_JEw6MyBdG6UUe-jBouQ',
      };

      final response = await client.post(
        Uri.parse(postUrl),
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully.');
        return true;
      } else {
        print('Notification sent failed.');
        return false;
      }
    } catch (e) {
      debugPrint("the error creating the notification is : ${e.toString()}");
      return false;
    }
  }

  Future initializeNotifications() async {
    await [Permission.notification,]
        .request();
    return FlutterLocalNotificationsPlugin().initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('gdsc'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
    );
  }

  Future initializeFirebaseMessaging() async {
    
    try {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint("Message received");
        showImportantNotification(
          message: message.data['message'] ?? message.notification!.body!,
          title: message.data['title'] ?? message.notification!.title!,
        );
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Error initializing firebase messaging");
    }
  }

  Future<void> cancelNotification({required int id}) async {
    return FlutterLocalNotificationsPlugin().cancel(id);
  }

  Future<String> getFirebaseMessagingToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      debugPrint("The firebase messaging token is : ${token}");
      return token!;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Error getting firebase messaging token");
    }
  }
}
