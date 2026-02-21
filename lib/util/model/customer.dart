import 'package:deliveryapp/util/model/person.dart';

class Customer extends Person {
  Customer({required super.fullName, required super.phoneNumber});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      fullName: json['customer_name'] ?? '',
      phoneNumber: json['phone'] ?? '',
    );
  }
}
