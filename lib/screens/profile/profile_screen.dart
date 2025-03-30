import 'package:peak_app/screens/logout/logout_controller.dart';
import 'package:peak_app/screens/update_profile/additional_information/additional_info_controller.dart';
import 'package:peak_app/screens/update_profile/personal_information/personal_info_controller.dart';
import 'package:peak_app/screens/update_profile/profesional_information/professional_info_controller.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/back_button.dart';
import 'package:peak_app/screens/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.put(ProfileController());
  final personalcontroller = Get.put(PersonalInfoController());
  final professionalcontroller = Get.put(ProfessionalInfoController());
  final additionalInfocontroller = Get.put(AdditionalInfoController());
  final logoutController = Get.put(LogOutController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Screen size
    TextStyle headingStyle = Theme.of(context).textTheme.displayLarge!.copyWith(
          fontSize: size.width * 0.05, // Responsive font size
        );

    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.02),
                        // Profile Header
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.05),
                                child: const CustomBackButton(),
                              ),
                            ),
                            Text('profile_title'.tr, style: headingStyle),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        // Profile Picture and Stats Section
                        Obx(
                          () => Column(
                            children: [
                              // Profile Picture
                              _buildProfilePicture(size),
                              SizedBox(height: size.height * 0.01),
                              // User Details
                              Text(
                                controller.userName.value,
                                style: headingStyle,
                              ),
                              Text(
                                controller.userMail.value,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: size.width * 0.035,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        // Fully Expanded Options Section
                        Expanded(
                          child: Container(
                            width: double.infinity, // Full screen width
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.02),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFDFCFA),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: size.height * 0.02),
                                _buildModernOption(
                                  'personal_info'.tr,
                                  Icons.person,
                                  controller.goToPersonalInfo,
                                  size,
                                  const Color(0xFFF9CDB3),
                                ),
                                _buildDivider(size),
                                _buildModernOption(
                                  'professional_info'.tr,
                                  Icons.work,
                                  controller.goToProfessionalInfo,
                                  size,
                                  const Color(0xFFE9D6A6),
                                ),
                                _buildDivider(size),
                                _buildModernOption(
                                  'additional_info'.tr,
                                  Icons.school,
                                  controller.goToAdditionalInfo,
                                  size,
                                  const Color(0xFFF6B6C3),
                                ),
                                _buildDivider(size),
                                _buildModernOption(
                                  'delete_account'.tr,
                                  Icons.delete,
                                  controller.goToDeleteAccount,
                                  size,
                                  const Color.fromARGB(189, 211, 70, 98),
                                ),
                                _buildDivider(size),
                                _buildModernOption(
                                  'logout'.tr,
                                  Icons.logout_rounded,
                                  logoutController.logout,
                                  size,
                                  const Color(0xFFA8D2EF),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildModernOption(
      String title, IconData icon, VoidCallback onTap, Size size, Color color) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: size.height * 0.015,
      ),
      leading: Container(
        padding: EdgeInsets.all(size.width * 0.02),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size.width * 0.02),
        ),
        child: Icon(icon,
            color: const Color.fromARGB(255, 0, 0, 0), size: size.width * 0.05),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: size.width * 0.04,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
          fontFamily: 'Urbanist',
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios,
          color: const Color.fromARGB(47, 255, 255, 255),
          size: size.width * 0.04),
      onTap: onTap,
    );
  }

  Widget _buildDivider(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
      height: size.height * 0.001,
      color: const Color.fromARGB(46, 0, 0, 0),
    );
  }

  Widget _buildProfilePicture(Size size) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: size.height * 0.03,
          top: size.height * 0.015,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Obx(() => GestureDetector(
                  onTap: () async {
                    _showImagePickerOptions();
                  },
                  child: Container(
                    width: size.width * 0.25,
                    height: size.width * 0.27,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(17, 255, 255, 255),
                      borderRadius: BorderRadius.circular(
                          size.width * 0.04), // Responsive radius
                      border: Border.all(
                        color: const Color(0xFF606363),
                        width: size.width * 0.003,
                      ),
                      image: controller.profileImage.value != null
                          ? DecorationImage(
                              image: FileImage(controller.profileImage.value!),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: NetworkImage(
                                'http://www.teampeak.in/storage/${controller.userImage.value}',
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: controller.profileImage.value == null &&
                            controller.userImage.value.isEmpty
                        ? Icon(Icons.person_outline,
                            size: size.width * 0.15, color: Colors.grey)
                        : null,
                  ),
                )),
            Positioned(
              bottom: -size.height * 0.012,
              right: size.width * 0.096,
              child: GestureDetector(
                onTap: _showImagePickerOptions,
                child: Container(
                  width: size.width * 0.05,
                  height: size.width * 0.05,
                  decoration: BoxDecoration(
                    color: const Color(0xFF90C764),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: size.width * 0.003,
                    ),
                  ),
                  child: Icon(Icons.camera_alt_outlined,
                      color: Colors.white, size: size.width * 0.025),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.grey),
              title: const Text('Take a Photo'),
              onTap: () {
                Get.back();
                controller.takePhoto(); // Method for taking a live photo
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.grey),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                controller.pickImage(); // Method for picking from gallery
              },
            ),
          ],
        ),
      ),
    );
  }
}
