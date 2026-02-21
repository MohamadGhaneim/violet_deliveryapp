import 'package:deliveryapp/pages/archive_screen.dart';
import 'package:deliveryapp/pages/home_screen.dart';
import 'package:deliveryapp/pages/setting_screen.dart';
import 'package:deliveryapp/repository/sheard_preferances.dart';
import 'package:deliveryapp/util/model/delivery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  final String fullName;
  var index = 0.obs;
  var delivery = Rxn<Delivery>();
  late PageController pageController;
  late String welcome;
  var hasNotification = false.obs;

  RootController(this.fullName);

  List<Widget> pages = [HomeScreen(), ArchiveScreen(), SettingScreen()];

  void toggleNotification() {
    hasNotification.value = !hasNotification.value;
  }

  String setWelcomeMessage() {
    final hour = DateTime.now().hour;
    //print("NAAAMEEEEEE :${delivery.value?.fullName}");
    // final name =
    //     (delivery.value?.fullName.isNotEmpty ?? false)
    //         ? delivery.value?.fullName
    //         : fullName.isNotEmpty
    //         ? fullName
    //         : 'Guest';

    if (hour >= 18) return "Good Evening ";
    if (hour >= 12) return "Good Afternoon ";
    return "Good Morning ";
  }

  void changePage(int value) {
    index.value = value;
    pageController.jumpToPage(index.value);
  }

  void loadDelivery() async {
    delivery.value = await PrefHelper.getDelivery();
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    loadDelivery();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
