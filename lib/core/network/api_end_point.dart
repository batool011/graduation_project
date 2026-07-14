class ApiEndPoints {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
   defaultValue: 'http://204.168.145.146',
  );
  // Auth
  static const String login = "$baseUrl/api/v1/auth/login";
  static const String register = "$baseUrl/api/v1/employees/register";
  static const String logout = "$baseUrl/api/v1/auth/logout";
  static const String currentUser = "$baseUrl/api/user";

  // Work Schedule
  static const String workSchedule = "$baseUrl/api/work-schedule";

  // Attendance
  static const String attendance = "$baseUrl/api/v1/attendance/scan";
  static const String attendanceHistory = "$baseUrl/api/v1/attendance/history";

  // Vacation
  static const String vacations = "$baseUrl/api/v1/vacations";
  static const String createVacation = "$baseUrl/api/v1/vacations";
  static String getVacationDetail(int id) => "$baseUrl/api/v1/vacations/$id";

  // Complaints
  static const String addComplaint = "$baseUrl/api/v1/complaints";
  static const String getAllComplaint = "$baseUrl/api/v1/complaints";
  static String getComplaintDetail(int id) => "$baseUrl/api/complaints/$id";

  static const String updateComplaint = "$baseUrl/api/complaints";

  // Tasks
  static const String tasks = "$baseUrl/api/v1/tasks";

    // Employee Evaluation
    static const String employeeEvaluation =
      "$baseUrl/api/v1/evaluations/get-employee-evaluation";

  // Properties
  static String getAllCompanies({int page = 1, int perPage = 15}) =>
      "$baseUrl/api/v1/companies?page=$page&per_page=$perPage";
  static String getPropertyDetail(int id) => "$baseUrl/api/properties/$id";

    // ===== دوال الدورات =====
  
  static String getCourses({
    String? title,
    String? duration,
    String? courseTarget,
    int page = 1,
    int perPage = 15,
  }) {
    String url = "$baseUrl/api/v1/courses?page=$page&per_page=$perPage";
    if (title != null && title.isNotEmpty) {
      url += "&title=$title";
    }
    if (duration != null && duration.isNotEmpty) {
      url += "&duration=$duration";
    }
    if (courseTarget != null && courseTarget.isNotEmpty) {
      url += "&course_target=$courseTarget";
    }
    return url;
  }

  static String getCourseDetail(int id) => "$baseUrl/api/v1/courses/$id";
}
