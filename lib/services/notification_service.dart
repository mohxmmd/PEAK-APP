import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:peak_app/screens/notification/notification_controller.dart';
import 'package:peak_app/screens/notification/notification_screen.dart';
import 'package:peak_app/services/user_service.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Background message handler
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint('Background Notification - Title: ${message.notification?.title}');
  debugPrint('Background Notification - Body: ${message.notification?.body}');
  debugPrint('Background Notification - Payload: ${message.data}');
}

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    // Request permission for notifications
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    debugPrint(
        'Notification permission status: ${settings.authorizationStatus}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var memberId = prefs.getInt('member_id') ?? 0;

    // Retrieve FCM token
    try {
      final fcmToken = await _firebaseMessaging.getToken();
      Map<String, dynamic> updatedData = {'fcm_token': fcmToken};
      if (fcmToken != null) {
        debugPrint('Firebase Messaging Token Retrieved Successfully.');
        await UserService().updateUserData(updatedData, memberId);
      } else {
        debugPrint('Failed to retrieve FCM token.');
      }
    } catch (e) {
      debugPrint('Error retrieving FCM token: $e');
    }

    // Configure Flutter Local Notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);
    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Navigate to Notification Screen when notification is clicked
        if (response.payload != null) {
          debugPrint('Notification payload: ${response.payload}');
          Get.to(() => const NotificationScreen());
          _refreshNotifications();
        }
      },
    );

    // Listen for foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
          'Foreground Notification - Title: ${message.notification?.title}');
      debugPrint(
          'Foreground Notification - Body: ${message.notification?.body}');
      _showLocalNotification(
        message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body',
        message.data,
      );
      _refreshNotifications();
    });

    // Handle notifications when app is opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Notification clicked! Navigating to Notification Screen...');
      Get.to(() => const NotificationScreen());
      _refreshNotifications();
    });

    // Handle background notifications
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  void _refreshNotifications() {
    try {
      final controller = Get.find<NotificationController>();
      controller.fetchNotifications();
    } catch (e) {
      debugPrint('NotificationController not found: $e');
    }
  }

  Future<void> _showLocalNotification(
      String title, String body, Map<String, dynamic> payload) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'default_channel_id',
      'Default Channel',
      channelDescription: 'Default channel for app notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      DateTime.now().hashCode,
      title,
      body,
      notificationDetails,
      payload: payload['screen'] ?? 'notification_screen',
    );
  }
}
