class Location {
  final String address;
  final String link;
  Location({required this.address, required this.link});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(address: json['address'] ?? '', link: json['link'] ?? '');
  }
}
