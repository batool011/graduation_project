class AttendanceHistory {
  final DateTime? date;
  final String dayName;
  final String monthName;
  final int year;
  final String? checkInTime;
  final String? checkOutTime;
  final String? totalWorkingHours;
  final int workingMinutes;
  final AttendanceStatus status;
  final Employee employee;

  AttendanceHistory({
    required this.date,
    required this.dayName,
    required this.monthName,
    required this.year,
    required this.checkInTime,
    required this.checkOutTime,
    required this.totalWorkingHours,
    required this.workingMinutes,
    required this.status,
    required this.employee,
  });

  factory AttendanceHistory.fromJson(Map<String, dynamic> json) {
    return AttendanceHistory(
      date: DateTime.tryParse(json['date']?.toString() ?? ''),
      dayName: json['day_name']?.toString().trim() ?? '',
      monthName: json['month_name']?.toString().trim() ?? '',
      year: _intValue(json['year']),
      checkInTime: _stringValue(json['check_in_time']),
      checkOutTime: _stringValue(json['check_out_time']),
      totalWorkingHours: _stringValue(json['total_working_hours']),
      workingMinutes: _intValue(json['working_minutes']),
      status: AttendanceStatusMapper.fromApi(json['status']?.toString()),
      employee: Employee.fromJson(
        (json['employee'] as Map?)?.cast<String, dynamic>() ??
            <String, dynamic>{},
      ),
    );
  }

  String get formattedDate {
    final parsedDate = date;
    if (parsedDate == null) {
      if (monthName.isEmpty) {
        return '$year';
      }
      return '$monthName $year';
    }

    final day = parsedDate.day.toString().padLeft(2, '0');
    final month = parsedDate.month.toString().padLeft(2, '0');
    return '$day/$month/$year';
  }

  String get dayAndDateLabel {
    final dayPart = dayName.isEmpty ? 'اليوم' : dayName;
    return '$dayPart • $formattedDate';
  }

  static int _intValue(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is String) {
      final parsed = int.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
    return fallback;
  }

  static String? _stringValue(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }
}

class Employee {
  final int id;
  final String name;
  final String username;
  final int companyId;

  Employee({
    required this.id,
    required this.name,
    required this.username,
    required this.companyId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: _intValue(json['id']),
      name: json['name']?.toString().trim() ?? '',
      username: json['username']?.toString().trim() ?? '',
      companyId: _intValue(json['company_id']),
    );
  }

  static int _intValue(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is String) {
      final parsed = int.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
    return fallback;
  }
}

class PaginationMeta {
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;

  PaginationMeta({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      total: _intValue(json['total']),
      count: _intValue(json['count']),
      perPage: _intValue(json['per_page']),
      currentPage: _intValue(json['current_page']),
      totalPages: _intValue(json['total_pages']),
    );
  }

  static int _intValue(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is String) {
      final parsed = int.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
    return fallback;
  }
}

enum AttendanceStatus { onTime, late, absent, leave, holiday, weekend, unknown }

class AttendanceStatusMapper {
  static AttendanceStatus fromApi(String? value) {
    switch (value?.trim().toLowerCase()) {
      case 'on_time':
      case 'on-time':
      case 'ontime':
      case 'present':
      case 'checked_in':
        return AttendanceStatus.onTime;
      case 'late':
        return AttendanceStatus.late;
      case 'absent':
        return AttendanceStatus.absent;
      case 'leave':
      case 'on_leave':
        return AttendanceStatus.leave;
      case 'holiday':
        return AttendanceStatus.holiday;
      case 'weekend':
        return AttendanceStatus.weekend;
      default:
        return AttendanceStatus.unknown;
    }
  }

  static String label(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.onTime:
        return 'في الوقت';
      case AttendanceStatus.late:
        return 'متأخر';
      case AttendanceStatus.absent:
        return 'غائب';
      case AttendanceStatus.leave:
        return 'إجازة';
      case AttendanceStatus.holiday:
        return 'عطلة';
      case AttendanceStatus.weekend:
        return 'نهاية الأسبوع';
      case AttendanceStatus.unknown:
        return 'غير معروف';
    }
  }

  static int colorValue(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.onTime:
        return 0xFF2E7D32;
      case AttendanceStatus.late:
        return 0xFFF57C00;
      case AttendanceStatus.absent:
        return 0xFFC62828;
      case AttendanceStatus.leave:
        return 0xFF1565C0;
      case AttendanceStatus.holiday:
        return 0xFF6A1B9A;
      case AttendanceStatus.weekend:
        return 0xFF00897B;
      case AttendanceStatus.unknown:
        return 0xFF607D8B;
    }
  }
}
