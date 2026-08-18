import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../data/model/savings_association_model.dart';

class SavingsCycleTile extends StatelessWidget {
  const SavingsCycleTile({super.key, required this.cycle, required this.isMine});

  final SavingsCycleModel cycle;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final color = cycle.isPending
        ? const Color(0xFF94A3B8)
        : cycle.isPaid
            ? const Color(0xFF16A34A)
            : AppColor.primaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isMine ? AppColor.primaryColor.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isMine ? AppColor.primaryColor.withOpacity(0.3) : AppColor.grey.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
            child: Text(
              '${cycle.cycleNumber}',
              style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cycle.recipientName ?? (cycle.isPending ? '${AppString.statusOpenForJoining.tr}...' : '-'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  '${cycle.month}/${cycle.year}  •  ${cycle.potAmount.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 11, color: AppColor.blackLight, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          if (isMine)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                AppString.youAreRecipient.tr,
                style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w800),
              ),
            ),
        ],
      ),
    );
  }
}
