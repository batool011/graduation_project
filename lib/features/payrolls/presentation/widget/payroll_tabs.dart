import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/payrolls/data/models/payroll_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'payroll_deduction_detail_tiles.dart';
import 'payroll_section_title.dart';
import 'payroll_theme.dart';
import 'payroll_tiles.dart';

class PayrollSummaryTab extends StatelessWidget {
  const PayrollSummaryTab({super.key, required this.record});

  final PayrollRecord record;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            PayrollInfoBadge(
              icon: Icons.calendar_month_outlined,
              label: '${AppString.calculatedAt.tr}: ${record.calculatedAtLabel}',
            ),
            const SizedBox(width: 8),
            PayrollInfoBadge(
              icon: Icons.trending_down_rounded,
              label:
                  '${AppString.totalDeduction.tr}: ${formatPayrollMoney(record.totalDeduction)}',
            ),
          ],
        ),
        const SizedBox(height: 16),
        PayrollSectionTitle(
          icon: Icons.dashboard_rounded,
          title: AppString.payrollSummary.tr,
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 700 ? 3 : 2;

            return GridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.26,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                PayrollMetricTile(
                  label: AppString.basicSalary.tr,
                  value: formatPayrollMoney(record.basicSalary),
                  icon: Icons.payments_outlined,
                ),
                PayrollMetricTile(
                  label: AppString.workingDays.tr,
                  value: record.workingDays.toString(),
                  icon: Icons.calendar_month_outlined,
                ),
                PayrollMetricTile(
                  label: AppString.presentDays.tr,
                  value: record.presentDays.toString(),
                  icon: Icons.check_circle_outline,
                ),
                PayrollMetricTile(
                  label: AppString.absenceDays.tr,
                  value: record.absenceDays.toString(),
                  icon: Icons.do_not_disturb_on_outlined,
                ),
                PayrollMetricTile(
                  label: AppString.unpaidLeaveDays.tr,
                  value: record.unpaidLeaveDays.toString(),
                  icon: Icons.event_busy_outlined,
                ),
                PayrollMetricTile(
                  label: AppString.totalDeduction.tr,
                  value: formatPayrollMoney(record.totalDeduction),
                  icon: Icons.remove_circle_outline,
                ),
                PayrollMetricTile(
                  label: AppString.lateMinutes.tr,
                  value: record.lateMinutes.toString(),
                  icon: Icons.timer_outlined,
                ),
                PayrollMetricTile(
                  label: AppString.earlyLeaveMinutes.tr,
                  value: record.earlyLeaveMinutes.toString(),
                  icon: Icons.exit_to_app_outlined,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class PayrollRatesTab extends StatelessWidget {
  const PayrollRatesTab({super.key, required this.record});

  final PayrollRecord record;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PayrollSectionTitle(
          icon: Icons.percent_rounded,
          title: AppString.payrollRates.tr,
        ),
        const SizedBox(height: 10),
        PayrollRateCard(
          icon: Icons.today_rounded,
          label: AppString.dayRate.tr,
          value: formatPayrollMoney(record.rates.dayRate, fractionDigits: 4),
        ),
        const SizedBox(height: 10),
        PayrollRateCard(
          icon: Icons.schedule_rounded,
          label: AppString.hourRate.tr,
          value: formatPayrollMoney(record.rates.hourRate, fractionDigits: 4),
        ),
        const SizedBox(height: 10),
        PayrollRateCard(
          icon: Icons.more_time_rounded,
          label: AppString.minuteRate.tr,
          value: formatPayrollMoney(record.rates.minuteRate, fractionDigits: 4),
        ),
      ],
    );
  }
}

class PayrollDeductionsTab extends StatelessWidget {
  const PayrollDeductionsTab({super.key, required this.record});

  final PayrollRecord record;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PayrollSectionTitle(
          icon: Icons.remove_circle_outline,
          title: AppString.deductions.tr,
          count: record.deductions.length,
        ),
        const SizedBox(height: 10),
        if (record.deductions.isEmpty)
          PayrollEmptySectionBox(text: AppString.noData.tr)
        else
          Column(
            children: record.deductions
                .map(
                  (deduction) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PayrollDeductionTile(deduction: deduction),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class PayrollDetailsTab extends StatelessWidget {
  const PayrollDetailsTab({super.key, required this.record});

  final PayrollRecord record;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PayrollSectionTitle(
          icon: Icons.event_note_rounded,
          title: AppString.payrollDetails.tr,
          count: record.details.length,
        ),
        const SizedBox(height: 10),
        if (record.details.isEmpty)
          PayrollEmptySectionBox(text: AppString.noData.tr)
        else
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                record.details.map((detail) => PayrollDetailChip(detail: detail)).toList(),
          ),
      ],
    );
  }
}
