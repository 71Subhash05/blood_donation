class Donor {
  final String? id;
  final String name;
  final String bloodGroup;
  final String phone;
  final String village;
  final bool isAvailable;
  final DateTime? createdAt;

  Donor({
    this.id,
    required this.name,
    required this.bloodGroup,
    required this.phone,
    required this.village,
    required this.isAvailable,
    this.createdAt,
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id: json['_id'],
      name: json['name'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      phone: json['phone'] ?? '',
      village: json['village'] ?? '',
      isAvailable: json['availability'] ?? true,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bloodGroup': bloodGroup,
      'phone': phone,
      'village': village,
      'availability': isAvailable,
    };
  }
}