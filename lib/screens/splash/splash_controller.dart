import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/other_settings.dart';
import 'package:peak_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final UserService userService = UserService();
  final OtherSettings otherSettings = OtherSettings();

  var isLogged = false.obs;
  List<String> countries = [];

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  void _initializeController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogged.value = prefs.getBool('isLoggedIn') ?? false;

    _fetchCountries();
    _fetchAds();

    if (isLogged.value) {
      _fetchUserData();
      _fetchRazorpayKey();
    }

    _navigateToNextScreen();
  }

  Future<void> _fetchCountries() async {
    try {
      countries = await otherSettings.fetchCountries();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('countries', countries);
    } catch (e) {
      debugPrint("Error fetching countries: $e");
    }
  }

  Future<void> _fetchRazorpayKey() async {
    try {
      final key = await otherSettings.fetchRazorpayKey();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('razorpay_key', key);
      print('---------------------------------------------------');
      print(key);

      debugPrint('Razorpay key stored successfully');
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

  Future<void> _navigateToNextScreen() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLogged = prefs.getBool('isLoggedIn') ?? false;
      var registrationStep = prefs.getInt('registration_completed');
      if (isLogged && registrationStep == 3) {
        Get.offNamed('/dashboardScreen');
      } else {
        Get.offAllNamed('/logInScreen');
      }
    } catch (e) {
      debugPrint("Error navigating to next screen: $e");
      Get.offNamed('/logInScreen');
    }
  }
}
