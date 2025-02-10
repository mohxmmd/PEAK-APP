import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/routes/routes.dart';
import 'package:peak_app/screens/settings/settings_controller.dart';
import 'package:peak_app/services/notification_service.dart';
import 'package:peak_app/services/other_settings.dart';
import 'package:peak_app/services/otp_service.dart';
import 'package:peak_app/services/user_service.dart';
import 'package:peak_app/widgets/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  RxString currentText = "".obs;
  RxInt secondsRemaining = 59.obs;
  RxInt minuteRemaining = 0.obs;
  RxBool enableResend = false.obs;
  Timer? timer;

  final OtpService otpService = OtpService();
  final UserService userService = UserService();
  final OtherSettings otherSettings = OtherSettings();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  Future<void> _initializeServices() async {
    try {
      Get.put(SettingsController());
      // await NotificationService().initNotifications();
      debugPrint('Notification service initialized.');
    } catch (e) {
      debugPrint('Error initializing notification service: $e');
    }
  }

  @override
  void onInit() {
    timerInit();
    _fetchAds();
    super.onInit();
    _initializeServices();
  }

  @override
  void onClose() {
    otpController.dispose();
    timer?.cancel();
    super.onClose();
  }

  void timerInit() {
    enableResend.value = false;
    secondsRemaining.value = 59;
    minuteRemaining.value = 0;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (minuteRemaining.value != 0) {
        secondsRemaining.value--;
        if (secondsRemaining.value == 0) {
          secondsRemaining.value = 59;
          minuteRemaining.value--;
        }
      } else if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
        timer?.cancel();
      }
    });
  }

  Future<void> resendOtp() async {
    try {
      enableResend.value = false;
      timerInit();
      final prefs = await SharedPreferences.getInstance();
      String whatsappNumber = prefs.getString('whatsappNumber') ?? '';
      await otpService.verifyAndSendOTP(whatsAppNumber: whatsappNumber);
      Get.snackbar('OTP Sent', 'A new OTP has been sent to your number.',
          snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend OTP. Please try again.',
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> verifyOtp(BuildContext context) async {
    _isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();

    try {
      final String otpInput = otpController.text;

      if (await otpService.verifyOtp(otp: otpInput)) {
        final userData = await userService.getUserData();
        await userService.saveUserDataToLocal();

        final int registrationStep =
            int.parse(userData['registration_completed'].toString());
        prefs.setBool('isLoggedIn', true);
        _navigateToNextStep(registrationStep);
      } else {
        _showAlert('Invalid OTP');
      }
    } catch (e) {
      _showAlert('Invalid OTP');
    } finally {
      _isLoading.value = false;
    }
  }

  void _navigateToNextStep(int step) {
    switch (step) {
      case 0:
        Get.offAndToNamed(Routes.registrationScreen1);
        break;
      case 1:
        Get.offAndToNamed(Routes.registrationScreen2);
        break;
      case 2:
        Get.offAndToNamed(Routes.registrationScreen3);
        break;
      case 3:
        Get.offAllNamed(Routes.dashboardScreen);
        break;
      default:
        _showAlert('Error');
    }
  }

  Future<void> _fetchAds() async {
    try {
      await otherSettings.fetchAds();
    } catch (e) {
      debugPrint("Error fetching ads: $e");
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: Get.context!,
      builder: (context) => CustomAlertDialog(message: message),
    );
  }
}
