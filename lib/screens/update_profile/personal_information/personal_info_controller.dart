import 'package:peak_app/screens/dashboard/dashboard_controller.dart';
import 'package:peak_app/services/other_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/user_service.dart';

class PersonalInfoController extends GetxController {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final whatsappNumberController = TextEditingController();
  final localAddressController = TextEditingController();
  final fathersNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final localContactController = TextEditingController();
  final emailAddressController = TextEditingController();
  final maritalStatusController = TextEditingController();

  final RxString maritalStatus = ''.obs;
  var changeStatus = 0.obs;
  
  final DashBoardController dashBoardController =
      Get.find<DashBoardController>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxInt memberId = 0.obs;
  final UserService userService = UserService();
  final OtherSettings otherSettings = OtherSettings();

  @override
  void onInit() {
    super.onInit();
    _fetchUserData();
    fetchWhatsappNumberChangeStatus();
  }

  String normalizePhoneNumber(String value) {
    return value
        .replaceAll(RegExp(r'[\+\s\-]'), '')
        .replaceFirst(RegExp(r'^0{1,2}'), '');
  }

  Future<void> fetchWhatsappNumberChangeStatus() async {
    final result = await otherSettings.fetchWhatsappNumberChangeStatus();
    changeStatus.value = result['change_status'];
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId.value = prefs.getInt('member_id') ?? 0;
    await userService.saveUserDataToLocal();
    nameController.text = prefs.getString('name') ?? '';
    dobController.text = prefs.getString('date_of_birth') ?? '';
    bloodGroupController.text = prefs.getString('blood_group') ?? '';
    whatsappNumberController.text = prefs.getString('whatsapp_number') ?? '';

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
      'name': nameController.text,
      'date_of_birth': dobController.text,
      'blood_group': bloodGroupController.text,
      'whatsapp_number': normalizePhoneNumber(whatsappNumberController.text),
      'local_address': localAddressController.text,
      'fathers_name': fathersNameController.text,
      'mobile_number': normalizePhoneNumber(mobileNumberController.text),
      'local_contact_number': normalizePhoneNumber(localContactController.text),
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
