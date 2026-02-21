import 'package:deliveryapp/styles/app_colors.dart';
import 'package:deliveryapp/util/model/order.dart';
import 'package:deliveryapp/util/types.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final role = getOrderStatusCustomerOrShopOwner(order.status);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        title: Text(
          order.orderNumber,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // nameof custmer :
            Text(
              role == 'customer'
                  ? "Customer: ${order.customer.fullName}"
                  : "Shop: ${order.shop.name}",
            ),
            Text(
              "${order.estimatedDeliveryTime.day}/${order.estimatedDeliveryTime.month}/${order.estimatedDeliveryTime.year}",
              style: const TextStyle(fontSize: 12, color: AppColors.deepBlue),
            ),

            // Text(
            //   role == 'shopOwner'
            //       ? "Shop  location: ${order.shop.location}"
            //       : "Customer location: ${order.deliveryLocation}",
            // ),
            // Text(
            //   role == 'customer'
            //       ? "Shop  location: ${order.shop.location}"
            //       : "Customer location: ${order.deliveryLocation.link}",
            // ),
            Text("Total: \$${order.total}"),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              order.status.value,
              style: TextStyle(
                color: order.status.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(order.priority),
          ],
        ),
      ),
    );
  }
}
