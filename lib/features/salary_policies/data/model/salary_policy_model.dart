class SalaryPolicyModel {
  final int id;
  final int companyId;
  final String name;
  final String unitOfMeasurement;
  final double value;
  final String discountType;
  final double discountValue;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SalaryPolicyModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.unitOfMeasurement,
    required this.value,
    required this.discountType,
    required this.discountValue,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SalaryPolicyModel.fromJson(Map<String, dynamic> json) {
    return SalaryPolicyModel(
      id: _intValue(json['id']),
      companyId: _intValue(json['company_id']),
      name: json['name']?.toString().trim() ?? '',
      unitOfMeasurement: json['unit_of_measurement']?.toString().trim() ?? '',
      value: _doubleValue(json['value']),
      discountType: json['discount_type']?.toString().trim() ?? '',
      discountValue: _doubleValue(json['discount_value']),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
    );
  }

  DateTime get sortDate =>
      updatedAt ?? createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  String get createdAtLabel {
    final value = createdAt;
    if (value == null) return '-';
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day/$month/${value.year}';
  }

  static int _intValue(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsed = int.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
    return fallback;
  }

  static double _doubleValue(dynamic value, {double fallback = 0}) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
    return fallback;
  }
}
