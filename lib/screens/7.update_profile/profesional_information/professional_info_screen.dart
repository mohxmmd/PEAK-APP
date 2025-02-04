import 'package:peak_app/screens/7.update_profile/profesional_information/professional_info_controller.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/back_button.dart';
import 'package:peak_app/widgets/button.dart';
import 'package:peak_app/widgets/input_fields/drop_down_field.dart';
import 'package:peak_app/widgets/input_fields/input_field.dart';

class ProfessionalInfoScreen extends StatelessWidget {
  final controller = Get.put(ProfessionalInfoController());
  final _formKey = GlobalKey<FormState>();

  ProfessionalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset:
          true, 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildSectionTitle(context, 'reg-professional-info'.tr),
                const Divider(color: Colors.white24, thickness: 1, height: 30),
                const SizedBox(height: 20),
                _buildFormFields(context),
                const SizedBox(height: 30),
                Obx(
                  () => CustomElevatedButton(
                    label: controller.isLoading ? '' : 'Save',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.updateProfessionalInfo().then((success) {
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
        CustomDropdownField(
          label: 'highest_education'.tr,
          hintText: 'highest_education_hint'.tr,
          icon: Icons.school_outlined,
          options: const ['Below 10', '10', '12', 'Degree', 'PG', 'Diploma'],
          controller: controller.highestEducationController,
          validator: (value) =>
              value?.isEmpty == true ? 'highest_education_error'.tr : null,
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'course_completed'.tr,
          hintText: 'course_completed_hint'.tr,
          icon: Icons.book_outlined,
          controller: controller.courseCompletedController,
          validator: (value) =>
              value?.isEmpty == true ? 'course_completed_error'.tr : null,
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
          hintText: 'city_of_residence_hint'.tr,
          icon: Icons.location_city_outlined,
          controller: controller.cityOfResidenceController,
          validator: (value) =>
              value?.isEmpty == true ? 'city_of_residence_error'.tr : null,
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'residential_address'.tr,
          hintText: 'residential_address_hint'.tr,
          icon: Icons.home_outlined,
          controller: controller.residentialAddressController,
          validator: (value) =>
              value?.isEmpty == true ? 'residential_address_error'.tr : null,
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'company_name'.tr,
          hintText: 'company_name_hint'.tr,
          icon: Icons.business_outlined,
          controller: controller.companyNameController,
          validator: (value) =>
              value?.isEmpty == true ? 'company_name_error'.tr : null,
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'job_title'.tr,
          hintText: 'job_title_hint'.tr,
          icon: Icons.work_outline,
          controller: controller.jobTitleController,
          validator: (value) =>
              value?.isEmpty == true ? 'job_title_error'.tr : null,
        ),
        const SizedBox(height: 20),
        CustomInputField(
          label: 'years_experience'.tr,
          hintText: 'years_experience_hint'.tr,
          icon: Icons.timeline_outlined,
          controller: controller.totalYearsExperienceController,
          isNumeric: true,
          validator: (value) {
            if (value?.isEmpty == true) {
              return 'years_experience_error'.tr;
            }
            if (double.tryParse(value!) == null) {
              return 'years_experience_invalid'.tr;
            }
            return null;
          },
        ),
      ],
    );
  }
}
