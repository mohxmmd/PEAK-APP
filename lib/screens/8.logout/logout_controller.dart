import 'package:peak_app/screens/2.login/login_screen.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<void> logout() async {
    _isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      Get.offAll(() => LoginScreen());
    } finally {
      _isLoading.value = false;
    }
  }
}
