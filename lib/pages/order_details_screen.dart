import 'package:deliveryapp/components/app_icon_button.dart';
import 'package:deliveryapp/controllers/order_details_controller.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:deliveryapp/util/model/order.dart';
import 'package:deliveryapp/util/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Order order = controller.order.value;
    OrderActionType actionType = getOrderAction(order.status);
    final role = getOrderStatusCustomerOrShopOwner(order.status);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.deepBlue,
        title: Title(color: Colors.black, child: Text("Order Details")),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.lightGray,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          "assets/images/map.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Open in Google Maps",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text("View route"),
                            const SizedBox(height: 8),

                            AppIconButton(
                              onPress: () {
                                // got to google map
                                controller.openGoogleMap();
                              },
                              icon: IconlyLight.location,
                              text: "Open Google Map",
                              btnColor: AppColors.amberYellow,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ////////////////////////////////////////////
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(color: Colors.black12, offset: Offset.zero),
                    // ],
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.lightGray,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Order ID and status
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Booking id :"),
                                Text(
                                  order.orderNumber,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("status"),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: order.status.color.withValues(
                                      alpha: 0.3,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    order.status.value,
                                    style: TextStyle(
                                      color: order.status.color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const Divider(color: AppColors.deepBlue),

                        // Location info
                        Text(
                          order.deliveryLocation.address,
                          style: TextStyle(fontSize: 14),
                        ),

                        const Divider(color: AppColors.deepBlue),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Contact info :"),
                                Text(
                                  role == 'Customer'
                                      ? "Customer: ${order.customer.fullName}"
                                      : "Shop: ${order.shop.name}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  role == 'Customer'
                                      ? "Customer: ${order.customer.phoneNumber}"
                                      : "Shop: ${order.shop.phoneNumber}",
                                ),
                              ],
                            ),

                            AppIconButton(
                              onPress: () => {controller.openWhatsApp()},
                              icon: IconlyLight.message,
                              text: " Whats'App",
                              colorContent: AppColors.offWhite,
                              btnColor: AppColors.green,
                            ),
                          ],
                        ),
                        const Divider(color: AppColors.deepBlue),

                        // Order info: total, weight, payment status
                        SizedBox(
                          child: Column(
                            children: [
                              //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: AppColors.amberYellow,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total: \$${order.total.toStringAsFixed(2)}",
                                        ),
                                        const Divider(
                                          color: AppColors.deepBlue,
                                        ),
                                        Text(
                                          "Description: ${order.package.description}",
                                        ),
                                        const Divider(
                                          color: AppColors.deepBlue,
                                        ),
                                        Text(
                                          "Weight: ${order.package.weight} kg",
                                        ),
                                        const Divider(
                                          color: AppColors.deepBlue,
                                        ),
                                        Text(
                                          "Payment: ${order.paymentStatus.name}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image.asset(
                                      "assets/images/box_order_details.png",
                                    ),
                                  ),
                                ],
                              ),

                              /// payment ///
                              if (actionType == OrderActionType.scan)
                                IconButton(
                                  icon: Icon(
                                    IconlyLight.scan,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    controller.scanOnce();
                                  },
                                ),
                              if (actionType == OrderActionType.payment)
                                ElevatedButton.icon(
                                  icon: Icon(
                                    IconlyLight.edit,
                                    color: AppColors.offWhite,
                                  ),
                                  label: Text(
                                    "Payment",
                                    style: TextStyle(color: AppColors.offWhite),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 12,
                                    ),
                                    backgroundColor: AppColors.deepBlue,
                                    textStyle: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () {
                                    controller.payment();
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
