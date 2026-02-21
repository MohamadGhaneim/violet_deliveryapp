import 'package:deliveryapp/components/order_card.dart';
import 'package:deliveryapp/controllers/order_controller.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:deliveryapp/util/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends GetView<OrderController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: RefreshIndicator(
        onRefresh: controller.refreshOrders,
        child: Obx(() {
          final orders = controller.filteredOrders;

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // remark
                SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    children:
                        displayedOrderStatuses.map((status) {
                          final isSelected =
                              controller.selectedStatus.value == status;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 8,
                            ),
                            child: ChoiceChip(
                              label: Text(status.value),
                              selected: isSelected,
                              onSelected:
                                  (_) => controller.changeStatus(status),
                            ),
                          );
                        }).toList(),
                  ),
                ),
                if (controller.isLoading.value)
                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  )
                else if (orders.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Image.asset("assets/images/box_checklist.png"),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder:
                        (context, index) => OrderCard(
                          order: orders[index],
                          onTap:
                              () => controller.goToOrderDetails(orders[index]),
                        ),
                  ),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.scanOnce,
        backgroundColor: AppColors.deepBlue,
        child: const Icon(IconlyLight.scan, color: Colors.white),
      ),
    );
  }
}
