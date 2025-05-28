import 'package:image/image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:peak_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/services/user_service.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class Registration1Controller extends GetxController {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final localAddressController = TextEditingController();
  final fathersNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final localContactController = TextEditingController();
  final emailAddressController = TextEditingController();
  final maritalStatusController = TextEditingController();

  RxString maritalStatus = ''.obs;

  final ImagePicker _picker = ImagePicker();
  final Rxn<File> profileImage = Rxn<File>();

  final UserService userService = UserService();

  RxBool isSelected = true.obs;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final _isUploadingImage = false.obs;
  bool get isUploadingImage => _isUploadingImage.value;
  final RxDouble _uploadProgress = 0.0.obs;
  double get uploadProgress => _uploadProgress.value;

  final _uploadError = Rxn<String>();
  String? get uploadError => _uploadError.value;

  RxInt memberId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchMemberId();
  }

  @override
  void onClose() {
    nameController.dispose();
    dobController.dispose();
    bloodGroupController.dispose();
    localAddressController.dispose();
    fathersNameController.dispose();
    mobileNumberController.dispose();
    localContactController.dispose();
    emailAddressController.dispose();
    maritalStatusController.dispose();
    profileImage.value = null;
    super.onClose();
  }

  String normalizePhoneNumber(String value) {
    return value
        .replaceAll(RegExp(r'[\+\s\-]'), '')
        .replaceFirst(RegExp(r'^0{1,2}'), '');
  }

  Future<void> _fetchMemberId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId.value = prefs.getInt('member_id') ?? 0;
  }

  Future<File?> _compressImage(File file) async {
    try {
      // Get temporary directory
      final appDocDir = await getApplicationDocumentsDirectory();
      final targetPath =
          '${appDocDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}';

      // Check current file size
      int fileSize = await file.length();
      print('Original file size: ${fileSize / 1024} KB');

      // Start with 90% quality and decrease until under 100KB
      int quality = 90;
      XFile? compressedFile;

      while (quality >= 10 && (fileSize > 100 * 1024 || quality == 90)) {
        compressedFile = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          targetPath,
          quality: quality,
          format: file.path.toLowerCase().endsWith('.png')
              ? CompressFormat.png
              : CompressFormat.jpeg,
        );

        if (compressedFile != null) {
          fileSize = await compressedFile.length();
          print('Compressed to ${fileSize / 1024} KB with quality $quality');
          quality -= 10;
        } else {
          break;
        }
      }

      // If still too large, resize the image dimensions
      if (compressedFile != null &&
          await compressedFile.length() > 100 * 1024) {
        final image = decodeImage(await compressedFile.readAsBytes());
        if (image != null) {
          int newWidth = image.width;
          int newHeight = image.height;

          while (
              await compressedFile!.length() > 100 * 1024 && newWidth > 100) {
            newWidth = (newWidth * 0.9).toInt();
            newHeight = (newHeight * 0.9).toInt();

            compressedFile = await FlutterImageCompress.compressAndGetFile(
              file.absolute.path,
              targetPath,
              quality: 70, // Fixed quality for resizing
              minWidth: newWidth,
              minHeight: newHeight,
              format: file.path.toLowerCase().endsWith('.png')
                  ? CompressFormat.png
                  : CompressFormat.jpeg,
            );

            if (compressedFile != null) {
              print(
                  'Resized to ${newWidth}x${newHeight} - ${await compressedFile.length() / 1024} KB');
            }
          }
        }
      }

      return compressedFile != null ? File(compressedFile.path) : null;
    } catch (e) {
      print('Compression error: $e');
      _uploadError.value = 'Failed to compress image';
      return null;
    }
  }

  Future<void> pickImage({required ImageSource source}) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        _isUploadingImage.value = true;
        _uploadProgress.value = 0;
        _uploadError.value = null;
        update();

        // Convert XFile to File
        final file = File(pickedFile.path);

        // Update progress
        _uploadProgress.value = 0.3;
        update();

        // Compress the image
        final compressedFile = await _compressImage(file);
        _uploadProgress.value = 0.7;
        update();

        if (compressedFile != null) {
          profileImage.value = compressedFile;
          final fileSize = await compressedFile.length();
          _uploadProgress.value = 1.0;

          if (fileSize > 100 * 1024) {
            _uploadError.value =
                'Image is ${(fileSize / 1024).toStringAsFixed(1)}KB (max 100KB)';
          }
        }
      }
    } catch (e) {
      _uploadError.value = 'Failed to process image: ${e.toString()}';
    } finally {
      _isUploadingImage.value = false;
      update();
    }
  }

  Future<void> signUpProcess() async {
    _isLoading.value = true;
    _uploadError.value = null;
    await _fetchMemberId();
    update();

    try {
      Map<String, dynamic> registrationData = {
        'name': nameController.text,
        'date_of_birth': dobController.text,
        'blood_group': bloodGroupController.text,
        'local_address': localAddressController.text,
        'fathers_name': fathersNameController.text,
        'mobile_number': normalizePhoneNumber(mobileNumberController.text),
        'local_contact_number':
            normalizePhoneNumber(localContactController.text),
        'email_id': emailAddressController.text,
        'marital_status': maritalStatusController.text,
        'registration_completed': 1,
      };

      // Handle profile image if exists
      if (profileImage.value != null) {
        final fileSize = await profileImage.value!.length();
        if (fileSize > 100 * 1024) {
          _uploadError.value = 'Image must be under 100KB';
          _isLoading.value = false;
          update();
          return;
        }
        registrationData['profile_picture'] = profileImage.value!.path;
      } else {
        registrationData['profile_picture'] = '';
      }

      await userService.updateUserData(registrationData, memberId.value);
      onTapContinue();
    } catch (e) {
      _uploadError.value = 'Registration failed: ${e.toString()}';
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  void onTapContinue() {
    Get.toNamed(Routes.registrationScreen2);
  }
}
