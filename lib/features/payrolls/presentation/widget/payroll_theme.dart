import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/material.dart';

/// Shared styling used across every payroll widget. This used to live as
/// private top-level constants inside `payroll_screen.dart` - fine when
/// everything was one file, but they had to move here once the widgets
/// that use them were split into their own files.
class PayrollTheme {
  static const Color ink = Color(0xFF0F172A);
  static const Color subInk = Color(0xFF64748B);
  static const Color blue = Color(0xFF2563EB);
  static const Color sky = Color(0xFF0EA5E9);
  static const Color softBorder = Color(0xFFE5EAF3);
  static const Color softBackground = Color(0xFFF8FAFC);

  static LinearGradient brandGradient({
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return AppColor.heroGradient(begin: begin, end: end);
  }
}

String formatPayrollMoney(num value, {int fractionDigits = 0}) {
  final fixed = value.toStringAsFixed(fractionDigits);

  if (fractionDigits == 0) {
    return fixed;
  }

  return fixed.replaceFirst(RegExp(r'\.?0+$'), '');
}
