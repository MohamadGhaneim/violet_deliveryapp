import 'package:deliveryapp/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // display profile picture and email at the top
            Obx(() {
              return Card(
                elevation: 10,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        controller.delivery.value?.picture != null
                            ? MemoryImage(controller.delivery.value!.picture!)
                            : AssetImage('assets/images/user.png')
                                as ImageProvider,
                  ),
                  title: Text(controller.delivery.value?.fullName ?? "No Name"),
                  subtitle: Text(
                    controller.delivery.value?.email ?? "No Email",
                  ),
                ),
              );
            }),

            Card(
              elevation: 10,
              child: ListTile(
                trailing: const Icon(Icons.arrow_forward_ios),
                leading: Image.asset(
                  'assets/images/editprofile.png',
                  height: 32,
                  width: 32,
                ),
                title: const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 18),
                ),
                onTap: controller.editProfile,
              ),
            ),

            const SizedBox(height: 10),
            const Divider(),
            Center(
              child: ElevatedButton.icon(
                onPressed: controller.logout,
                icon: const Icon(Icons.logout, color: Colors.white),
                label: Text(
                  "Logout",
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
