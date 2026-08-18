import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../data/model/savings_association_model.dart';
import '../screens/savings_association_detail_screen.dart';
import 'savings_status_badge.dart';

class SavingsAssociationCard extends StatelessWidget {
  const SavingsAssociationCard({super.key, required this.association});

  final SavingsAssociationModel association;

  @override
  Widget build(BuildContext context) {
    final style = SavingsStatusStyle.forStatus(association.status);
    final isInvited = association.myMembership?.isInvited == true;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => Get.to(() => SavingsAssociationDetailScreen(associationId: association.id)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isInvited ? AppColor.primaryColor.withOpacity(0.03) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isInvited ? AppColor.primaryColor.withOpacity(0.35) : AppColor.grey.withOpacity(0.16),
              width: isInvited ? 1.3 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: style.color.withOpacity(isInvited ? 0.15 : 0.08),
                blurRadius: 18,
                offset: const Offset(0, 10),
                spreadRadius: -12,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: style.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: style.color.withOpacity(0.18)),
                    ),
                    child: Icon(Icons.savings_rounded, size: 22, color: style.color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          association.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColor.black,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            SavingsStatusBadge(status: association.status, compact: true),
                            if (isInvited)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColor.secondryColor.withOpacity(0.16),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  AppString.waitingForResponse.tr,
                                  style: TextStyle(
                                    color: AppColor.secondryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColor.blackLight),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(Icons.payments_outlined, size: 15, color: AppColor.blackLight),
                  const SizedBox(width: 6),
                  Text(
                    '${AppString.monthlyAmount.tr}: ${association.monthlyAmount.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 12, color: AppColor.blackLight, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 14),
                  Icon(Icons.groups_outlined, size: 15, color: AppColor.blackLight),
                  const SizedBox(width: 6),
                  Text(
                    '${association.joinedMembersCount}${association.targetMemberCount != null ? '/${association.targetMemberCount}' : ''}',
                    style: TextStyle(fontSize: 12, color: AppColor.blackLight, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
