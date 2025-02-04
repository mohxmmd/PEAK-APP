import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:get/get.dart';
import 'package:peak_app/screens/2.login/login_controller.dart';

class WhatsAppInput extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LogInController controller = Get.put(LogInController());

  WhatsAppInput(
      {required this.formKey,
      super.key,
      required TextEditingController controller});

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle = Theme.of(context).textTheme.bodyLarge!;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Obx(
            () => InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                controller.updateCountryDetails(
                    number.dialCode!, number.isoCode!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (!RegExp(r'^\+?[1-9]\d{0,3}(?:[ ]?\d+)+$').hasMatch(value)) {
                  return 'Enter a valid phone number';
                }
                return null; // Validation passed
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                showFlags: true,
                setSelectorButtonAsPrefixIcon: true,
                leadingPadding: 12.0,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: bodyStyle,
              initialValue: PhoneNumber(
                isoCode: controller.selectedISOCode.value,
                dialCode: '+${controller.selectedCountryCode.value}',
              ),
              textFieldController: controller.whatsAppNumberController,
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: false,
              ),
              inputDecoration: InputDecoration(
                labelText: 'login-whatsappnumber'.tr,
                fillColor: Colors.transparent,
                filled: true,
                labelStyle: bodyStyle,
                hintText: 'login-whatsappnumber'.tr,
                hintStyle: bodyStyle,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
              textStyle: bodyStyle,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ],
      ),
    );
  }
}
