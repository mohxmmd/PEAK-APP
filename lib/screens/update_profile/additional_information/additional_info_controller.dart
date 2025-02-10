import 'package:peak_app/screens/dashboard/dashboard_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/user_service.dart';

class AdditionalInfoController extends GetxController {

  final emergencyContactName = TextEditingController();
  final emergencyContactNumber = TextEditingController();
  final expatriateSince = TextEditingController();
  final planToStopExpat = TextEditingController();
  final RxString planStopExpat = ''.obs;
  final UserService userService = UserService();
  final DashBoardController dashBoardController =
      Get.find<DashBoardController>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxInt memberId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId.value = prefs.getInt('member_id') ?? 0; 
    await userService.saveUserDataToLocal();

    emergencyContactName.text = prefs.getString('emergency_contact_name') ?? '';
    emergencyContactNumber.text =
        prefs.getString('emergency_contact_number') ?? '';
    expatriateSince.text = prefs.getString('expatriate_since') ?? '';
    planToStopExpat.text = prefs.getString('plan_stop_expat') ?? '';
    planStopExpat.value = prefs.getString('plan_stop_expat') ?? '';
    planToStopExpat.text = planStopExpat.value;
  }

  void updateplanStopExpat(String status) {
    planStopExpat.value = status;
    planToStopExpat.text = status;
  }

  Future<bool> updateAdditionalInfo() async {
    _isLoading.value = true;

    Map<String, dynamic> updatedData = {
      'emergency_contact_name': emergencyContactName.text,
      'emergency_contact_number': emergencyContactNumber.text,
      'expatriate_since': expatriateSince.text,
      'plan_stop_expat': planToStopExpat.text,
    };

    try {
      await userService.updateUserData(updatedData, memberId.value);
      dashBoardController.refreshData();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'emergency_contact_name', emergencyContactName.text);
      await prefs.setString(
          'emergency_contact_number', emergencyContactNumber.text);
      await prefs.setString('expatriate_since', expatriateSince.text);
      await prefs.setString('plan_stop_expat', planToStopExpat.text);
      dashBoardController.refreshData();

      _isLoading.value = false;
      return true;
    } catch (e) {
      _isLoading.value = false;
      return false;
    }
  }
}
