import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/payrolls/data/models/payroll_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'payroll_theme.dart';

class PayrollDeductionTile extends StatelessWidget {
  const PayrollDeductionTile({super.key, required this.deduction});

  final PayrollDeduction deduction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFFECACA)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC2626).withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
            spreadRadius: -8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFEE2E2),
              border: Border.all(color: const Color(0xFFFECACA)),
            ),
            child: const Icon(
              Icons.remove_circle_outline,
              color: Color(0xFFDC2626),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deduction.policy.isEmpty ? '-' : deduction.policy,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF7F1D1D),
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${AppString.metric.tr}: ${formatPayrollMoney(deduction.metric, fractionDigits: 4)} • ${AppString.metricUnit.tr}: ${deduction.metricUnit.isEmpty ? '-' : deduction.metricUnit}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: PayrollTheme.subInk,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFDC2626).withOpacity(0.08),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFDC2626).withOpacity(0.12)),
            ),
            child: Text(
              formatPayrollMoney(deduction.amount),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFB91C1C),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class PayrollDetailChip extends StatelessWidget {
  const PayrollDetailChip({super.key, required this.detail});

  final PayrollDetail detail;

  @override
  Widget build(BuildContext context) {
    final isPresent = detail.isPresent;
    final isAbsent = detail.isAbsent;

    final backgroundColor = isPresent
        ? const Color(0xFFEFFAF2)
        : isAbsent
            ? const Color(0xFFFFF1F2)
            : const Color(0xFFF8FAFC);

    final textColor = isPresent
        ? const Color(0xFF15803D)
        : isAbsent
            ? const Color(0xFFBE123C)
            : const Color(0xFF334155);

    final icon = isPresent
        ? Icons.check_circle_rounded
        : isAbsent
            ? Icons.cancel_rounded
            : Icons.event_rounded;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: textColor.withOpacity(0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 6),
          Text(
            '${detail.dateLabel} • ${detail.status}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
