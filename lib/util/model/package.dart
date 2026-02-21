class Package {
  final String description;
  final double weight;
  final String specialInstructions;

  Package({
    required this.description,
    required this.weight,
    required this.specialInstructions,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      description: json['description'] ?? '',
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      specialInstructions: json['specialInstructions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'weight': weight,
      'specialInstructions': specialInstructions,
    };
  }
}
