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
  //profile
  static const String profile = "$baseUrl/api/v1/employees/profile";

  // Chatbot - single endpoint, natural-language query in the body
  static const String chatbotQuery = "$baseUrl/api/v1/chatbot/query";

  // Real-time (Reverb) - see REVERB_SETUP.md for how these values map to
  // your actual server config. Only used by SavingsRealtimeService.
  static const String reverbAppKey = String.fromEnvironment(
    'REVERB_APP_KEY',
    defaultValue: 'CHANGE_ME',
  );
  static const String reverbHost = String.fromEnvironment(
    'REVERB_HOST',
    defaultValue: '204.168.145.146',
  );
  static const int reverbPort = int.fromEnvironment(
    'REVERB_PORT',
    defaultValue: 8080,
  );
  static const String reverbScheme = String.fromEnvironment(
    'REVERB_SCHEME',
    defaultValue: 'https',
  );
  static const String broadcastingAuth = "$baseUrl/broadcasting/auth";

  // Smart Savings (jam'iyya) - employee side
  static const String savingsAssociations = "$baseUrl/api/v1/savings-associations";
  static String savingsAssociationDetail(int id) => "$baseUrl/api/v1/savings-associations/$id";
  static String savingsAssociationRespond(int id) => "$baseUrl/api/v1/savings-associations/$id/respond";
  static String savingsAssociationMessages(int id) => "$baseUrl/api/v1/savings-associations/$id/messages";

  // Work Schedule
  static const String workSchedule = "$baseUrl/api/work-schedule";

  // Attendance
  static const String attendance = "$baseUrl/api/v1/attendance/scan";
  static const String attendanceHistory = "$baseUrl/api/v1/attendance/history";

  // Payrolls
  static String payrollsMine({
    required int month,
    required int year,
    required int perPage,
    int page = 1,
  }) {
    return "$baseUrl/api/v1/payrolls/mine?month=$month&year=$year&per_page=$perPage&page=$page";
  }

  // Salary policies
  static const String salaryPolicies = "$baseUrl/api/v1/salary-policies";

  // Overtime requests
  static String overtimeRequests({required int perPage, int page = 1}) {
    return "$baseUrl/api/v1/overtime-requests?per_page=$perPage&page=$page";
  }

  static const String createOvertimeRequest =
      "$baseUrl/api/v1/overtime-requests";

  // Vacation
  static const String vacations = "$baseUrl/api/v1/vacations";
  static const String createVacation = "$baseUrl/api/v1/vacations";
  static const String leaveTypes = "$baseUrl/api/v1/leave_types";
  static String getVacationDetail(int id) => "$baseUrl/api/v1/vacations/$id";

  // Complaints
  static const String addComplaint = "$baseUrl/api/v1/complaints";
  static const String getAllComplaint = "$baseUrl/api/v1/complaints";
  static String getComplaintDetail(int id) => "$baseUrl/api/complaints/$id";

  static const String updateComplaint = "$baseUrl/api/complaints";

  // Tasks
  static const String tasks = "$baseUrl/api/v1/tasks";
  static const String refreshToken = "$baseUrl/api/v1/refreshToken";
  // Employee Evaluation
  static const String employeeEvaluation =
      "$baseUrl/api/v1/evaluations/get-employee-evaluation";

  // Properties
  static String getAllCompanies({int page = 1, int perPage = 15}) =>
      "$baseUrl/api/v1/companies?page=$page&per_page=$perPage";
  static String getPropertyDetail(int id) => "$baseUrl/api/properties/$id";

  //courses (catalog - kept for reference / possible future admin-style browsing)
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

  // The employee's own assigned courses + progress. `status` filters by
  // CourseEnrollment status: assigned | in_progress | completed | failed.
  static String myCourses({String? status}) {
    String url = "$baseUrl/api/v1/my-courses";
    if (status != null && status.isNotEmpty) {
      url += "?status=$status";
    }
    return url;
  }

  // Mark one piece of course content as viewed/opened - drives the
  // employee's progress bar for that course.
  static String markCourseContentViewed(int courseId, int contentId) =>
      "$baseUrl/api/v1/courses/$courseId/contents/$contentId/view";

  // Exam questions for a course the employee is enrolled in (correct
  // answers are never included in the response).
  static String courseExamQuestions(int courseId) =>
      "$baseUrl/api/v1/courses/$courseId/exam";

  // Submit and auto-grade an exam attempt.
  static String submitCourseExam(int courseId) =>
      "$baseUrl/api/v1/courses/$courseId/exam/submit";

  // The employee's own exam attempt history for a course.
  static String courseExamResults(int courseId) =>
      "$baseUrl/api/v1/courses/$courseId/exam/results";
}
