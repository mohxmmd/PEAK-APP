import 'package:flutter/material.dart';
import 'package:peak_app/routes/routes.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/other_settings.dart';
import 'package:peak_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessController extends GetxController {

  final UserService userService = UserService();
  final OtherSettings otherSettings = OtherSettings();

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  void _initializeController() async {
    _fetchAds();
    _fetchRazorpayKey();
    _fetchUserData(); 
  }

  void onTapContinue() {
    Get.offAllNamed(Routes.dashboardScreen);
  }

  
  Future<void> _fetchRazorpayKey() async {
    try {
      final key = await otherSettings.fetchRazorpayKey();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('razorpay_key', key);
      debugPrint('Razorpay key stored successfully: $key');
    } catch (e) {
      debugPrint("Error fetching Razorpay key: $e");
    }
  }

  Future<void> _fetchAds() async {
    try {
      await otherSettings.fetchAds();
    } catch (e) {
      debugPrint("Error fetching ads: $e");
    }
  }

  Future<void> _fetchUserData() async {
    try {
      await userService.saveUserDataToLocal();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }
}
