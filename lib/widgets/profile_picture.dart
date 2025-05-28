import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peak_app/screens/registration/step1/registration_controller_1.dart';

class ProfilePictureWidget extends StatelessWidget {
  final Registration1Controller controller;

  const ProfilePictureWidget({super.key, required this.controller});

  Future<void> _showImagePickerOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Capture Photo'),
              onTap: () async {
                Navigator.pop(context);
                await controller.pickImage(source: ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await controller.pickImage(source: ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 15),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Obx(() {
              // Show loading state
              if (controller.isUploadingImage) {
                return _buildUploadingContainer();
              }

              // Show error state
              if (controller.uploadError != null) {
                return _buildErrorContainer(context);
              }

              // Show normal state
              return _buildImageContainer(context);
            }),
            // Camera icon overlay
            Positioned(
              bottom: -10,
              right: 38.5,
              child: GestureDetector(
                onTap: () => _showImagePickerOptions(context),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFF90C764),
                    shape: BoxShape.circle,
                    border: Border.all(width: 0.2),
                  ),
                  child: const Icon(Icons.camera_alt_outlined,
                      color: Colors.white, size: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadingContainer() {
    return Container(
      width: 100,
      height: 110,
      decoration: BoxDecoration(
        color: const Color.fromARGB(17, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF606363), width: 0.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: controller.uploadProgress,
            strokeWidth: 2,
          ),
          const SizedBox(height: 8),
          Text(
            '${(controller.uploadProgress * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorContainer(BuildContext context) {
    return Tooltip(
      message: controller.uploadError ?? 'Image error',
      child: GestureDetector(
        onTap: () => _showImagePickerOptions(context),
        child: Container(
          width: 100,
          height: 110,
          decoration: BoxDecoration(
            color: const Color.fromARGB(17, 255, 255, 255),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red, width: 1),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 30),
              SizedBox(height: 4),
              Text('Try Again',
                  style: TextStyle(fontSize: 10, color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImagePickerOptions(context),
      child: Container(
        width: 100,
        height: 110,
        decoration: BoxDecoration(
          color: const Color.fromARGB(17, 255, 255, 255),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF606363), width: 0.2),
          image: controller.profileImage.value != null
              ? DecorationImage(
                  image: FileImage(controller.profileImage.value!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: controller.profileImage.value == null
            ? Icon(Icons.person, color: Colors.grey[600], size: 50)
            : FutureBuilder<int>(
                future: controller.profileImage.value?.length(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final sizeKB = snapshot.data! / 1024;
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        color: Colors.black54,
                        child: Text(
                          '${sizeKB.toStringAsFixed(1)}KB',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
      ),
    );
  }
}
