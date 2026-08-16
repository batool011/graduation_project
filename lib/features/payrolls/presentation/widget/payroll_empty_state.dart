import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'payroll_theme.dart';

class PayrollEmptyState extends StatelessWidget {
  const PayrollEmptyState({super.key, required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: PayrollTheme.softBorder),
        boxShadow: [
          BoxShadow(
            color: PayrollTheme.ink.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 16),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: PayrollTheme.brandGradient(),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.22),
                  blurRadius: 20,
                  offset: const Offset(0, 12),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: 38,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppString.noPayrollData.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: PayrollTheme.ink,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            AppString.refresh.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: PayrollTheme.subInk,
                ),
          ),
          const SizedBox(height: 22),
          Container(
            height: 46,
            decoration: BoxDecoration(
              gradient: PayrollTheme.brandGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.22),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => onRefresh(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.refresh_rounded, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        AppString.refresh.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
