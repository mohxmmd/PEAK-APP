import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/other_settings.dart';

class NotificationController extends GetxController {
  final OtherSettings otherSettings = OtherSettings();

  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() async {
    try {
      Map<String, dynamic> response = await otherSettings.fetchNotifications();

      if (response.isNotEmpty && response.containsKey('notifications')) {
        List<dynamic> data = response['notifications'];

        notifications.value = data
            .map((notification) => notification as Map<String, dynamic>)
            .toList();
      } else {
        debugPrint('No notifications found or unexpected response.');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
