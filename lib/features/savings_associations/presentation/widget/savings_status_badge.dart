import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_string.dart';

class SavingsStatusStyle {
  final Color color;
  final IconData icon;
  final String label;

  const SavingsStatusStyle({required this.color, required this.icon, required this.label});

  factory SavingsStatusStyle.forStatus(String status) {
    switch (status) {
      case 'open_for_joining':
        return SavingsStatusStyle(
          color: const Color(0xFF2563EB),
          icon: Icons.how_to_reg_rounded,
          label: AppString.statusOpenForJoining.tr,
        );
      case 'active':
        return SavingsStatusStyle(
          color: const Color(0xFFF59E0B),
          icon: Icons.autorenew_rounded,
          label: AppString.statusActive.tr,
        );
      case 'completed':
        return SavingsStatusStyle(
          color: const Color(0xFF16A34A),
          icon: Icons.verified_rounded,
          label: AppString.statusCompleted.tr,
        );
      case 'cancelled':
        return SavingsStatusStyle(
          color: const Color(0xFFDC2626),
          icon: Icons.cancel_rounded,
          label: AppString.statusCancelled.tr,
        );
      default:
        return SavingsStatusStyle(
          color: const Color(0xFF64748B),
          icon: Icons.drafts_rounded,
          label: AppString.statusDraft.tr,
        );
    }
  }
}

class SavingsStatusBadge extends StatelessWidget {
  const SavingsStatusBadge({super.key, required this.status, this.compact = false});

  final String status;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final style = SavingsStatusStyle.forStatus(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 10, vertical: compact ? 4 : 6),
      decoration: BoxDecoration(
        color: style.color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: style.color.withOpacity(0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(style.icon, size: compact ? 12 : 14, color: style.color),
          const SizedBox(width: 4),
          Text(
            style.label,
            style: TextStyle(color: style.color, fontSize: compact ? 10 : 11, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
