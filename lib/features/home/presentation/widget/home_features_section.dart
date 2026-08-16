import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_card_home.dart';

class _FeatureItem {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String route;
}

class _FeatureCategory {
  const _FeatureCategory({
    required this.title,
    required this.icon,
    required this.items,
  });

  final String title;
  final IconData icon;
  final List<_FeatureItem> items;
}

/// Groups every home feature into a few clear categories instead of one
/// long flat grid - easier to scan for both a first-time employee and
/// someone who already knows exactly what they want.
class HomeFeaturesSection extends StatelessWidget {
  const HomeFeaturesSection({super.key});

  List<_FeatureCategory> _categories() => [
        _FeatureCategory(
          title: AppString.timeAndRequests.tr,
          icon: Icons.schedule_rounded,
          items: [
            _FeatureItem(
              icon: Icons.calendar_today_rounded,
              title: AppString.attendanceSchedule.tr,
              subtitle: AppString.viewDetails.tr,
              color: const Color(0xFF2563EB),
              route: RoutesName.attendanceHistory,
            ),
            _FeatureItem(
              icon: Icons.beach_access_rounded,
              title: AppString.vacations.tr,
              subtitle: AppString.viewDetails.tr,
              color: const Color(0xFF0D9488),
              route: RoutesName.vacation,
            ),
            _FeatureItem(
              icon: Icons.access_time_rounded,
              title: AppString.overtimeRequests.tr,
              subtitle: AppString.requestOvertime.tr,
              color: const Color(0xFFD97706),
              route: RoutesName.overtimeRequests,
            ),
            _FeatureItem(
              icon: Icons.checklist_rounded,
              title: AppString.tasks.tr,
              subtitle: AppString.viewDetails.tr,
              color: const Color(0xFF4F46E5),
              route: RoutesName.task,
            ),
          ],
        ),
        _FeatureCategory(
          title: AppString.performanceAndGrowth.tr,
          icon: Icons.trending_up_rounded,
          items: [
            _FeatureItem(
              icon: Icons.badge_outlined,
              title: AppString.employeeEvaluation.tr,
              subtitle: AppString.viewDetails.tr,
              color: const Color(0xFF9333EA),
              route: RoutesName.employeeEvaluation,
            ),
            _FeatureItem(
              icon: Icons.menu_book_rounded,
              title: AppString.myCourses.tr,
              subtitle: AppString.viewDetails.tr,
              color: const Color(0xFF7382BF),
              route: RoutesName.myCourses,
            ),
          ],
        ),
        _FeatureCategory(
          title: AppString.payAndSupport.tr,
          icon: Icons.account_balance_wallet_outlined,
          items: [
            _FeatureItem(
              icon: Icons.payments_outlined,
              title: AppString.payrolls.tr,
              subtitle: AppString.viewDetails.tr,
              color: const Color(0xFF16A34A),
              route: RoutesName.payrolls,
            ),
            _FeatureItem(
              icon: Icons.policy_outlined,
              title: AppString.salaryPolicies.tr,
              subtitle: AppString.salaryPolicyDetails.tr,
              color: const Color(0xFF0891B2),
              route: RoutesName.salaryPolicies,
            ),
            _FeatureItem(
              icon: Icons.campaign_outlined,
              title: AppString.complaints.tr,
              subtitle: AppString.viewDetails.tr,
              color: const Color(0xFFDC2626),
              route: RoutesName.complaints,
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final categories = _categories();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final category in categories) ...[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.06.w(context),
              vertical: 0.012.h(context),
            ),
            child: SectionHeader(title: category.title, icon: category.icon),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.05,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final item in category.items)
                  CustomCardHome(
                    icon: item.icon,
                    title: item.title,
                    subtitle: item.subtitle,
                    color: item.color,
                    onTap: () => Get.toNamed(item.route),
                  ),
              ],
            ),
          ),
          10.verticalSpace(),
        ],
      ],
    );
  }
}
