import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/button.dart';
import 'package:peak_app/widgets/input_fields/date_field.dart';
import 'package:peak_app/widgets/input_fields/drop_down_field.dart';
import 'package:peak_app/widgets/input_fields/input_field.dart';
import 'package:peak_app/widgets/profile_picture.dart';
import 'package:peak_app/widgets/registration_widgets/heading_widget.dart';
import 'package:peak_app/screens/registration/step1/registration_controller_1.dart';

class Registration1Screen extends StatelessWidget {
  Registration1Screen({super.key});

  final controller = Get.put(Registration1Controller());
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
                  ProfilePictureWidget(controller: controller),
                  const SizedBox(height: 10),
                  BuildSectionTitle(text: 'reg-personal-info'.tr),
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
            label: 'name-label'.tr,
            hintText: 'name-hint'.tr,
            icon: Icons.person_outline_outlined,
            controller: controller.nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'error-name'.tr; // Error if field is empty
              } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                return 'invalid-fathers-name'
                    .tr; // Error if invalid characters are present
              }
              return null; // Valid input
            },
          ),
          const SizedBox(height: 20),
          DateInputField(
            label: 'dob-label'.tr,
            hintText: 'dob-hint'.tr,
            icon: Icons.date_range_outlined,
            controller: controller.dobController,
            validator: (value) =>
                value == null || value.isEmpty ? 'error-dob'.tr : null,
          ),
          const SizedBox(height: 20),
          CustomDropdownField(
            label: 'blood-group-label'.tr,
            hintText: 'blood-group-hint'.tr,
            icon: Icons.water_drop_outlined,
            options: const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
            controller: controller.bloodGroupController,
            validator: (value) =>
                value == null || value.isEmpty ? 'error-blood-group'.tr : null,
          ),
          const SizedBox(height: 20),
          CustomInputField(
            label: 'local-address-label'.tr,
            hintText: 'local-address-hint'.tr,
            icon: Icons.home_outlined,
            controller: controller.localAddressController,
            validator: (value) => value == null || value.isEmpty
                ? 'error-local-address'.tr
                : null,
          ),
          const SizedBox(height: 20),
          CustomInputField(
            label: 'fathers-name-label'.tr,
            hintText: 'fathers-name-hint'.tr,
            icon: Icons.person_outline,
            controller: controller.fathersNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'error-fathers-name'.tr; // Error if field is empty
              } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                return 'invalid-fathers-name'
                    .tr; // Error if invalid characters are present
              }
              return null; // Valid input
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
                return 'error-mobile-number'.tr; // Error if field is empty
              } else if (!RegExp(r"^(?:\+?\d{7,15}|00\d{7,15})$")
                  .hasMatch(value)) {
                return 'invalid-mobile-number'
                    .tr; // Error if not a valid mobile number with country code
              }
              return null; // Valid input
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
                return 'error-contact-number'.tr; // Error if field is empty
              } else if (!RegExp(r"^(?:\+?\d{7,15}|00\d{7,15})$")
                  .hasMatch(value)) {
                return 'invalid-mobile-number'
                    .tr; // Error if not a valid mobile number with country code
              }
              return null; // Valid input
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            label: 'email-label'.tr,
            hintText: 'email-hint'.tr,
            icon: Icons.mail_outline_outlined,
            controller: controller.emailAddressController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'error-email'.tr;
              }

              // Email validation regex
              final emailRegExp =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              if (!emailRegExp.hasMatch(value)) {
                return 'error-invalid-email'
                    .tr; // This will point to the invalid email message
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomDropdownField(
            label: 'marital-status-label'.tr,
            hintText: 'marital-status-hint'.tr,
            icon: Icons.favorite_border_outlined,
            options: const [
              'Single',
              'Married',
              'Divorced',
              'Widowed',
            ],
            controller: controller.maritalStatusController,
            validator: (value) => value == null || value.isEmpty
                ? 'error-marital-status'.tr
                : null,
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
          label: 'reg-continue'.tr,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.signUpProcess();
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
    );
  }
}
