import 'package:peak_app/routes/routes.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/alert.dart';
import 'package:peak_app/services/otp_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInController extends GetxController {
  final whatsAppNumberController = TextEditingController();
  final selectedCountryCode = '91'.obs;
  final selectedISOCode = 'IN'.obs;
  final currentLanguage = Get.locale?.languageCode.obs ?? 'EN'.obs;

  @override
  void dispose() {
    whatsAppNumberController.dispose();
    super.dispose();
  }

  void updateCountryDetails(String newCode, String newISOCode) {
    selectedCountryCode.value = newCode;
    selectedISOCode.value = newISOCode;
  }

  void updateLanguage(Locale newLanguage) {
    currentLanguage.value = newLanguage.languageCode;
    Get.updateLocale(newLanguage); // Update the app's locale
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final OtpService otpService = OtpService();

  void verifyNumber() async {
    final whatsAppNumber =
        '${selectedCountryCode.value.replaceAll('+', '')}${whatsAppNumberController.text.replaceAll(' ', '')}';

    _isLoading.value = true;

    try {
      final isSuccess =
          await otpService.verifyAndSendOTP(whatsAppNumber: whatsAppNumber);

      if (isSuccess) {
        _showAlert('OTP sent successfully to $whatsAppNumber');
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('whatsappNumber', whatsAppNumber);
        goToOtpVerification();
      } else {
        _showAlert('Whatsapp number is not registered');
      }
    } catch (e) {
      _showAlert('Check internet connection');
    } finally {
      _isLoading.value = false;
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: Get.context!,
      builder: (context) => CustomAlertDialog(message: message),
    );
  }

  void goToOtpVerification() {
    Get.offAndToNamed(Routes.otpScreen);
  }
}
