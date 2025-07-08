import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../presentation/pages/logs_page.dart';
import 'navigation_service.dart';

class NotificationHelper {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: iOS);
    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null) {
          switch (payload) {
            case 'open_logs':
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (_) => const LogsPage()),
              );
              break;
          }
        }
      },
    );
  }

  static Future<void> show(String title, String body, String payload) async {
    const androidDetails = AndroidNotificationDetails(
      'chucker',
      'Chucker Logs',
      channelDescription: 'Show logs of responses as notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);
    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }
}
