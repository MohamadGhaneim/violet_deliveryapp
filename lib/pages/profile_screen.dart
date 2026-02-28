import 'package:deliveryapp/components/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:deliveryapp/components/app_text_field.dart';
import 'package:deliveryapp/components/user_avatar.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Obx(
                () => Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(130),
                        child:
                            controller.delivery.value?.picture != null
                                ? Image.memory(
                                  controller.delivery.value!.picture!,
                                  height: 180,
                                  width: 180,
                                  fit: BoxFit.cover,
                                )
                                : UserAvatar(
                                  height: 130,
                                  width: 130,
                                  img: 'assets/images/user.png',
                                ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: controller.pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:
                              controller.isPickingImage.value
                                  ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.black,
                                    ),
                                  )
                                  : const Icon(IconlyBold.camera, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.black),
              SizedBox(height: 20),
              AppTextField(
                hint: "Email",
                icon: const Icon(Icons.email),
                controller: controller.emailController,
              ),
              SizedBox(height: screenHeight * 0.02),
              AppTextField(
                hint: "Phone number",
                icon: const Icon(Icons.phone),
                controller: controller.phoneController,
              ),
              SizedBox(height: screenHeight * 0.02),
              AppTextField(
                hint: "Full Name",
                icon: const Icon(Icons.person),
                controller: controller.fullNameController,
              ),
              SizedBox(height: screenHeight * 0.03),

              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    onPressed: controller.saveProfile,
                    text: 'save',
                    isWait: controller.isSaving.value,
                    bgColor: AppColors.deepBlue,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
