import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/material.dart';

class WorkScheduleHeadCell extends StatelessWidget {
  final String text;
  final int flex;

  const WorkScheduleHeadCell({
    super.key,
    required this.text,
    required this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
