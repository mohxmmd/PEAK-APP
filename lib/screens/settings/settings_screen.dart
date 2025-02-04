import 'package:peak_app/screens/settings/settings_controller.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/back_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.find<SettingsController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  Text(
                    'settings'.tr, // Translation key for "Settings"
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.0,
              color: Color(0xFF606363),
            ),
            const SizedBox(height: 20),

            // Language Selector with Label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'change_language'
                        .tr, // Translation key for "Change Language"
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Obx(
                    () => LanguageSelector(
                      currentLanguage: Locale(controller.currentLanguage.value),
                      onLanguageChange: (Locale? locale) {
                        if (locale != null) {
                          controller.updateLanguage(locale);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  final Locale currentLanguage;
  final ValueChanged<Locale?> onLanguageChange;

  const LanguageSelector({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      value: currentLanguage,
      onChanged: onLanguageChange,
      items: const [
        DropdownMenuItem(
          value: Locale('en'),
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: Locale('ml'),
          child: Text('Malayalam'),
        ),
      ],
      icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor),
      style: Theme.of(context).textTheme.bodyLarge,
      underline: const SizedBox(), // Remove the default underline
    );
  }
}
