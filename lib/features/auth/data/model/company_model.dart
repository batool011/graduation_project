class CompanyModel {
  final int id;
  final String name;
  final String location;
  final String phone;
  final String description;
  final int? managerId;
  final String managerName;

  CompanyModel({
    required this.id,
    required this.name,
    required this.location,
    required this.phone,
    required this.description,
    required this.managerId,
    required this.managerName,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    final manager =
        json['manager'] is Map<String, dynamic>
            ? json['manager'] as Map<String, dynamic>
            : <String, dynamic>{};

    return CompanyModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      managerId: (json['manager_id'] as num?)?.toInt(),
      managerName: manager['name']?.toString() ?? '',
    );
  }
}
