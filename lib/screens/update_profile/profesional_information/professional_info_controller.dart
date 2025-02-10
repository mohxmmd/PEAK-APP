import 'package:peak_app/screens/dashboard/dashboard_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/user_service.dart';

class ProfessionalInfoController extends GetxController {
  final highestEducationController = TextEditingController();
  final courseCompletedController = TextEditingController();
  final countryOfResidenceController = TextEditingController();
  final cityOfResidenceController = TextEditingController();
  final residentialAddressController = TextEditingController();
  final companyNameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final totalYearsExperienceController = TextEditingController();

  final RxBool termsAndCondition = true.obs; 
  final _isLoading = false.obs;

  final DashBoardController dashBoardController =
      Get.find<DashBoardController>();

  bool get isLoading => _isLoading.value;

  RxInt memberId = 0.obs;
  final UserService userService = UserService();

  RxList<String> countries = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId.value = prefs.getInt('member_id') ?? 0;
    await userService.saveUserDataToLocal();

    highestEducationController.text =
        prefs.getString('highest_education') ?? '';
    courseCompletedController.text = prefs.getString('course_completed') ?? '';
    countryOfResidenceController.text =
        prefs.getString('country_of_residence') ?? '';
    cityOfResidenceController.text = prefs.getString('city_of_residence') ?? '';
    residentialAddressController.text =
        prefs.getString('residential_address') ?? '';
    companyNameController.text = prefs.getString('company_name') ?? '';
    jobTitleController.text = prefs.getString('job_title') ?? '';
    totalYearsExperienceController.text =
        prefs.getString('total_years_experience') ?? '';

    countries.value = prefs.getStringList('countries') ??
        ['UAE', 'India', 'Qatar', 'Saudi', 'USA', 'Canada'];
  }

  Future<bool> updateProfessionalInfo() async {
    _isLoading.value = true;

    Map<String, dynamic> updatedData = {
      'highest_education': highestEducationController.text,
      'course_completed': courseCompletedController.text,
      'country_of_residence': countryOfResidenceController.text,
      'city_of_residence': cityOfResidenceController.text,
      'residential_address': residentialAddressController.text,
      'company_name': companyNameController.text,
      'job_title': jobTitleController.text,
      'total_years_experience': totalYearsExperienceController.text,
    };

    try {
      // Call API to update user data
      await UserService().updateUserData(updatedData, memberId.value);

      // Update shared preferences after data is uploaded
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'highest_education', highestEducationController.text);
      await prefs.setString('course_completed', courseCompletedController.text);
      await prefs.setString(
          'country_of_residence', countryOfResidenceController.text);
      await prefs.setString(
          'city_of_residence', cityOfResidenceController.text);
      await prefs.setString(
          'residential_address', residentialAddressController.text);
      await prefs.setString('company_name', companyNameController.text);
      await prefs.setString('job_title', jobTitleController.text);
      await prefs.setString(
          'total_years_experience', totalYearsExperienceController.text);
      dashBoardController.refreshData();

      _isLoading.value = false;
      return true;
    } catch (e) {
      _isLoading.value = false;
      return false;
    }
  }

  // Method to proceed to the next registration step
  void onTapContinue() {
    Get.toNamed('/registrationStep3');
  }
}
