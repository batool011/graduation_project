import 'package:flutter/material.dart';

import '../getx/controller/attendance_history_controller.dart';
import 'attendance_period_dialog_content.dart';

class AttendancePeriodDialog {
  static Future<void> show(
      BuildContext context,
      AttendanceHistoryController controller,
      ) async {
    int selectedMonth = controller.selectedMonth.value;
    int selectedYear = controller.selectedYear.value;

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AttendancePeriodDialogContent(
        controller: controller,
        initialMonth: selectedMonth,
        initialYear: selectedYear,
      ),
    );

    if (result == true) {
      await controller.updatePeriod(
        month: selectedMonth,
        year: selectedYear,
      );
    }
  }
}