class EmployeeEvaluationModel {
  final String employeeName;
  final String jobTitle;
  final String department;
  final double rating;
  final String feedback;
  final String date;
  final List<String> strengths;
  final List<String> focusAreas;

  const EmployeeEvaluationModel({
    required this.employeeName,
    required this.jobTitle,
    required this.department,
    required this.rating,
    required this.feedback,
    required this.date,
    required this.strengths,
    required this.focusAreas,
  });
}

class EmployeeProfile {
  final String employeeName;
  final String jobTitle;
  final String department;
  final String employeeId;

  const EmployeeProfile({
    required this.employeeName,
    required this.jobTitle,
    required this.department,
    required this.employeeId,
  });
}