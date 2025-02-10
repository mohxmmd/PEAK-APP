import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/button.dart';
import 'package:peak_app/widgets/input_fields/whatsappnumber_input.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LogInController());
  final whatsAppNumberFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.displayLarge!;
    final labelStyle = Theme.of(context).textTheme.displayMedium!;
    final bodyStyle = Theme.of(context).textTheme.bodyLarge!;

    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'login-heading'.tr,
                          style: headingStyle,
                          textAlign: TextAlign.center,
                        ),
                        Positioned(
                          right: 0,
                          child: Obx(
                            () => LanguageSelector(
                              currentLanguage: controller.currentLanguage.value,
                              onLanguageChange: controller.updateLanguage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 160),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('login-subtext-1'.tr, style: bodyStyle),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('login-subtext-2'.tr, style: bodyStyle),
                  ),
                  const SizedBox(height: 30),
                  // WhatsApp Input
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('login-mobile'.tr, style: labelStyle),
                    ),
                  ),
                  const SizedBox(height: 20),
                  WhatsAppInput(
                      formKey: whatsAppNumberFormKey,
                      controller: controller.whatsAppNumberController),
                  const SizedBox(height: 20),
                  Obx(
                    () => SizedBox(
                      child: CustomElevatedButton(
                        label: 'login-getotp'.tr,
                        onPressed: () {
                          if (whatsAppNumberFormKey.currentState?.validate() ??
                              false) {
                            controller.verifyNumber();
                          }
                        },
                        labelStyle: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Urbanist', // Change to Urbanist font
                        ),
                        isLoading: controller.isLoading,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Language Selector Widget
class LanguageSelector extends StatelessWidget {
  final String currentLanguage;
  final Function(Locale) onLanguageChange;

  const LanguageSelector({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      onSelected: onLanguageChange,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.language, color: Theme.of(context).primaryColor),
          const SizedBox(width: 5),
          Text(
            currentLanguage,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: Locale('en'),
          child: Text('English'),
        ),
        const PopupMenuItem(
          value: Locale('ml'),
          child: Text('Malayalam'),
        ),
      ],
    );
  }
}
