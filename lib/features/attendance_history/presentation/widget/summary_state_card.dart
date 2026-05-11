import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_color.dart';

class SummaryStatCard extends StatelessWidget {
  const SummaryStatCard({super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.tint,
  });

  final String title;
  final int value;
  final IconData icon;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tint.withOpacity(0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: tint.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: tint),
          ),
          12.verticalSpace(),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColor.black,
              fontWeight: FontWeight.w800,
            ),
          ),
        4.verticalSpace(),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColor.blackLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
