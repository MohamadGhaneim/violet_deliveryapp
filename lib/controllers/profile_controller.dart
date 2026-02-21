import 'dart:io';
import 'package:deliveryapp/controllers/Interactor/profile_interactor.dart';
import 'package:deliveryapp/util/model/delivery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final ProfileInteractor profileInteractor;
  ProfileController(this.profileInteractor);
  // delivery
  var delivery = Rxn<Delivery>();
  var isSaving = false.obs;
  // Controllers for text fields
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Profile image
  final Rx<File?> profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final RxBool isPickingImage = false.obs;

  /// Pick image from gallery
  Future<void> pickImage() async {
    isPickingImage.value = true;

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();

      delivery.value = Delivery(
        username: delivery.value?.username ?? '',
        fullName: fullNameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        picture: bytes,
      );
    }

    isPickingImage.value = false;
  }

  Future<void> saveProfile() async {
    try {
      isSaving.value = true;
      final newDelivery = Delivery(
        username: delivery.value?.username ?? '',
        email: emailController.text,
        phoneNumber: phoneController.text,
        fullName: fullNameController.text,
        picture: delivery.value?.picture,
      );

      await profileInteractor.updateDelivery(newDelivery);

      Get.snackbar(
        "Success!",
        "Update successful",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        "Failed!",
        "Update Failed",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      throw Exception("ProfileController saveProfile : $e");
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> loadProfile() async {
    try {
      final user = await profileInteractor.getDelivery();
      delivery.value = user;
      emailController.text = user.email;
      phoneController.text = user.phoneNumber;
      fullNameController.text = user.fullName;
      // print(
      //   "Loaded profile: "
      //   "${user.email}, "
      //   "${user.phoneNumber}, "
      //   "${user.fullName}, "
      //   "image: ${user.picture}",
      // );
    } catch (e) {
      throw Exception("ProfileController loadProfile : $e");
    }
  }

  @override
  void onInit() {
    loadProfile();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
