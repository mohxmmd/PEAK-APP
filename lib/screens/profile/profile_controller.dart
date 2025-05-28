import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peak_app/routes/routes.dart';
import 'package:peak_app/screens/dashboard/dashboard_controller.dart';
import 'package:peak_app/services/user_service.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var userName = ''.obs;
  var userImage = ''.obs;
  var userJob = ''.obs;
  var userMail = ''.obs;
  var userId = 0.obs;
  final UserService userService = UserService();
  final DashBoardController dashBoardController =
      Get.find<DashBoardController>();

  final apiUrl = dotenv.env['API_URL'];

  final ImagePicker _picker = ImagePicker();
  final Rxn<File> profileImage = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('name') ?? 'User Name';
    userImage.value = prefs.getString('profile_picture') ?? '';
    userJob.value = prefs.getString('job_title') ?? 'Job';
    userId.value = prefs.getInt('member_id') ?? 0;
    userMail.value = prefs.getString('email_id') ?? 'email';
  }

  Future<File?> _compressImage(File file) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath =
          "${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

      // Get original file size
      final originalSize = await file.length();
      debugPrint('Original image size: ${originalSize / 1024} KB');

      // First compression attempt
      XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 70,
        format: CompressFormat.jpeg,
        minWidth: 1080,
        minHeight: 1080,
      );

      if (compressedXFile == null) return null;

      // Convert XFile to File
      File compressedFile = File(compressedXFile.path);
      var compressedSize = await compressedFile.length();
      debugPrint('First compression size: ${compressedSize / 1024} KB');

      // If still too large, compress further
      if (compressedSize > 1000000) {
        compressedXFile = await FlutterImageCompress.compressAndGetFile(
          compressedFile.path,
          targetPath.replaceAll('.jpg', '_2.jpg'),
          quality: 50,
        );

        if (compressedXFile == null) return compressedFile;

        compressedFile = File(compressedXFile.path);
        compressedSize = await compressedFile.length();
        debugPrint('Second compression size: ${compressedSize / 1024} KB');
      }

      return compressedFile;
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return file; // Return original if compression fails
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    final prefs = await SharedPreferences.getInstance();

    if (pickedFile != null) {
      final originalFile = File(pickedFile.path);
      final compressedFile = await _compressImage(originalFile);

      if (compressedFile != null) {
        profileImage.value = compressedFile;
        await updateProfilePicture();
        var userData = await userService.getUserData();
        prefs.setString('profile_picture', userData['profile_picture']);
        userService.saveUserDataToLocal();
        dashBoardController.refreshData();
      }
    } else {
      Get.snackbar(
        "Image Selection",
        "No image selected.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void takePhoto() async {
    final prefs = await SharedPreferences.getInstance();
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final originalFile = File(pickedFile.path);
      final compressedFile = await _compressImage(originalFile);

      if (compressedFile != null) {
        profileImage.value = compressedFile;
        await updateProfilePicture();
        var userData = await userService.getUserData();
        prefs.setString('profile_picture', userData['profile_picture']);
        userService.saveUserDataToLocal();
        dashBoardController.refreshData();
      }
    }
  }

  Future<void> updateProfilePicture() async {
    if (profileImage.value == null) {
      Get.snackbar(
        "Error",
        "No image selected to upload.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _isLoading.value = true;
    update();

    Map<String, dynamic> registrationData = {
      'profile_picture': profileImage.value!.path,
    };

    try {
      await userService.updateUserData(registrationData, userId.value);
      userImage.value = profileImage.value!.path;
      await userService.saveUserDataToLocal();
      dashBoardController.refreshData();

      Get.snackbar(
        "Success",
        "Profile picture updated successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update profile picture. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  void goToProfile() {
    Get.toNamed(Routes.profileScreen);
  }

  void goToPersonalInfo() {
    Get.toNamed(Routes.personalInfoScreen);
  }

  void goToProfessionalInfo() {
    Get.toNamed(Routes.professionalInfoScreen);
  }

  void goToAdditionalInfo() {
    Get.toNamed(Routes.additionalInfoScreen);
  }

  void goToDeleteAccount() {
    Get.toNamed(Routes.deleteAccountScreen);
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
}
