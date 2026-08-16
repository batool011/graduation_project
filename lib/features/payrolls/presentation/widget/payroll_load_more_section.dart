import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/payrolls/presentation/getx/controller/payroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayrollLoadMoreSection extends StatelessWidget {
  const PayrollLoadMoreSection({super.key, required this.controller});

  final PayrollController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.hasMorePages) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 8),
        child: Center(
          child: controller.isLoadingMore.value
              ? const Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(strokeWidth: 2.4),
                )
              : OutlinedButton.icon(
                  onPressed: controller.loadMorePayrolls,
                  icon: const Icon(Icons.expand_more_rounded, size: 18),
                  label: Text(AppString.loadMore.tr),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColor.primaryColor,
                    side: BorderSide(color: AppColor.primaryColor.withOpacity(0.5)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
        ),
      );
    });
  }
}
