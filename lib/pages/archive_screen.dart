import 'package:deliveryapp/components/order_card.dart';
import 'package:deliveryapp/controllers/order_controller.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:deliveryapp/util/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class ArchiveScreen extends GetView<OrderController> {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return ToggleButtons(
                  selectedColor: AppColors.deepBlue,
                  fillColor: AppColors.amberYellow,
                  borderRadius: BorderRadius.circular(12),
                  isSelected: [
                    controller.selectedDeliveryStatus.value ==
                        DeliveryCase.shopOwner,

                    controller.selectedDeliveryStatus.value ==
                        DeliveryCase.customer,
                  ],
                  onPressed: (int index) {
                    if (index == 0) {
                      controller.selectedDeliveryStatus.value =
                          DeliveryCase.shopOwner;
                      //controller.setOrdersArchive();
                    } else if (index == 1) {
                      controller.selectedDeliveryStatus.value =
                          DeliveryCase.customer;
                      //controller.setAllOrdersDriver();
                    } else {}
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("shop owner"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("customer"),
                    ),
                  ],
                );
              }),
            ],
          ),
          // date picker
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              final date = controller.selectedDate.value;

              return InkWell(
                onTap: () => controller.pickDate(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.deepBlue,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(IconlyLight.calendar, color: Colors.white),
                      const SizedBox(width: 12),
                      Text(
                        date == null
                            ? 'Select Date '
                            : '${date.day}/${date.month}/${date.year}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      if (date != null)
                        GestureDetector(
                          onTap: () => controller.selectedDate.value = null,
                          child: const Icon(Icons.close, size: 18),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),

          // orders archive
          Obx(() {
            final orders = controller.filterArchiveOrders;

            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.setOrdersArchive();
                },
                child:
                    orders.isEmpty
                        ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            Center(
                              child: Image.asset("assets/images/archive.png"),
                            ),
                          ],
                        )
                        : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: orders.length,
                          itemBuilder:
                              (context, index) => OrderCard(
                                order: orders[index],
                                onTap:
                                    () => controller.goToOrderDetails(
                                      orders[index],
                                    ),
                              ),
                        ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
