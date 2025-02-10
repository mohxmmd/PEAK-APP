import 'package:peak_app/screens/update_profile/personal_information/personal_info_controller.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/back_button.dart';
import 'package:peak_app/widgets/button.dart';
import 'package:peak_app/widgets/input_fields/drop_down_field.dart';
import 'package:peak_app/widgets/input_fields/input_field.dart';

class PersonalInfoScreen extends StatelessWidget {
  final controller = Get.put(PersonalInfoController());
  final _formKey = GlobalKey<FormState>();

  PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true, 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildSectionTitle(context, 'reg-personal-info'.tr),
                const Divider(color: Colors.white24, thickness: 1, height: 30),
                const SizedBox(height: 20),
                _buildFormFields(context),
                const SizedBox(height: 30),
                Obx(
                  () => CustomElevatedButton(
                    label: controller.isLoading ? '' : 'Save',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.updatePersonalInfo().then((success) {
                          if (success) {
                            Get.back();
                            Get.snackbar(
                              'Success',
                              'Profile Updated Successfully',
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          } else {
                            Get.snackbar(
                              'Error'.tr,
                              'Failed to update profile'.tr,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        });
                      }
                    },
                    labelStyle: Theme.of(context).textTheme.displayMedium ??
                        const TextStyle(),
                    isLoading: controller.isLoading,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Align(alignment: Alignment.centerLeft, child: CustomBackButton()),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
          label: 'local-address-label'.tr,
          hintText: 'local-address-hint'.tr,
          icon: Icons.home_outlined,
          controller: controller.localAddressController,
          validator: (value) =>
              value?.isEmpty == true ? 'error-local-address'.tr : null,
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'fathers-name-label'.tr,
          hintText: 'fathers-name-hint'.tr,
          icon: Icons.person_outline,
          controller: controller.fathersNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'error-fathers-name'.tr; 
            } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
              return 'invalid-fathers-name'
                  .tr; 
            }
            return null; 
          },
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'mobile-number-label'.tr,
          hintText: 'mobile-number-hint'.tr,
          icon: Icons.phone_android_rounded,
          controller: controller.mobileNumberController,
          isNumeric: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'error-mobile-number'.tr; 
            } else if (!RegExp(r"^\+?\d{1,3}[\s\-]?\d{10}$").hasMatch(value)) {
              return 'invalid-mobile-number'
                  .tr; 
            }
            return null; 
          },
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'email-label'.tr,
          hintText: 'email-hint'.tr,
          icon: Icons.email_outlined,
          controller: controller.emailAddressController,
          validator: (value) {
            if (value?.isEmpty == true) return 'error-email'.tr;
            const emailPattern =
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
            final regExp = RegExp(emailPattern);
            if (!regExp.hasMatch(value!)) return 'invalid-email'.tr;
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'contact-number-label'.tr,
          hintText: 'contact-number-hint'.tr,
          icon: Icons.call,
          controller: controller.localContactController,
          isNumeric: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'error-contact-number'.tr; 
            } else if (!RegExp(r"^\+?\d{1,3}[\s\-]?\d{10}$").hasMatch(value)) {
              return 'invalid-mobile-number'
                  .tr; 
            }
            return null; 
          },
        ),
        const SizedBox(height: 20),
        CustomDropdownField(
          label: 'marital-status-label'.tr,
          hintText: 'marital-status-hint'.tr,
          icon: Icons.favorite_border,
          options: const [
            'Single',
            'Married',
            'Divorced',
            'Widowed',
          ],
          controller: controller.maritalStatusController,
          validator: (value) =>
              value?.isEmpty == true ? 'error-marital-status'.tr : null,
        ),
      ],
    );
  }
}
