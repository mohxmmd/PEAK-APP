import 'package:shared_preferences/shared_preferences.dart';
import 'package:peak_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/user_service.dart';

class RegistrationController2 extends GetxController {
  final highestEducationController = TextEditingController();
  final courseCompletedController = TextEditingController();
  final countryOfResidenceController = TextEditingController();
  final cityOfResidenceController = TextEditingController();
  final residentialAddressController = TextEditingController();
  final companyNameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final totalYearsExperienceController = TextEditingController();

  final UserService userService = UserService();

  RxBool termsAndCondition = true.obs;
  RxBool isSelected = true.obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  RxInt memberId = 0.obs;
  RxList<String> countries = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchMemberId();
  }

  @override
  void onClose() {
    highestEducationController.dispose();
    courseCompletedController.dispose();
    countryOfResidenceController.dispose();
    cityOfResidenceController.dispose();
    residentialAddressController.dispose();
    companyNameController.dispose();
    jobTitleController.dispose();
    totalYearsExperienceController.dispose();

    super.onClose();
  }

  String normalizePhoneNumber(String value) {
    return value.replaceAll(RegExp(r'[\+\s\-]'), '').replaceFirst('00', '');
  }

  Future<void> _fetchMemberId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId.value = prefs.getInt('member_id') ?? 0;
    countries.value = prefs.getStringList('countries') ??
        ['UAE', 'India', 'Qatar', 'Saudi', 'USA', 'Canada'];
  }

  // Register process function
  Future<void> signUpProcess2() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> registrationData = {
      'id': memberId.value,
      "highest_education": highestEducationController.text,
      "course_completed": courseCompletedController.text,
      "country_of_residence": countryOfResidenceController.text,
      "city_of_residence": cityOfResidenceController.text,
      "residential_address": residentialAddressController.text,
      "company_name": companyNameController.text,
      "job_title": jobTitleController.text,
      "total_years_experience": totalYearsExperienceController.text,
      'registration_completed': 2,
    };

    await userService.updateUserData(registrationData, memberId.value);
    onTapContinue();

    _isLoading.value = false;
    update();
  }

  void onTapContinue() {
    Get.toNamed(Routes.registrationScreen3);
  }
}
