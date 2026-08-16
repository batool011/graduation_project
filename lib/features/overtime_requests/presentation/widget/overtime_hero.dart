import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'overtime_decor_circle.dart';
import 'overtime_hero_stat.dart';

class OvertimeHero extends StatelessWidget {
  const OvertimeHero({
    super.key,
    required this.totalCount,
    required this.perPage,
  });

  final int totalCount;
  final int perPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: AppColor.heroGradient(),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF334155).withOpacity(0.22),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -34,
            top: -30,
            child: OvertimeDecorCircle(size: 132, opacity: 0.12),
          ),
          Positioned(
            left: -30,
            bottom: -36,
            child: const OvertimeDecorCircle(size: 108, opacity: 0.08),
          ),
          Positioned(
            right: 56,
            bottom: -24,
            child: const OvertimeDecorCircle(size: 58, opacity: 0.10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.18),
                      ),
                    ),
                    child: const Icon(
                      Icons.access_time_rounded,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.overtimeRequests.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.2,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppString.requestOvertime.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Colors.white.withOpacity(0.82),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OvertimeHeroStat(
                      icon: Icons.receipt_long_rounded,
                      value: '$totalCount',
                      label: AppString.record.tr,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OvertimeHeroStat(
                      icon: Icons.view_list_rounded,
                      value: '$perPage',
                      label: AppString.perPage.tr,
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
