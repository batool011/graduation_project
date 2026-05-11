import 'package:career/core/widget/snak_bar_service.dart';
import 'package:get/get.dart';

import '../../../data/models/attendance_history_model.dart';
import '../../../data/repository/attendance_history_repository.dart';

class AttendanceHistoryController extends GetxController {
  final AttendanceHistoryRepository repo = AttendanceHistoryRepository();

  final RxList<AttendanceHistory> attendanceHistory = <AttendanceHistory>[].obs;
  final RxBool isLoading = false.obs;
  final Rxn<PaginationMeta> paginationMeta = Rxn<PaginationMeta>();

  final RxInt selectedMonth = DateTime.now().month.obs;
  final RxInt selectedYear = DateTime.now().year.obs;
  final RxInt perPage = 31.obs;

  List<String> get availableMonths => const <String>[
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  List<int> get availableYears {
    final currentYear = DateTime.now().year;
    return List<int>.generate(6, (index) => currentYear - index);
  }

  Future<void> fetchAttendanceHistory({
    required int month,
    required int year,
  }) async {
    selectedMonth.value = month;
    selectedYear.value = year;
    isLoading.value = true;

    try {
      final result = await repo.getAttendanceHistory(
        month: month,
        year: year,
        perPage: perPage.value,
      );

      result.fold(
        (failure) {
          SnackbarService.error(failure.message);
        },
        (data) {
          attendanceHistory.assignAll(data);
          paginationMeta.value = repo.lastMeta;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshHistory() async {
    await fetchAttendanceHistory(
      month: selectedMonth.value,
      year: selectedYear.value,
    );
  }

  Future<void> updatePeriod({required int month, required int year}) async {
    if (month == selectedMonth.value && year == selectedYear.value) {
      return;
    }

    await fetchAttendanceHistory(month: month, year: year);
  }

  int get vacationDaysCount =>
      attendanceHistory
          .where((item) => item.status == AttendanceStatus.leave)
          .length;

  int get lateDaysCount =>
      attendanceHistory
          .where((item) => item.status == AttendanceStatus.late)
          .length;

  int get overtimeDaysCount => attendanceHistory.where(_hasOvertime).length;

  bool _hasOvertime(AttendanceHistory item) {
    return item.workingMinutes > 480;
  }

  String get monthTitle {
    final monthIndex = (selectedMonth.value.clamp(1, 12) - 1).toInt();
    return '${availableMonths[monthIndex]} ${selectedYear.value}';
  }

  @override
  void onInit() {
    super.onInit();
    fetchAttendanceHistory(
      month: selectedMonth.value,
      year: selectedYear.value,
    );
  }
}
