import 'package:career/core/constant/class/app_string.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TaskModel {
  final int id;
  final String title;
  final String description;
  final int employeeId;
  final String status;
  final String startDate;
  final String endDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String assignedBy;
  final String employeeName;
  final String departmentName;
  final String assignedByUsername;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.employeeId,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.assignedBy,
    required this.employeeName,
    required this.departmentName,
    required this.assignedByUsername,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final assignedByJson = json['assigned_by'];
    final employeeJson = json['employee'];
    final departmentJson = json['department'];

    return TaskModel(
      id: _intValue(json, const ['id', 'task_id']),
      title: _stringValue(json, const [
        'title',
        'name',
      ], fallback: AppString.untitledTask.tr),
      description: _stringValue(json, const [
        'description',
        'details',
        'body',
      ], fallback: '-'),
      employeeId: _intValue(json, const ['employee_id', 'employeeId']),
      status: _stringValue(json, const [
        'status',
        'state',
      ], fallback: AppString.taskInQueue.tr),
      startDate: _stringValue(json, const [
        'start_date',
        'startDate',
        'starts_at',
      ], fallback: '-'),
      endDate: _stringValue(json, const [
        'end_date',
        'endDate',
        'ends_at',
      ], fallback: '-'),
      createdAt: _dateValue(json, const ['created_at', 'createdAt']),
      updatedAt: _dateValue(json, const ['updated_at', 'updatedAt']),
      assignedBy: _nestedName(
        assignedByJson,
        fallback: _stringValue(json, const [
          'assignedBy',
          'manager_name',
          'created_by_name',
        ], fallback: '-'),
      ),
      employeeName: _nestedName(employeeJson),
      departmentName: _nestedName(departmentJson),
      assignedByUsername: _nestedUsername(assignedByJson),
    );
  }

  String get startDateLabel => _formattedDate(startDate);

  String get endDateLabel => _formattedDate(endDate);

  String get createdAtLabel => _formattedDate(createdAt?.toIso8601String() ?? '');

  DateTime get sortDate => updatedAt ?? createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  String get statusLabel {
    final normalized = status.toLowerCase().trim();

    if (normalized.contains('complete') || normalized.contains('done')) {
      return AppString.taskCompleted.tr;
    }

    if (normalized.contains('progress') || normalized.contains('process')) {
      return AppString.taskInProgress.tr;
    }

    if (normalized.contains('queue') || normalized.contains('pending')) {
      return AppString.taskInQueue.tr;
    }

    return status;
  }

  String get statusTranslationKey {
    final normalized = status.toLowerCase().trim();

    if (normalized.contains('complete') || normalized.contains('done')) {
      return 'taskCompleted';
    }

    if (normalized.contains('progress') || normalized.contains('process')) {
      return 'taskInProgress';
    }

    if (normalized.contains('queue') || normalized.contains('pending')) {
      return 'taskInQueue';
    }

    return 'taskUnknown';
  }

  String get statusSubtitle {
    final normalized = status.toLowerCase().trim();

    if (normalized.contains('complete') || normalized.contains('done')) {
      return AppString.taskCompletedSubtitle.tr;
    }

    if (normalized.contains('progress') || normalized.contains('process')) {
      return AppString.taskInProgressSubtitle.tr;
    }

    if (normalized.contains('queue') || normalized.contains('pending')) {
      return AppString.taskInQueueSubtitle.tr;
    }

    return AppString.taskStatusSubtitle.tr;
  }

  int get statusStage {
    final normalized = status.toLowerCase().trim();

    if (normalized.contains('complete') || normalized.contains('done')) {
      return 2;
    }

    if (normalized.contains('progress') || normalized.contains('process')) {
      return 1;
    }

    return 0;
  }

  static String _nestedName(dynamic value, {String fallback = '-'}) {
    if (value is Map<String, dynamic>) {
      return _stringValue(value, const ['name', 'title', 'full_name', 'username'], fallback: fallback);
    }

    return fallback;
  }

  static String _nestedUsername(dynamic value) {
    if (value is Map<String, dynamic>) {
      return _stringValue(value, const ['username', 'email'], fallback: '-');
    }

    return '-';
  }

  static String _formattedDate(String value) {
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    return '${parsed.day}-${parsed.month}-${parsed.year}';
  }

  static DateTime? _dateValue(
    Map<String, dynamic> json,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = json[key];
      if (value is String && value.trim().isNotEmpty) {
        return DateTime.tryParse(value.trim());
      }
    }
    return null;
  }

  static int _intValue(
    Map<String, dynamic> source,
    List<String> keys, {
    int fallback = 0,
  }) {
    for (final key in keys) {
      final value = source[key];
      if (value is int) return value;
      if (value is String) {
        final parsed = int.tryParse(value.trim());
        if (parsed != null) return parsed;
      }
    }
    return fallback;
  }

  static String _stringValue(
    Map<String, dynamic> source,
    List<String> keys, {
    String fallback = '',
  }) {
    for (final key in keys) {
      final value = source[key];
      if (value != null) {
        final text = value.toString().trim();
        if (text.isNotEmpty) return text;
      }
    }
    return fallback;
  }
}
