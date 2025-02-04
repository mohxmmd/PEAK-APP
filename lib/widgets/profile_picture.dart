import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peak_app/screens/4.registration/step1/registration_controller_1.dart';

class ProfilePictureWidget extends StatelessWidget {
  final Registration1Controller controller;

  const ProfilePictureWidget({super.key, required this.controller});

  Future<void> _showImagePickerOptions(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            // Option to capture photo
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Capture Photo'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? photo =
                    await picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  controller.profileImage.value = File(photo.path);
                }
              },
            ),
            // Option to choose from gallery
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  controller.profileImage.value = File(image.path);
                }
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
            // Main image container
            Obx(
              () => GestureDetector(
                onTap: () => _showImagePickerOptions(context),
                child: Container(
                  width: 100,
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(17, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF606363),
                      width: 0.2,
                    ),
                    image: controller.profileImage.value != null
                        ? DecorationImage(
                            image: FileImage(controller.profileImage.value!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: controller.profileImage.value == null
                      ? Icon(
                          Icons.person,
                          color: Colors.grey[600],
                          size: 50,
                        )
                      : null,
                ),
              ),
            ),
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
                    border: Border.all(
                      width: 0.2,
                    ),
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
}
