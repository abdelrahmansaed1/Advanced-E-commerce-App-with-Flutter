// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// class NotificationService {
//   // ================= Singleton =================
//   NotificationService._internal();
//   static final NotificationService _instance =
//       NotificationService._internal();
//   factory NotificationService() => _instance;

//   // ============== Plugin Instance ==============
//   final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // ================= Initialize =================
//   Future<void> init() async {
//     final AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings settings =
//         InitializationSettings(
//       android: androidSettings,
//     );

//     await _notificationsPlugin.initialize(settings);
//   }

//   // ================= Show Notification =================
//   Future<void> showNotification({
//     required String title,
//     required String body,
//     int id = 0,
//   }) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'general_channel',
//       'General Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails);

//     await _notificationsPlugin.show(
//       id,
//       title,
//       body,
//       notificationDetails,
//     );
//   }

//   // ================= Cancel Notification =================
//   Future<void> cancelNotification(int id) async {
//     await _notificationsPlugin.cancel(id);
//   }

//   // ================= Cancel All =================
//   Future<void> cancelAllNotifications() async {
//     await _notificationsPlugin.cancelAll();
//   }
// }
