import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/payrolls/data/models/payroll_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'payroll_state_widgets.dart';
import 'payroll_tabs.dart';
import 'payroll_theme.dart';
import 'payroll_tiles.dart';

class PayrollRecordCard extends StatefulWidget {
  const PayrollRecordCard({super.key, required this.record});

  final PayrollRecord record;

  @override
  State<PayrollRecordCard> createState() => _PayrollRecordCardState();
}

class _PayrollRecordCardState extends State<PayrollRecordCard> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final record = widget.record;

    final hasSavings = record.savingsAdjustments.isNotEmpty;

    final tabs = <String>[
      AppString.payrollSummary.tr,
      AppString.payrollRates.tr,
      AppString.deductions.tr,
      if (hasSavings) AppString.savingsAssociations.tr,
      AppString.payrollDetails.tr,
    ];

    final counts = <int?>[
      null,
      null,
      record.deductions.length,
      if (hasSavings) record.savingsAdjustments.length,
      record.details.length,
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: PayrollTheme.softBorder),
        boxShadow: [
          BoxShadow(
            color: PayrollTheme.ink.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 14),
            spreadRadius: -16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned(
              top: -56,
              right: -34,
              child: PayrollDecorCircle(size: 140, opacity: 0.05, color: PayrollTheme.blue),
            ),
            Positioned(
              bottom: -48,
              left: -30,
              child: PayrollDecorCircle(size: 110, opacity: 0.05, color: PayrollTheme.sky),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              gradient: PayrollTheme.brandGradient(),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primaryColor.withOpacity(0.22),
                                  blurRadius: 16,
                                  offset: const Offset(0, 10),
                                  spreadRadius: -10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  record.periodLabel,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: PayrollTheme.ink,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_rounded,
                                      size: 15,
                                      color: PayrollTheme.subInk,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        '${AppString.month.tr}: ${record.periodLabel}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: PayrollTheme.subInk,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          PayrollAmountBadge(amount: record.netSalary),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTabBar(tabs, counts),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: KeyedSubtree(
                      key: ValueKey(_selectedTab),
                      child: _buildContent(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(List<String> tabs, List<int?> counts) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: PayrollTheme.softBorder),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            tabs.length,
            (index) => Padding(
              padding: EdgeInsets.only(right: index == tabs.length - 1 ? 0 : 6),
              child: PayrollTabButton(
                label: tabs[index],
                isActive: _selectedTab == index,
                count: counts[index],
                onTap: () {
                  setState(() {
                    _selectedTab = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final record = widget.record;
    final hasSavings = record.savingsAdjustments.isNotEmpty;

    // Tab order: Summary(0), Rates(1), Deductions(2), [Savings(3) if any],
    // Details(last) - indices shift by one once the Savings tab exists.
    if (_selectedTab == 0) return PayrollSummaryTab(record: record);
    if (_selectedTab == 1) return PayrollRatesTab(record: record);
    if (_selectedTab == 2) return PayrollDeductionsTab(record: record);
    if (hasSavings && _selectedTab == 3) return PayrollSavingsTab(record: record);
    return PayrollDetailsTab(record: record);
  }
}

class PayrollTabButton extends StatelessWidget {
  const PayrollTabButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.count,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isActive ? AppColor.primaryColor.withOpacity(0.14) : Colors.transparent,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColor.primaryColor.withOpacity(0.10),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isActive ? AppColor.primaryColor : PayrollTheme.subInk,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              if (count != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColor.primaryColor.withOpacity(0.10)
                        : const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${count ?? 0}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isActive ? AppColor.primaryColor : PayrollTheme.subInk,
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
