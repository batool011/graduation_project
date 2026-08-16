class CourseModel {
  final int id;
  final String title;
  final String description;
  final String courseTarget;
  final int duration;
  final int companyId;
  final int? passPercentage;
  final bool isMandatory;
  final int? dueDays;
  final bool hasExam;
  final List<CourseContentModel> contents;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.courseTarget,
    required this.duration,
    required this.companyId,
    required this.passPercentage,
    required this.isMandatory,
    required this.dueDays,
    required this.hasExam,
    required this.contents,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      courseTarget: json['course_target']?.toString() ?? '',
      duration: json['duration'] ?? 0,
      companyId: json['company_id'] ?? 0,
      passPercentage: json['pass_percentage'] is int
          ? json['pass_percentage'] as int
          : int.tryParse(json['pass_percentage']?.toString() ?? ''),
      isMandatory: json['is_mandatory'] == true,
      dueDays: json['due_days'] is int
          ? json['due_days'] as int
          : int.tryParse(json['due_days']?.toString() ?? ''),
      hasExam: json['has_exam'] == true,
      contents: (json['contents'] as List<dynamic>? ?? [])
          .map((e) => CourseContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CourseContentModel {
  final int id;
  final String title;
  final String description;
  final String fileType;
  final String fileUrl;
  final int fileSize;

  CourseContentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fileType,
    required this.fileUrl,
    required this.fileSize,
  });

  factory CourseContentModel.fromJson(Map<String, dynamic> json) {
    return CourseContentModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      fileType: json['file_type']?.toString() ?? '',
      fileUrl: json['file_url']?.toString() ?? '',
      fileSize: json['file_size'] ?? 0,
    );
  }

  String get readableSize {
    if (fileSize < 1024) return '$fileSize B';
    if (fileSize < 1024 * 1024) {
      return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    }
    return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
