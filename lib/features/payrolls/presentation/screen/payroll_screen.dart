import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/features/payrolls/presentation/getx/controller/payroll_controller.dart';
import 'package:career/features/payrolls/presentation/widget/payroll_empty_state.dart';
import 'package:career/features/payrolls/presentation/widget/payroll_hero.dart';
import 'package:career/features/payrolls/presentation/widget/payroll_load_more_section.dart';
import 'package:career/features/payrolls/presentation/widget/payroll_record_card.dart';
import 'package:career/features/payrolls/presentation/widget/payroll_state_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayrollScreen extends GetView<PayrollController> {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.payrolls.tr),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.payrolls.isEmpty) {
            return const PayrollLoadingState();
          }

          return RefreshIndicator(
            color: AppColor.primaryColor,
            onRefresh: controller.refreshPayrolls,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
              children: [
                PayrollHero(
                  totalCount: controller.paginationMeta.value?.total ??
                      controller.payrolls.length,
                  currentPage: controller.paginationMeta.value?.currentPage ?? 1,
                  totalPages: controller.paginationMeta.value?.totalPages ?? 1,
                  availableMonths: controller.availableMonths,
                  selectedMonth: controller.selectedMonth.value,
                  availableYears: controller.availableYears,
                  selectedYear: controller.selectedYear.value,
                  onMonthChanged: (month) {
                    if (month != null) {
                      controller.updatePeriod(
                        month: month,
                        year: controller.selectedYear.value,
                      );
                    }
                  },
                  onYearChanged: (year) {
                    if (year != null) {
                      controller.updatePeriod(
                        month: controller.selectedMonth.value,
                        year: year,
                      );
                    }
                  },
                ),
                const SizedBox(height: 18),
                if (controller.payrolls.isEmpty)
                  PayrollEmptyState(onRefresh: controller.refreshPayrolls)
                else ...[
                  ...controller.payrolls.map(
                    (record) => Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: PayrollRecordCard(record: record),
                    ),
                  ),
                  PayrollLoadMoreSection(controller: controller),
                ],
                const SizedBox(height: 24),
              ],
            ),
          );
        }),
      ),
    );
  }
}
