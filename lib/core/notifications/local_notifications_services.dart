import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsServices {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static final StreamController<NotificationResponse> streamController =
      StreamController<NotificationResponse>.broadcast();

  static const String channelId = 'high_importance_channel';
  static const String channelName = 'High Importance Notifications';

  static void onTap(NotificationResponse response) {
    streamController.add(response);
  }

  static Future<void> init() async {
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );

    // Android 13+ permission
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showBasicNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        priority: Priority.high,
        channelShowBadge: true,
        enableVibration: true,
        enableLights: true,
        visibility: NotificationVisibility.public,
      ),
    );

    await _plugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }
}
