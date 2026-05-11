import 'package:flutter/material.dart';

import '../getx/controller/attendance_history_controller.dart';

class AttendancePeriodDialogContent extends StatefulWidget {
  const AttendancePeriodDialogContent({super.key,
    required this.controller,
    required this.initialMonth,
    required this.initialYear,
  });

  final AttendanceHistoryController controller;
  final int initialMonth;
  final int initialYear;

  @override
  State<AttendancePeriodDialogContent> createState() =>
      _AttendancePeriodDialogContentState();
}

class _AttendancePeriodDialogContentState
    extends State<AttendancePeriodDialogContent> {
  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialMonth;
    selectedYear = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('اختيار الشهر والسنة'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<int>(
            value: selectedMonth,
            items: List.generate(
              widget.controller.availableMonths.length,
                  (index) => DropdownMenuItem(
                value: index + 1,
                child: Text(widget.controller.availableMonths[index]),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedMonth = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}