/// A single exam question. The backend (CourseExamService) always returns
/// a fixed list of text `options` per question and grades the submitted
/// answer as a case-insensitive string match - there is no separate
/// "type" field, every question is answered by picking one of `options`.
class CourseExamQuestionModel {
  final int id;
  final String text;
  final List<String> options;

  CourseExamQuestionModel({
    required this.id,
    required this.text,
    required this.options,
  });

  factory CourseExamQuestionModel.fromJson(Map<String, dynamic> json) {
    return CourseExamQuestionModel(
      id: json['id'] ?? 0,
      text: json['text']?.toString() ?? '',
      options: (json['options'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

/// The questions bundle returned by GET /courses/{id}/exam.
class CourseExamModel {
  final int courseId;
  final int passPercentage;
  final List<CourseExamQuestionModel> questions;

  CourseExamModel({
    required this.courseId,
    required this.passPercentage,
    required this.questions,
  });

  factory CourseExamModel.fromJson(Map<String, dynamic> json) {
    return CourseExamModel(
      courseId: json['course_id'] ?? 0,
      passPercentage: json['pass_percentage'] is int
          ? json['pass_percentage'] as int
          : int.tryParse(json['pass_percentage']?.toString() ?? '') ?? 0,
      questions: (json['questions'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(CourseExamQuestionModel.fromJson)
          .toList(),
    );
  }
}

/// A single graded exam attempt, as returned by both the submit endpoint
/// and the results-history endpoint.
class CourseExamAttemptModel {
  final int id;
  final int attemptNumber;
  final int totalQuestions;
  final int correctAnswers;
  final num score;
  final bool passed;
  final DateTime? submittedAt;

  CourseExamAttemptModel({
    required this.id,
    required this.attemptNumber,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.passed,
    required this.submittedAt,
  });

  factory CourseExamAttemptModel.fromJson(Map<String, dynamic> json) {
    return CourseExamAttemptModel(
      id: json['id'] ?? 0,
      attemptNumber: json['attempt_number'] ?? 0,
      totalQuestions: json['total_questions'] ?? 0,
      correctAnswers: json['correct_answers'] ?? 0,
      score: json['score'] is num
          ? json['score'] as num
          : num.tryParse(json['score']?.toString() ?? '') ?? 0,
      passed: json['passed'] == true,
      submittedAt: json['submitted_at'] is String && (json['submitted_at'] as String).trim().isNotEmpty
          ? DateTime.tryParse(json['submitted_at'])
          : null,
    );
  }
}
