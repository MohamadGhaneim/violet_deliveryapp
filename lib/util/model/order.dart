import 'package:deliveryapp/util/model/customer.dart';
import 'package:deliveryapp/util/model/location.dart';
import 'package:deliveryapp/util/model/package.dart';
import 'package:deliveryapp/util/model/shop.dart';
import 'package:deliveryapp/util/types.dart';

class Order {
  final int id; //1 //2
  final String orderNumber;
  final String priority;
  final OrderStatus status; // delivered, on_the_way, pending
  final Package package; // kg
  final double orderCost; // $
  final double deliveryFee; // $
  final double total; // $
  final DateTime estimatedDeliveryTime; // date and time
  final PaymentStatus paymentStatus; // paid / unpaid
  final Location deliveryLocation;
  final Customer customer;
  final OrderType type;
  final int? parentOrderId;
  final Shop shop;

  Order({
    required this.total,
    required this.estimatedDeliveryTime,
    required this.id,
    required this.orderNumber,
    required this.priority,
    required this.deliveryLocation,
    required this.status,
    required this.package,
    required this.orderCost,
    required this.deliveryFee,
    required this.paymentStatus,
    required this.customer,
    required this.shop,
    required this.parentOrderId,
    required this.type,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['orderId'] ?? 0,
      orderNumber: json['orderNumber'] ?? '',
      priority: json['priority'] ?? '',
      deliveryLocation: Location.fromJson(json['deliveryLocation']),
      status: orderStatusFromString(json['status'] ?? ''),
      package: Package.fromJson(json['package']),
      orderCost: (json['orderCost'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0.0,
      paymentStatus: paymentStatusFromString(json['paymentStatus'] ?? ''),
      customer: Customer.fromJson(json['customer'] ?? ''),
      estimatedDeliveryTime: DateTime.parse(
        json['estimated_delivery_time'] ?? DateTime.now().toIso8601String(),
      ),
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      shop: Shop.fromJson(json['pickup'] ?? ''),
      type: getOrderType(json["type"] ?? 'normal'),
      parentOrderId: json['parent_order_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'priority': priority,
      'status': status.value,
      'package': package,
      'product_cost': orderCost,
      'payment_status': paymentStatus.value,
      'customer': customer,
    };
  }
}
