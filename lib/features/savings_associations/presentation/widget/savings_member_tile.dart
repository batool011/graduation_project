import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../data/model/savings_association_model.dart';

class SavingsMemberTile extends StatelessWidget {
  const SavingsMemberTile({super.key, required this.member});

  final SavingsMemberModel member;

  @override
  Widget build(BuildContext context) {
    final color = member.hasCollected
        ? const Color(0xFF16A34A)
        : member.isJoined
            ? AppColor.primaryColor
            : member.isDeclined
                ? const Color(0xFFDC2626)
                : const Color(0xFFF59E0B);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.grey.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
            child: Icon(
              member.hasCollected ? Icons.check_circle_rounded : Icons.person_rounded,
              size: 18,
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name ?? member.username ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
                ),
                const SizedBox(height: 2),
                Text(
                  _statusLabel(),
                  style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          if (member.payoutOrder != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '#${member.payoutOrder}',
                style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.w800, fontSize: 11),
              ),
            ),
        ],
      ),
    );
  }

  String _statusLabel() {
    if (member.hasCollected) return AppString.alreadyCollected.tr;
    if (member.isJoined) return AppString.invitationJoined.tr;
    if (member.isDeclined) return AppString.invitationDeclined.tr;
    return AppString.invitationInvited.tr;
  }
}
