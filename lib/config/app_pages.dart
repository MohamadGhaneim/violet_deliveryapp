import 'package:deliveryapp/bindings/login_binding.dart';
import 'package:deliveryapp/bindings/notification_binding.dart';
import 'package:deliveryapp/bindings/order_binding.dart';
import 'package:deliveryapp/bindings/order_details_binding.dart';
import 'package:deliveryapp/bindings/payment_binding.dart';
import 'package:deliveryapp/bindings/profile_binding.dart';
import 'package:deliveryapp/bindings/root_binding.dart';
import 'package:deliveryapp/bindings/setting_binding.dart';
import 'package:deliveryapp/config/app_routes.dart';
import 'package:deliveryapp/pages/forgot_password.dart';
import 'package:deliveryapp/pages/login_page.dart';
import 'package:deliveryapp/pages/notifications_screen.dart';
import 'package:deliveryapp/pages/order_details_screen.dart';
import 'package:deliveryapp/pages/payment_screen.dart';
import 'package:deliveryapp/pages/profile_screen.dart';
import 'package:deliveryapp/pages/root_page.dart';
import 'package:deliveryapp/pages/splash_screen.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.editProfile, page: () => ProfileScreen()),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.rootPage,
      page: () => RootPage(),
      bindings: [
        RootBinding(),
        OrdeBinding(),
        SettingBinding(),
        ProfileBinding(),
      ], // add other main pages binding
    ),
    GetPage(
      name: AppRoutes.orderDetails,
      page: () => OrderDetailsScreen(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => NotificationsScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => PaymentScreen(),
      binding: PaymentBinding(),
    ),
    GetPage(name: AppRoutes.forgotPassword, page: () => ForgotPassword()),
  ];
}
