import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';

class CourseProgressBar extends StatelessWidget {
  final int percentage;
  final Color? color;
  final Color? labelColor;
  final bool showLabel;

  const CourseProgressBar({
    super.key,
    required this.percentage,
    this.color,
    this.labelColor,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = percentage.clamp(0, 100);
    final barColor = color ?? AppColor.primaryColor;
    final textColor = labelColor ?? AppColor.blackLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppString.courseProgress.tr,
                style: TextStyle(fontSize: 11, color: textColor, fontWeight: FontWeight.w600),
              ),
              Text(
                '$clamped%',
                style: TextStyle(fontSize: 11, color: labelColor ?? barColor, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: clamped / 100,
            minHeight: 7,
            backgroundColor: AppColor.grey.withOpacity(0.4),
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
      ],
    );
  }
}
