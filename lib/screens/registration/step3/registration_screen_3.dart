import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/button.dart';
import 'package:peak_app/widgets/input_fields/drop_down_field.dart';
import 'package:peak_app/widgets/input_fields/input_field.dart';
import 'package:peak_app/widgets/registration_widgets/heading_widget.dart';
import 'package:peak_app/screens/registration/step3/registration_controller_3.dart';

class Registration3Screen extends StatelessWidget {
  Registration3Screen({super.key});
  final controller = Get.put(RegistrationController3());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildHeading(text: 'reg-heading'.tr),
                  const SizedBox(height: 20),
                  BuildSectionTitle(text: 'reg-additional-info'.tr),
                  const Divider(
                    color: Colors.white24,
                    thickness: 1,
                    height: 30,
                  ),
                  const SizedBox(height: 20),
                  _buildFormFields(context),
                  const SizedBox(height: 30),
                  _buildContinueButton(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputField(
            label: 'emergency_contact_name'.tr,
            hintText: 'emergency_contact_name_hint'.tr,
            icon: Icons.person_outline,
            controller: controller.emergencyContactName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'emergency_contact_name_error'
                    .tr; 
              } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                return 'emergency_contact_name_invalid'
                    .tr; 
              }
              return null; 
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            label: 'emergency_contact_number'.tr,
            hintText: 'emergency_contact_number_hint'.tr,
            icon: Icons.phone_outlined,
            isNumeric: true,
            controller: controller.emergencyContactNumber,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'emergency_contact_number_error'.tr;
              }
              if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
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
              if (value == null || value.isEmpty) {
                return 'expatriate_since_error'.tr;
              }
              if (!RegExp(r'^\d{4}$').hasMatch(value) ||
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'plan_to_stop_expat_error'.tr;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: CustomElevatedButton(
          label: 'Continue',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.signUpProcess3();
            }
          },
          labelStyle:
              Theme.of(context).textTheme.displayMedium ?? const TextStyle(),
          isLoading: controller.isLoading,
        ),
      ),
    );
  }
}
