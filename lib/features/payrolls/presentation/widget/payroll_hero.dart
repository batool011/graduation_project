import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'payroll_state_widgets.dart';
import 'payroll_theme.dart';

class PayrollHero extends StatelessWidget {
  const PayrollHero({
    super.key,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
    required this.availableMonths,
    required this.selectedMonth,
    required this.availableYears,
    required this.selectedYear,
    required this.onMonthChanged,
    required this.onYearChanged,
  });

  final int totalCount;
  final int currentPage;
  final int totalPages;
  final List<String> availableMonths;
  final int selectedMonth;
  final List<int> availableYears;
  final int selectedYear;

  final ValueChanged<int?> onMonthChanged;
  final ValueChanged<int?> onYearChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: PayrollTheme.brandGradient(),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 18),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -30,
            top: -24,
            child: PayrollDecorCircle(size: 135, opacity: 0.10),
          ),
          const Positioned(
            left: -32,
            bottom: -26,
            child: PayrollDecorCircle(size: 96, opacity: 0.08),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.16)),
                    ),
                    child: const Icon(
                      Icons.payments_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.payrollSummary.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${AppString.month.tr}: ${availableMonths[selectedMonth - 1]} $selectedYear',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Colors.white.withOpacity(0.85),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: PayrollHeroDropdown<int>(
                      icon: Icons.calendar_month_rounded,
                      value: selectedMonth,
                      items: List.generate(12, (i) => i + 1),
                      labels: availableMonths,
                      onChanged: onMonthChanged,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PayrollHeroDropdown<int>(
                      icon: Icons.calendar_today_rounded,
                      value: selectedYear,
                      items: availableYears,
                      labels: availableYears.map((e) => e.toString()).toList(),
                      onChanged: onYearChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: PayrollHeroStat(
                      icon: Icons.receipt_long_rounded,
                      value: '$totalCount',
                      label: AppString.record.tr,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PayrollHeroStat(
                      icon: Icons.view_list_rounded,
                      value: totalPages > 1 ? '$currentPage/$totalPages' : '$totalPages',
                      label: AppString.page.tr,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PayrollHeroDropdown<T> extends StatelessWidget {
  const PayrollHeroDropdown({
    super.key,
    required this.icon,
    required this.value,
    required this.items,
    required this.labels,
    required this.onChanged,
  });

  final IconData icon;
  final T value;
  final List<T> items;
  final List<String> labels;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.9), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isExpanded: true,
                isDense: true,
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                style: const TextStyle(
                  color: PayrollTheme.ink,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                selectedItemBuilder: (context) {
                  return labels.map((label) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList();
                },
                items: List.generate(items.length, (index) {
                  return DropdownMenuItem<T>(
                    value: items[index],
                    child: Text(
                      labels[index],
                      style: const TextStyle(
                        color: PayrollTheme.ink,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  );
                }),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PayrollHeroStat extends StatelessWidget {
  const PayrollHeroStat({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.16)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 17),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
