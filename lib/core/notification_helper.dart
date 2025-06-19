import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: android);
    await _plugin.initialize(initSettings);
  }

  static Future<void> show(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'chucker_channel', 'Chucker Logs',
      importance: Importance.max,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);
    await _plugin.show(0, title, body, details);
  }
}
