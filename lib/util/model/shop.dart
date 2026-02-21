class Shop {
  final String location;
  final String address;
  final String phoneNumber;
  final String name;

  Shop({
    required this.location,
    required this.address,
    required this.phoneNumber,
    required this.name,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      location: json['pickup_location_url'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone'] ?? '',
      name: json['shop_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location_url': location,
      'address': address,
      'phone': phoneNumber,
      'shop_name': name,
    };
  }
}
