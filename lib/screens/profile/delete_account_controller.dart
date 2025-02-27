import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:peak_app/screens/login/login_screen.dart';
import 'package:peak_app/services/user_service.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountController extends GetxController {
  final UserService userService = UserService();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> deleteUserAccount() async {
    try {
      bool isDeleted = await userService.deleteAccount();

      if (isDeleted) {
        await logout();
        Get.offAll(() => LoginScreen());
        Get.snackbar(
          'Success',
          'Your account has been deleted successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete your account. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while deleting your account. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all local data
    } catch (e) {
      // Handle any exceptions during logout
      print('Error during logout: $e');
    }
  }
}
