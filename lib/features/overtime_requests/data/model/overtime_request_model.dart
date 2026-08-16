class OvertimeRequestMeta {
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;

  const OvertimeRequestMeta({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory OvertimeRequestMeta.fromJson(Map<String, dynamic> json) {
    return OvertimeRequestMeta(
      total: _intValue(json['total']),
      count: _intValue(json['count']),
      perPage: _intValue(json['per_page']),
      currentPage: _intValue(json['current_page']),
      totalPages: _intValue(json['total_pages']),
    );
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
}

class OvertimeRequestModel {
  final int id;
  final DateTime? date;
  final String initiator;
  final int requestedMinutes;
  final int? actualMinutes;
  final String reason;
  final String status;
  final DateTime? reviewedAt;
  final OvertimeUser user;
  final OvertimeShift shift;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OvertimeRequestModel({
    required this.id,
    required this.date,
    required this.initiator,
    required this.requestedMinutes,
    required this.actualMinutes,
    required this.reason,
    required this.status,
    required this.reviewedAt,
    required this.user,
    required this.shift,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OvertimeRequestModel.fromJson(Map<String, dynamic> json) {
    return OvertimeRequestModel(
      id: _intValue(json['id']),
      date: DateTime.tryParse(json['date']?.toString() ?? ''),
      initiator: json['initiator']?.toString().trim() ?? '',
      requestedMinutes: _intValue(json['requested_minutes']),
      actualMinutes: _intValue(json['actual_minutes'], nullable: true),
      reason: json['reason']?.toString().trim() ?? '',
      status: json['status']?.toString().trim() ?? '',
      reviewedAt: DateTime.tryParse(json['reviewed_at']?.toString() ?? ''),
      user: OvertimeUser.fromJson(
        (json['user'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{},
      ),
      shift: OvertimeShift.fromJson(
        (json['shift'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{},
      ),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
    );
  }

  String get dateLabel {
    final value = date;
    if (value == null) return '-';
    return '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
  }

  String get createdAtLabel {
    final value = createdAt;
    if (value == null) return '-';
    return '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
  }

  DateTime get sortDate => createdAt ?? updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  bool get isPending => status.toLowerCase().trim() == 'pending';
  bool get isApproved => status.toLowerCase().trim() == 'approved';
  bool get isRejected => status.toLowerCase().trim() == 'rejected';

  static int _intValue(
    dynamic value, {
    bool nullable = false,
    int fallback = 0,
  }) {
    if (value == null && nullable) return fallback;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsed = int.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
    return fallback;
  }
}

class OvertimeUser {
  final int id;
  final String name;
  final String username;

  const OvertimeUser({
    required this.id,
    required this.name,
    required this.username,
  });

  factory OvertimeUser.fromJson(Map<String, dynamic> json) {
    return OvertimeUser(
      id: OvertimeRequestModel._intValue(json['id']),
      name: json['name']?.toString().trim() ?? '',
      username: json['username']?.toString().trim() ?? '',
    );
  }
}

class OvertimeShift {
  final int id;
  final String name;

  const OvertimeShift({required this.id, required this.name});

  factory OvertimeShift.fromJson(Map<String, dynamic> json) {
    return OvertimeShift(
      id: OvertimeRequestModel._intValue(json['id']),
      name: json['name']?.toString().trim() ?? '',
    );
  }
}
