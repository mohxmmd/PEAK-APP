import 'package:peak_app/screens/4.registration/step2/registration_controller_2.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/registration_widgets/heading_widget.dart';
import 'package:peak_app/widgets/input_fields/drop_down_field.dart';
import 'package:peak_app/widgets/input_fields/input_field.dart';
import 'package:peak_app/widgets/button.dart';

class Registration2Screen extends StatelessWidget {
  Registration2Screen({super.key});

  final controller = Get.put(RegistrationController2());
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
                  const SizedBox(height: 20),
                  BuildHeading(
                      text: 'reg-heading'.tr), 
                  const SizedBox(height: 20),
                  BuildSectionTitle(
                      text: 'reg-professional-info'
                          .tr), 
                  const Divider(
                    color: Colors.white24,
                    thickness: 1,
                    height: 30,
                  ),
                  const SizedBox(height: 20),
                  _buildForm(context),
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

  // Form with validation
  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomDropdownField(
            label: 'highest_education'.tr,
            hintText: 'highest_education_hint'.tr,
            icon: Icons.school_outlined,
            options: const ['Below 10', '10', '12', 'Degree', 'PG', 'Diploma'],
            controller: controller.highestEducationController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'highest_education_error'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            label: 'course_completed'.tr,
            hintText: 'course_completed_hint'.tr,
            icon: Icons.book_outlined,
            controller: controller.courseCompletedController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'course_completed_error'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Obx(() {
            return CustomDropdownField(
              label: 'country_of_residence'.tr,
              hintText: 'country_of_residence'.tr,
              icon: Icons.public_outlined,
              options: controller.countries.toList(), 
              controller: controller.countryOfResidenceController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'country_of_residence_error'.tr;
                }
                return null;
              },
            );
          }),
          const SizedBox(height: 20),
          CustomInputField(
            label: 'city_of_residence'.tr,
            hintText: 'city_of_residence'.tr,
            icon: Icons.location_city_outlined,
            controller: controller.cityOfResidenceController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'city_of_residence_error'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            label: 'residential_address'.tr,
            hintText: 'residential_address_hint'.tr,
            icon: Icons.home_outlined,
            controller: controller.residentialAddressController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'residential_address_error'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            label: 'company_name'.tr,
            hintText: 'company_name_hint'.tr,
            icon: Icons.business_outlined,
            controller: controller.companyNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'company_name_error'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            label: 'job_title'.tr,
            hintText: 'job_title_hint'.tr,
            icon: Icons.work_outline,
            controller: controller.jobTitleController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'job_title_error'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            label: 'years_experience'.tr,
            hintText: 'years_experience_hint'.tr,
            icon: Icons.timeline_outlined,
            controller: controller.totalYearsExperienceController,
            isNumeric: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'years_experience_error'.tr;
              }
              if (double.tryParse(value) == null) {
                return 'years_experience_invalid'.tr;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Continue button with validation
  Widget _buildContinueButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: CustomElevatedButton(
          label: 'reg-continue'.tr,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.signUpProcess2();
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
