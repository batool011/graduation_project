class TaskModel {
  final int id;
  final String title;
  final String description;
  final int employeeId;
  final String status;
  final String startDate;
  final String endDate;
  final String assignedBy;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.employeeId,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.assignedBy,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: _intValue(json, const ['id', 'task_id']),
      title: _stringValue(json, const [
        'title',
        'name',
      ], fallback: 'بدون عنوان'),
      description: _stringValue(json, const [
        'description',
        'details',
        'body',
      ], fallback: '-'),
      employeeId: _intValue(json, const ['employee_id', 'employeeId']),
      status: _stringValue(json, const [
        'status',
        'state',
      ], fallback: 'In Queue'),
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
      assignedBy: _stringValue(json, const [
        'assigned_by',
        'assignedBy',
        'manager_name',
        'created_by_name',
      ], fallback: '-'),
    );
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
