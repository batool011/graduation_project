import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx/controller/attendance_history_controller.dart';
import 'attendance_period_dialog_content.dart';

class AttendancePeriodDialog {
  static Future<void> show(
      BuildContext context,
      AttendanceHistoryController controller,
      ) async {
    final result = await Get.dialog<Map<String, int>>(
      AttendancePeriodDialogContent(
        controller: controller,
        initialMonth: controller.selectedMonth.value,
        initialYear: controller.selectedYear.value,
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.45),
      transitionDuration: const Duration(milliseconds: 260),
      transitionCurve: Curves.easeOutCubic,
    );

    if (result == null) return;

    final month = result['month'] ?? controller.selectedMonth.value;
    final year = result['year'] ?? controller.selectedYear.value;

    // تجنب التحديث إذا كانت الفترة نفسها
    if (month == controller.selectedMonth.value &&
        year == controller.selectedYear.value) {
      return;
    }

    await controller.updatePeriod(month: month, year: year);
  }
}