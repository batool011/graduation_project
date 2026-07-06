import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/employee_evaluation/presentation/getx/controller/employee_evaluation_controller.dart';
import 'package:career/features/employee_evaluation/presentation/widget/employee_evaluation_card.dart';
import 'package:career/features/employee_evaluation/presentation/widget/evaluation_metric_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeEvaluationScreen extends GetView<EmployeeEvaluationController> {
  const EmployeeEvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Stack(
        children: [
          Container(
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.primaryColor.withValues(alpha: 0.95),
                  AppColor.primaryColor,
                  AppColor.primaryColor.withValues(alpha: 0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            right: -50,
            top: 40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.verticalSpace(),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.verified_rounded, color: Colors.white, size: 18),
                                  const SizedBox(width: 6),
                                  Text(
                                    AppString.performanceReport.tr,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        28.verticalSpace(),
                        Text(
                          AppString.employeeEvaluation.tr,
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        10.verticalSpace(),
                        Text(
                          AppString.evaluationRecordForEmployee.tr,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withValues(alpha: 0.85),
                                height: 1.6,
                              ),
                        ),
                        28.verticalSpace(),
                        Row(
                          children: [
                            Expanded(
                              child: EvaluationMetricCard(
                                label: AppString.overallRating.tr,
                                value: controller.overallRating.value.toStringAsFixed(1),
                                icon: Icons.star_rounded,
                                accentColor: AppColor.primaryColor,
                              ),
                            ),
                            12.horizontalSpace(),
                            Expanded(
                              child: EvaluationMetricCard(
                                label: AppString.numberOfEvaluations.tr,
                                value: '12',
                                icon: Icons.people_alt_rounded,
                                accentColor: AppColor.secondryColor,
                              ),
                            ),
                          ],
                        ),
                        12.verticalSpace(),
                        EvaluationMetricCard(
                          label: AppString.percentageAboveFourStars.tr,
                          value: '83%',
                          icon: Icons.trending_up_rounded,
                          accentColor: AppColor.primaryColor.withValues(alpha: 0.7),
                        ),
                        24.verticalSpace(),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(0.045.w(context)),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.auto_graph_rounded, color: Colors.white),
                                  8.horizontalSpace(),
                                  Text(
                                    AppString.performanceBreakdown.tr,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                              18.verticalSpace(),
                              ...controller.ratingBreakdown.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              (item['label'] as String).tr,
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            '${((item['value'] as double) * 100).round()}%',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white.withValues(alpha: 0.8),
                                                ),
                                          ),
                                        ],
                                      ),
                                      8.verticalSpace(),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(999),
                                        child: LinearProgressIndicator(
                                          value: item['value'] as double,
                                          minHeight: 10,
                                          backgroundColor: Colors.white.withValues(alpha: 0.16),
                                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        26.verticalSpace(),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(0.04.w(context)),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 20,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColor.primaryColor.withValues(alpha: 0.9),
                                      AppColor.primaryColor,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: const Icon(Icons.badge_outlined, color: Colors.white),
                              ),
                              14.horizontalSpace(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.employeeProfile.employeeName,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    4.verticalSpace(),
                                    Text(
                                      '${controller.employeeProfile.jobTitle} • ${controller.employeeProfile.department}',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: AppColor.darkGrey,
                                          ),
                                    ),
                                    8.verticalSpace(),
                                    Text(
                                      '${AppString.employeeId.tr}: ${controller.employeeProfile.employeeId}',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.verticalSpace(),
                        Text(
                          AppString.recentEvaluations.tr,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColor.black,
                              ),
                        ),
                        8.verticalSpace(),
                        Text(
                          AppString.evaluationRecordForEmployee.tr,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColor.darkGrey,
                              ),
                        ),
                        16.verticalSpace(),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
                  sliver: SliverList.separated(
                    itemCount: controller.evaluations.length,
                    separatorBuilder: (_, __) => 16.verticalSpace(),
                    itemBuilder: (context, index) {
                      return EmployeeEvaluationCard(
                        evaluation: controller.evaluations[index],
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: 28.verticalSpace(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}