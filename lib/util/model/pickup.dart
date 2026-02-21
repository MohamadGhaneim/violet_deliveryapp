class Pickup {
  final String address;
  final String phone;

  Pickup({required this.address, required this.phone});

  factory Pickup.fromJson(Map<String, dynamic> json) {
    return Pickup(
      address: json['address'] ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'address': address, 'phone': phone};
  }
}
