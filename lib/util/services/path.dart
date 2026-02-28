class MyPath {
  //static const String _url = "https://c69f-185-187-131-151.ngrok-free.app/api";
  static const String _url = "https://delivery-app-ebex.onrender.com/api";

  // Auth
  static String login = "$_url/login";
  static String loginWithGoogle = "$_url/loginwithgoogle";
  static String logout = "$_url/logout";
  static String forgetPassword = "$_url/forgetpassword";

  // Delivery
  static String getDelivery = "$_url/me";
  static String updateDriver = "$_url/user";

  // Order
  static String allOrdersArchive = "$_url/order/driverarchive";
  static String ordersByDriver = "$_url/order/driver";
  static String updateOrderStatus = "$_url/order/status";
  static String payment = "$_url/order/payment";

  // Notifications
  static String notificationsByUser(int pageNumber) =>
      "$_url/notifications/user?page=$pageNumber";

  static String notificationsRefreshToken = "$_url/notifications/token";
  static String notificationsUpdate = "$_url/notifications/markasread";

  // Payment
  static String paymentTransaction = "$_url/payment_transaction";
}
