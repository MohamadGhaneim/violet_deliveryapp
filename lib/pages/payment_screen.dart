import 'package:deliveryapp/components/app_add_to_card.dart';
import 'package:deliveryapp/components/app_check_box.dart';
import 'package:deliveryapp/components/app_text_field.dart';
import 'package:deliveryapp/controllers/payment_controller.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:deliveryapp/util/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: AppColors.deepBlue,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.lightGray,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Obx(
              () => Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Toggle Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          borderRadius: BorderRadius.circular(12),
                          isSelected: [
                            controller.isExchangePay.value,
                            !controller.isExchangePay.value,
                          ],
                          onPressed: controller.togglePayment,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text("USD Only"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text("Exchange"),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Inputs
                    if (!controller.isExchangePay.value) ...[
                      AppTextField(
                        hint: "Amount in USD",
                        icon: const Icon(Icons.attach_money),
                        controller: controller.usdController,
                        obscureText: false,
                        inputType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        hint: "Amount in LBP",
                        icon: const Icon(Icons.currency_exchange),
                        controller: controller.lbpController,
                        obscureText: false,
                        inputType: TextInputType.number,
                      ),
                    ] else ...[
                      AppTextField(
                        hint: "Amount in USD",
                        icon: const Icon(Icons.attach_money),
                        controller: controller.usdController,
                        obscureText: false,
                        inputType: TextInputType.number,
                      ),
                    ],
                    const SizedBox(height: 24),

                    /// Confirm Button
                    Obx(
                      () => Column(
                        children: [
                          if (controller.order.value.type == OrderType.normal)
                            AppCheckBox(
                              isChecked: controller.collectExchange.value,
                              label: 'collect Exchange',
                              onChanged: (value) {
                                controller.collectExchange.value =
                                    value ?? false;
                              },
                            ),

                          const SizedBox(height: 24),
                          if (controller.order.value.type == OrderType.exchange)
                            AppAddToCard(
                              text: "Confirm Payment",
                              onPressed: controller.confirmPayment,
                              bgColor: AppColors.green,
                              isload: controller.isload.value,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
