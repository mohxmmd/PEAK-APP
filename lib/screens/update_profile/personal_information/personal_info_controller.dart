import 'package:peak_app/screens/dashboard/dashboard_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/user_service.dart';

class PersonalInfoController extends GetxController {
  final localAddressController = TextEditingController();
  final fathersNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final localContactController = TextEditingController();
  final emailAddressController = TextEditingController();
  final maritalStatusController = TextEditingController();

  final RxString maritalStatus = ''.obs;

  final DashBoardController dashBoardController =
      Get.find<DashBoardController>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxInt memberId = 0.obs;
  final UserService userService = UserService();

  @override
  void onInit() {
    super.onInit();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId.value = prefs.getInt('member_id') ?? 0;
    await userService.saveUserDataToLocal();

    localAddressController.text = prefs.getString('local_address') ?? '';
    fathersNameController.text = prefs.getString('fathers_name') ?? '';
    mobileNumberController.text = prefs.getString('mobile_number') ?? '';
    localContactController.text = prefs.getString('local_contact_number') ?? '';
    emailAddressController.text = prefs.getString('email_id') ?? '';
    maritalStatusController.text = prefs.getString('marital_status') ?? '';
    maritalStatus.value = prefs.getString('marital_status') ?? '';
    maritalStatusController.text = maritalStatus.value;

  }

  void updateMaritalStatus(String status) {
    maritalStatus.value = status;
    maritalStatusController.text = status;
  }

  Future<bool> updatePersonalInfo() async {
    _isLoading.value = true;

    Map<String, dynamic> updatedData = {
      'local_address': localAddressController.text,
      'fathers_name': fathersNameController.text,
      'mobile_number': mobileNumberController.text,
      'local_contact_number': localContactController.text,
      'email_id': emailAddressController.text,
      'marital_status': maritalStatusController.text, 
    };

    try {
      await UserService().updateUserData(updatedData, memberId.value);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('local_address', localAddressController.text);
      await prefs.setString('fathers_name', fathersNameController.text);
      await prefs.setString('mobile_number', mobileNumberController.text);
      await prefs.setString(
          'local_contact_number', localContactController.text);
      await prefs.setString('email_id', emailAddressController.text);
      await prefs.setString('marital_status', maritalStatusController.text);
      dashBoardController.refreshData();

      _isLoading.value = false;
      return true;
    } catch (e) {
      _isLoading.value = false;
      return false;
    }
  }
}
