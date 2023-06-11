import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:push_app/config/router/app_router.dart';

class LocalNotifications {
  static final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static String channelName = 'Channel 1';
  static String channelDesc = 'channel Desc';

  static int id = 1;

  static Future<void> initializeLocalNotifications() async {
    await _requestPermissionLocalNotifications();
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid = AndroidInitializationSettings('clip');
    //TODO ios configuration
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // TODO ios configuration settings
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> _requestPermissionLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  static NotificationDetails getGroupNotifier({String? groupKey, required String channelId}) {
    InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
      [],
      contentTitle: '$id messages',
      summaryText: 'shv@gmail.com',
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(channelId, channelName,
        styleInformation: inboxStyleInformation,
        groupKey: groupKey,
        playSound: true,
        setAsGroupSummary: true,
        importance: Importance.min,
        priority: Priority.min);

    return NotificationDetails(android: androidNotificationDetails);
  }

  static void showLocalNotification(
      {required int id, String? title, String? body, String? data, String? groupKey, required channelId}) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.max,
      groupKey: groupKey,
      playSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);

    id = id + 1;

    NotificationDetails groupNotification = getGroupNotifier(groupKey: groupKey, channelId: channelId);
    await flutterLocalNotificationsPlugin.show(0, 'Attention', '$id messages', groupNotification);
  }
}
