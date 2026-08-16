import 'course_exam_model.dart';

/// Mirrors CourseEnrollment::STATUS_* on the backend.
class CourseEnrollmentStatus {
  static const String assigned = 'assigned';
  static const String inProgress = 'in_progress';
  static const String completed = 'completed';
  static const String failed = 'failed';
}

/// A brief summary of the course this enrollment belongs to - just what
/// the "My Courses" list and its cards need. Full content (files to open)
/// is only available from CourseModel via GET /courses/{id}.
class EnrolledCourseSummary {
  final int id;
  final String title;
  final int duration;
  final int? passPercentage;
  final bool isMandatory;

  EnrolledCourseSummary({
    required this.id,
    required this.title,
    required this.duration,
    required this.passPercentage,
    required this.isMandatory,
  });

  factory EnrolledCourseSummary.fromJson(Map<String, dynamic> json) {
    return EnrolledCourseSummary(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      duration: json['duration'] ?? 0,
      passPercentage: json['pass_percentage'] is int
          ? json['pass_percentage'] as int
          : int.tryParse(json['pass_percentage']?.toString() ?? ''),
      isMandatory: json['is_mandatory'] == true,
    );
  }
}

class CourseEnrollmentModel {
  final int id;
  final int courseId;
  final EnrolledCourseSummary? course;
  final String status;
  final int progressPercentage;
  final DateTime? assignedAt;
  final DateTime? dueAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final bool isOverdue;
  final num? latestScore;
  final bool? latestPassed;
  final List<CourseExamAttemptModel> examAttempts;

  CourseEnrollmentModel({
    required this.id,
    required this.courseId,
    required this.course,
    required this.status,
    required this.progressPercentage,
    required this.assignedAt,
    required this.dueAt,
    required this.startedAt,
    required this.completedAt,
    required this.isOverdue,
    required this.latestScore,
    required this.latestPassed,
    required this.examAttempts,
  });

  factory CourseEnrollmentModel.fromJson(Map<String, dynamic> json) {
    return CourseEnrollmentModel(
      id: json['id'] ?? 0,
      courseId: json['course_id'] ?? 0,
      course: json['course'] is Map<String, dynamic>
          ? EnrolledCourseSummary.fromJson(json['course'] as Map<String, dynamic>)
          : null,
      status: json['status']?.toString() ?? CourseEnrollmentStatus.assigned,
      progressPercentage: json['progress_percentage'] is int
          ? json['progress_percentage'] as int
          : int.tryParse(json['progress_percentage']?.toString() ?? '') ?? 0,
      assignedAt: _dateValue(json['assigned_at']),
      dueAt: _dateValue(json['due_at']),
      startedAt: _dateValue(json['started_at']),
      completedAt: _dateValue(json['completed_at']),
      isOverdue: json['is_overdue'] == true,
      latestScore: json['latest_score'] is num
          ? json['latest_score'] as num
          : num.tryParse(json['latest_score']?.toString() ?? ''),
      latestPassed: json['latest_passed'] is bool ? json['latest_passed'] as bool : null,
      examAttempts: (json['exam_attempts'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(CourseExamAttemptModel.fromJson)
          .toList(),
    );
  }

  String get title => course?.title ?? '';

  bool get isCompleted => status == CourseEnrollmentStatus.completed;

  bool get isFailed => status == CourseEnrollmentStatus.failed;

  bool get isInProgress => status == CourseEnrollmentStatus.inProgress;

  bool get isAssigned => status == CourseEnrollmentStatus.assigned;

  static DateTime? _dateValue(dynamic value) {
    if (value is String && value.trim().isNotEmpty) {
      return DateTime.tryParse(value.trim());
    }
    return null;
  }
}
