import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:peak_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/user_service.dart';

class Registration1Controller extends GetxController {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final localAddressController = TextEditingController();
  final fathersNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final localContactController = TextEditingController();
  final emailAddressController = TextEditingController();
  final maritalStatusController = TextEditingController();

  RxString maritalStatus = ''.obs;

  final ImagePicker _picker = ImagePicker();
  final Rxn<File> profileImage = Rxn<File>();

  final UserService userService = UserService();

  RxBool isSelected = true.obs;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxInt memberId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchMemberId();
  }

  @override
  void onClose() {
    nameController.dispose();
    dobController.dispose();
    bloodGroupController.dispose();
    localAddressController.dispose();
    fathersNameController.dispose();
    mobileNumberController.dispose();
    localContactController.dispose();
    emailAddressController.dispose();
    maritalStatusController.dispose();
    profileImage.value = null;
    super.onClose();
  }

  String normalizePhoneNumber(String value) {
    return value
        .replaceAll(RegExp(r'[\+\s\-]'), '')
        .replaceFirst(RegExp(r'^0{1,2}'), '');
  }

  Future<void> _fetchMemberId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId.value = prefs.getInt('member_id') ?? 0;
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    } else {}
  }

  Future<void> signUpProcess() async {
    _isLoading.value = true;
    await _fetchMemberId();
    update();

    Map<String, dynamic> registrationData = {
      'name':nameController.text,
      'date_of_birth':dobController.text,
      'blood_group':bloodGroupController.text,
      'local_address': localAddressController.text,
      'fathers_name': fathersNameController.text,
      'mobile_number': normalizePhoneNumber(mobileNumberController.text),
      'local_contact_number': normalizePhoneNumber(localContactController.text),
      'email_id': emailAddressController.text,
      'marital_status': maritalStatusController.text,
      'registration_completed': 1,
    };

    if (profileImage.value != null) {
      registrationData['profile_picture'] = profileImage.value!.path;
    } else {
      registrationData['profile_picture'] = '';
    }

    await userService.updateUserData(registrationData, memberId.value);

    onTapContinue();
    _isLoading.value = false;
    update();
  }

  void onTapContinue() {
    Get.toNamed(Routes.registrationScreen2);
  }
}
