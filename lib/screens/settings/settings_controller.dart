import 'package:peak_app/utils/screen_imports.dart';

class SettingsController extends GetxController {
  var currentLanguage = 'en'.obs; 
  void updateLanguage(Locale newLanguage) {
    currentLanguage.value = newLanguage.languageCode;
    Get.updateLocale(newLanguage); 
  }
}
