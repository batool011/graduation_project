import 'package:career/features/work_schedule/data/model/work_day_model.dart';
import 'package:career/features/work_schedule/data/repository/work_schedule_repository.dart';
import 'package:career/core/widget/snak_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkScheduleController extends GetxController {
  final WorkScheduleRepository repo = WorkScheduleRepository();
  final RxList<WorkDayModel> _rows = <WorkDayModel>[].obs;
  final RxBool isLoading = false.obs;

  List<WorkDayModel> get rows => _rows;

  String get weekRange {
    if (rows.isEmpty) return '-';
    return '${rows.first.date} - ${rows.last.date}';
  }

  String get totalHours => '38:30';

  String get attendanceDays =>
      rows.where((row) => row.status == 'مكتمل' || row.status == 'ممتاز' || row.status == 'متأخر').length.toString();

  String get lateCount => rows.where((row) => row.status == 'متأخر').length.toString();

  String get vacationDays => rows.where((row) => row.status == 'إجازة').length.toString();

  Color statusBgColor(String status) {
    switch (status) {
      case 'ممتاز':
        return const Color(0xFFE8F8EF);
      case 'متأخر':
        return const Color(0xFFFFF0E9);
      case 'إجازة':
        return const Color(0xFFEFF2FF);
      default:
        return const Color(0xFFEFF7FF);
    }
  }

  Color statusTextColor(String status) {
    switch (status) {
      case 'ممتاز':
        return const Color(0xFF149954);
      case 'متأخر':
        return const Color(0xFFD86C2F);
      case 'إجازة':
        return const Color(0xFF6C76B7);
      default:
        return const Color(0xFF4B6A93);
    }
  }

  Future<void> loadWorkSchedule() async {
    isLoading.value = true;
    try {
      final result = await repo.getWeekRows();
      result.fold(
        (failure) {
          SnackbarService.error(failure.message);
          _rows.assignAll(_fallbackRows);
        },
        (data) {
          if (data.isEmpty) {
            _rows.assignAll(_fallbackRows);
          } else {
            _rows.assignAll(data);
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  static const List<WorkDayModel> _fallbackRows = <WorkDayModel>[
    WorkDayModel(day: 'الأحد', date: '14 Apr', checkIn: '08:55', checkOut: '05:10', status: 'مكتمل'),
    WorkDayModel(day: 'الاثنين', date: '15 Apr', checkIn: '09:05', checkOut: '05:00', status: 'مكتمل'),
    WorkDayModel(day: 'الثلاثاء', date: '16 Apr', checkIn: '08:50', checkOut: '05:20', status: 'ممتاز'),
    WorkDayModel(day: 'الأربعاء', date: '17 Apr', checkIn: '09:15', checkOut: '04:58', status: 'متأخر'),
    WorkDayModel(day: 'الخميس', date: '18 Apr', checkIn: '-', checkOut: '-', status: 'إجازة'),
  ];

  @override
  void onInit() {
    loadWorkSchedule();
    super.onInit();
  }
}
