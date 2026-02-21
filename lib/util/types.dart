import 'package:flutter/material.dart';

enum DisplayedOrderTypes {
  all,
  confirmed,
  pickedUp,
  pickedUpAssign,
  atWareHouse,
  deliveryAssigned,
  onTheWay,
  paidToShop,
}

enum OrderActionType { scan, payment, none }

enum DeliveryCase { customer, shopOwner, all }

OrderActionType getOrderAction(OrderStatus status) {
  switch (status) {
    case OrderStatus.pickedUp:
    case OrderStatus.deliveryAssigned:
    case OrderStatus.atWareHouse:
      return OrderActionType.scan;

    case OrderStatus.onTheWay:
    case OrderStatus.pickedUpAssign:
      return OrderActionType.payment;

    default:
      return OrderActionType.none;
  }
}

const List<OrderStatus> displayedOrderStatuses = [
  OrderStatus.all,
  OrderStatus.pickedUp, // scan or confirm
  OrderStatus.pickedUpAssign, // scan or confirm
  OrderStatus.atWareHouse, // scan or confirm
  OrderStatus.deliveryAssigned, // scan or confirm
  OrderStatus.onTheWay, // payment
];

extension DisplayedOrderTypesLabel on DisplayedOrderTypes {
  String get value {
    switch (this) {
      case DisplayedOrderTypes.paidToShop:
        return 'Paid to Shop';
      case DisplayedOrderTypes.atWareHouse:
        return 'At Warehouse';
      case DisplayedOrderTypes.all:
        return 'All';
      case DisplayedOrderTypes.pickedUpAssign:
        return 'Pickup Assigned';
      case DisplayedOrderTypes.confirmed:
        return 'Confirmed';
      case DisplayedOrderTypes.pickedUp:
        return 'Picked Up';
      case DisplayedOrderTypes.deliveryAssigned:
        return 'Delivery Assign';
      case DisplayedOrderTypes.onTheWay:
        return 'On the way';
    }
  }
}

// get the next order status for the given order status
OrderStatus getNextOrderStatus(
  OrderStatus status,
  PaymentStatus paymentStatus,
) {
  switch (status) {
    case OrderStatus.pickedUpAssign:
      return OrderStatus.pickedUp;

    case OrderStatus.pickedUp:
      return OrderStatus.atWareHouse;

    case OrderStatus.atWareHouse:
      return OrderStatus.deliveryAssigned;

    case OrderStatus.deliveryAssigned:
      return OrderStatus.onTheWay;

    case OrderStatus.onTheWay:
      if (paymentStatus == PaymentStatus.paid) {
        return OrderStatus.delivered;
      }
      if (paymentStatus == PaymentStatus.unpaid) {
        return OrderStatus.deliveredWithExchange;
      }
      return OrderStatus.wrong;
    default:
      return OrderStatus.wrong;
  }
}

enum OrderStatus {
  all,
  wrong, // Pending false
  pickedUp, // Picked Up
  atWareHouse, // At Warehouse
  pickedUpAssign, // Picked Up
  deliveryAssigned, // Delivery Assign
  onTheWay, // On the way
  delivered, // Delivered// Canceled
  delayed, // Delayed
  returned, // Returned
  deliveredWithExchange, // Delivered with exchange
  paidToShop,
  exchange,
}

enum PaymentStatus { paid, unpaid, paidWithExchange }

enum PriorityStatus { urgent, normal }

extension OrderStatusLabel on OrderStatus {
  String get value {
    switch (this) {
      case OrderStatus.all:
        return 'All';
      case OrderStatus.paidToShop:
        return 'Paid to Shop';
      case OrderStatus.wrong:
        return 'Wrong';
      case OrderStatus.atWareHouse:
        return 'At Warehouse';
      case OrderStatus.pickedUp:
        return 'Picked Up';
      case OrderStatus.pickedUpAssign: //update  from deliveryAssigned
        return 'Pickup Assigned';
      case OrderStatus.deliveryAssigned: // update to pickedUpAssign
        return 'Delivery Assigned';
      case OrderStatus.onTheWay:
        return 'On the way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.delayed:
        return 'Delayed';
      case OrderStatus.returned:
        return 'Returned';
      case OrderStatus.deliveredWithExchange:
        return 'Delivered with exchange';
      case OrderStatus.exchange:
        return 'Exchange';
    }
  }
}

extension PaymentStatusExtension on PaymentStatus {
  String get value {
    switch (this) {
      case PaymentStatus.paidWithExchange:
        return 'paid with exchange';
      case PaymentStatus.paid:
        return 'paid';
      case PaymentStatus.unpaid:
        return 'unpaid';
    }
  }
}

// function return its customer or shop owner
String getOrderStatusCustomerOrShopOwner(OrderStatus status) {
  switch (status) {
    case OrderStatus.pickedUp:
    case OrderStatus.pickedUpAssign:
      return "shopOwner";

    case OrderStatus.deliveryAssigned:
    case OrderStatus.delivered:
    case OrderStatus.delayed:
    case OrderStatus.onTheWay:
    case OrderStatus.returned:
    case OrderStatus.deliveredWithExchange:
      return "customer";

    default:
      return "all";
  }
}

enum OrderType { normal, exchange }

OrderType getOrderType(String status) {
  switch (status) {
    case 'Exchange':
      return OrderType.exchange;
    case 'normal':
      return OrderType.normal;
    default:
      return OrderType.normal;
  }
}

extension OrderTypeLabel on OrderType {
  String get value {
    switch (this) {
      case OrderType.exchange:
        return 'Exchange';
      case OrderType.normal:
        return 'Normal';
    }
  }
}

// OrderStatus customerActionPayment(OrderStatus status){
//   switch(status){
//     case OrderStatus.onTheWay:
//       return OrderStatus.paid;
//     case OrderStatus.exchange:
//       return OrderStatus.exchange;
//     default:
//       return OrderStatus.;
//   }
// }

// mappers
OrderStatus orderStatusFromString(String? value) {
  if (value == null) return OrderStatus.wrong;

  switch (value) {
    case 'Pending':
      return OrderStatus.wrong;

    case 'Picked Up':
      return OrderStatus.pickedUp;
    case 'Pickup Assigned':
      return OrderStatus.pickedUpAssign;

    case 'Delivery Assigned':
      return OrderStatus.deliveryAssigned;
    case 'Paid to Shop':
      return OrderStatus.paidToShop;

    case 'On the way':
      return OrderStatus.onTheWay;

    case 'Delivered':
      return OrderStatus.delivered;

    // case 'Canceled':
    //   return OrderStatus.canceled;

    case 'Delayed':
      return OrderStatus.delayed;

    case 'Returned':
      return OrderStatus.returned;

    case 'Delivered (Exchange)':
      return OrderStatus.deliveredWithExchange;

    case 'At Warehouse':
      return OrderStatus.atWareHouse;
    case 'Exchange':
      return OrderStatus.exchange;

    default:
      return OrderStatus.wrong;
  }
}

PaymentStatus paymentStatusFromString(String value) {
  switch (value) {
    case 'paid':
      return PaymentStatus.paid;
    case 'unpaid':
    case 'paid with exchange':
      return PaymentStatus.paidWithExchange;
    default:
      return PaymentStatus.unpaid;
  }
}

extension OrderStatusColor on OrderStatus {
  Color get color {
    switch (this) {
      case OrderStatus.wrong:
        return Colors.red;
      case OrderStatus.pickedUp:
        return Colors.indigo;
      case OrderStatus.deliveryAssigned:
        return Colors.blue;
      case OrderStatus.onTheWay:
        return Colors.blueAccent;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.atWareHouse:
        return Colors.black;
      case OrderStatus.delayed:
        return Colors.amber;
      case OrderStatus.pickedUpAssign:
        return Colors.deepOrange;
      case OrderStatus.returned:
        return Colors.brown;
      case OrderStatus.deliveredWithExchange:
        return Colors.teal;
      // case OrderStatus.paidToShop:
      //   return Colors.green.shade800;
      default:
        return Colors.grey;
    }
  }
}
