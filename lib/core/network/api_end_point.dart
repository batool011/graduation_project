class ApiEndPoints {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://d096-149-34-244-172.ngrok-free.app',
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

  // Complaints
  static const String addComplaint = "$baseUrl/api/complaints";
  static const String getAllComplaint = "$baseUrl/api/complaints";
  static String getComplaintDetail(int id) => "$baseUrl/api/complaints/$id";

  static const String updateComplaint = "$baseUrl/api/complaints";

  // Properties
  static String getAllCompanies({int page = 1, int perPage = 15}) =>
      "$baseUrl/api/v1/companies?page=$page&per_page=$perPage";
  static String getPropertyDetail(int id) => "$baseUrl/api/properties/$id";
}
