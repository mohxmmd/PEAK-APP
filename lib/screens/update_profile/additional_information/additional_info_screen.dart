import 'package:peak_app/screens/update_profile/additional_information/additional_info_controller.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/back_button.dart';
import 'package:peak_app/widgets/button.dart';
import 'package:peak_app/widgets/input_fields/drop_down_field.dart';
import 'package:peak_app/widgets/input_fields/input_field.dart';

class AdditionalInfoScreen extends StatelessWidget {
  AdditionalInfoScreen({super.key});
  final controller = Get.put(AdditionalInfoController());
  final _formKey = GlobalKey<FormState>();

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
                _buildSectionTitle(context, 'reg-additional-info'.tr),
                const Divider(color: Colors.white24, thickness: 1, height: 30),
                const SizedBox(height: 20),
                _buildFormFields(context),
                const SizedBox(height: 30),
                Obx(
                  () => CustomElevatedButton(
                    label: controller.isLoading ? '' : 'Save'.tr,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.updateAdditionalInfo().then((success) {
                          if (success) {
                            Get.back();
                            Get.snackbar(
                              'Success',
                              'Profile updated successfully',
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          } else {
                            Get.snackbar(
                              'Error',
                              'Profile updation failed',
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
          label: 'emergency_contact_name'.tr,
          hintText: 'emergency_contact_name_hint'.tr,
          icon: Icons.person_outline,
          controller: controller.emergencyContactName,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'emergency_contact_name_error'.tr;
            } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
              return 'emergency_contact_name_invalid'.tr;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'emergency_contact_number'.tr,
          hintText: 'emergency_contact_number_hint'.tr,
          icon: Icons.phone_outlined,
          controller: controller.emergencyContactNumber,
          isNumeric: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'emergency_contact_number_error'.tr;
            }
            if (!RegExp(r"^(?:\+?\d{7,15}|00\d{7,15})$").hasMatch(value)) {
              return 'emergency_contact_number_invalid'.tr;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'expatriate_since'.tr,
          hintText: 'expatriate_since_hint'.tr,
          icon: Icons.calendar_today_outlined,
          controller: controller.expatriateSince,
          isNumeric: true,
          validator: (value) {
            if (value?.isEmpty == true) {
              return 'expatriate_since_error'.tr;
            }
            if (!RegExp(r'^\d{4}$').hasMatch(value!) ||
                int.parse(value) > DateTime.now().year) {
              return 'expatriate_since_invalid'.tr;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomDropdownField(
          label: 'plan_to_stop_expat'.tr,
          hintText: 'plan_to_stop_expat_hint'.tr,
          icon: Icons.event_outlined,
          options: const [
            'Within 1 year',
            'Within 2 years',
            'Within 3 years',
            'Within 4 years',
            'Within 5 years',
            'Within 8 years',
            'Within 10 years',
            'Within 15 years'
          ],
          controller: controller.planToStopExpat,
          validator: (value) =>
              value?.isEmpty == true ? 'plan_to_stop_expat_error'.tr : null,
        ),
      ],
    );
  }
}
