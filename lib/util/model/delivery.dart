import 'dart:convert';
import 'dart:typed_data';

import 'package:deliveryapp/util/model/person.dart';

class Delivery extends Person {
  final Uint8List? picture;
  final String username;
  final String email;

  Delivery({
    required this.username,
    required super.fullName,
    required this.email,
    required super.phoneNumber,
    required this.picture,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    final user = json['data'];

    return Delivery(
      username: user['username'] ?? '',
      fullName: user['full_name'] ?? '',
      email: user['email'] ?? '',
      phoneNumber: user['phone'].toString(),
      picture:
          user['picture'] != null && user['picture'] != ''
              ? base64Decode(user['picture'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone': phoneNumber,
      'picture': picture != null ? base64Encode(picture!) : null,
    };
  }
}
