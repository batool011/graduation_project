class LeaveType {
  final int? id;
  final String name;
  final String value;

  LeaveType({
    required this.id,
    required this.name,
    required this.value,
  });

  String get displayText => name.isNotEmpty ? name : value;

  String get dropdownValue => id?.toString() ?? value;

  factory LeaveType.fromJson(Map<String, dynamic> json) {
    final rawName = _stringValue(
      json,
      const [
        'name',
        'title',
        'label',
        'leave_type_name',
        'leave_type',
        'type',
        'reason',
      ],
    );
    final rawValue = _stringValue(
      json,
      const [
        'value',
        'code',
        'slug',
        'key',
        'reason',
        'name',
        'title',
        'label',
      ],
    );

    return LeaveType(
      id: _intValue(json['id']),
      name: rawName,
      value: rawValue.isNotEmpty ? rawValue : rawName,
    );
  }

  static int? _intValue(dynamic value) {
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value.trim());
    }
    return null;
  }

  static String _stringValue(
    Map<String, dynamic> json,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = json[key];
      if (value != null) {
        final text = value.toString().trim();
        if (text.isNotEmpty) {
          return text;
        }
      }
    }
    return '';
  }
}