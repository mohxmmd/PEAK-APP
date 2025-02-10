import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/button.dart';
import 'package:peak_app/widgets/input_fields/otp_input.dart';
import 'otp_controller.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final controller = Get.put(OtpController());
  final otpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle headingStyle = Theme.of(context).textTheme.displayLarge!;
    TextStyle bodyStyle = Theme.of(context).textTheme.bodyLarge!;

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
                  Text(
                    'login-heading'.tr,
                    style: headingStyle,
                  ),
                  const SizedBox(height: 160),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'otp-subtext-1'.tr,
                      style: bodyStyle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'otp-subtext-2'.tr,
                      style: bodyStyle,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OtpInputWidget(
                        formKey: otpFormKey,
                        otpController: controller.otpController,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: CustomElevatedButton(
                              label: 'otp-login'.tr,
                              onPressed: controller.isLoading
                                  ? () {}
                                  : () {
                                      if (otpFormKey.currentState?.validate() ??
                                          false) {
                                        controller.verifyOtp(context);
                                      }
                                    },
                              labelStyle: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'Urbanist',
                              ),
                              isLoading: controller.isLoading,
                            ),
                          ),
                          const SizedBox(height: 10),
                          controller.enableResend.value
                              ? TextButton(
                                  onPressed: controller.resendOtp,
                                  child: const Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF90C764),
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                )
                              : Text(
                                  'Resend OTP in ${controller.minuteRemaining.value}:${controller.secondsRemaining.value.toString().padLeft(2, '0')}',
                                  style: bodyStyle,
                                ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
