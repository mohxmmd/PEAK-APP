import 'package:peak_app/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peak_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/user_service.dart';

class RegistrationController3 extends GetxController {
  final emergencyContactName = TextEditingController();
  final emergencyContactNumber = TextEditingController();
  final expatriateSince = TextEditingController();
  final planToStopExpat = TextEditingController();

  final UserService userService = UserService();

  RxBool isSelected = true.obs;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxInt memberId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchMemberId();
    // NotificationService().initNotifications();
  }

  @override
  void onClose() {
    emergencyContactName.dispose();
    emergencyContactNumber.dispose();
    expatriateSince.dispose();
    planToStopExpat.dispose();

    super.onClose();
  }

  Future<void> _fetchMemberId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId.value = prefs.getInt('member_id') ?? 0;
  }

  // Register process function
  Future<void> signUpProcess3() async {
    _isLoading.value = true;
    await _fetchMemberId();

    update();

    Map<String, dynamic> registrationData = {
      "emergency_contact_name": emergencyContactName.text,
      "emergency_contact_number": emergencyContactNumber.text,
      "expatriate_since": expatriateSince.text,
      "plan_stop_expat": planToStopExpat.text,
      "registration_completed": 3,
    };

    // Send data using the UserService
    await userService.updateUserData(registrationData, memberId.value);
    userService.saveUserDataToLocal();

    onTapContinue();

    _isLoading.value = false;
    update();
  }

  void onTapContinue() {
    Get.offNamed(Routes.successScreen);
  }
}
