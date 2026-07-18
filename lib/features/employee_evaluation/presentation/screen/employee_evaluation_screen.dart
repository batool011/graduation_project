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
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.07.w(context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_off_rounded, size: 68, color: AppColor.darkGrey.withValues(alpha: 0.7)),
                      16.verticalSpace(),
                      Text(
                        'تعذر تحميل التقييم',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      8.verticalSpace(),
                      Text(
                        controller.errorMessage.value,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColor.darkGrey,
                              height: 1.6,
                            ),
                      ),
                      20.verticalSpace(),
                      FilledButton.icon(
                        onPressed: controller.loadEmployeeEvaluation,
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final evaluation = controller.evaluation;

          return Stack(
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
                                    value: evaluation == null ? '--' : evaluation.totalScoreValue.toStringAsFixed(2),
                                    icon: Icons.star_rounded,
                                    accentColor: AppColor.primaryColor,
                                  ),
                                ),
                                12.horizontalSpace(),
                                Expanded(
                                  child: EvaluationMetricCard(
                                    label: AppString.numberOfEvaluations.tr,
                                    value: '${controller.evaluationsCount}',
                                    icon: Icons.people_alt_rounded,
                                    accentColor: AppColor.secondryColor,
                                  ),
                                ),
                              ],
                            ),
                            12.verticalSpace(),
                            EvaluationMetricCard(
                              label: AppString.percentageAboveFourStars.tr,
                              value: evaluation == null ? '--' : evaluation.periodLabel,
                              icon: Icons.calendar_month_rounded,
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
                                      const Icon(Icons.auto_graph_rounded, color: AppColor.primaryColor),
                                      8.horizontalSpace(),
                                      Text(
                                        AppString.performanceBreakdown.tr,
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                       color: AppColor.primaryColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                  8.verticalSpace(),
                                  Text(
                                    evaluation?.periodLabel ?? '',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                         color: AppColor.primaryColor.withValues(alpha: 0.82),
                                        ),
                                  ),
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
                                    child: const Icon(Icons.assignment_turned_in_rounded, color: Colors.white),
                                  ),
                                  14.horizontalSpace(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          evaluation == null ? 'لا توجد بيانات' : evaluation.periodLabel,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                fontWeight: FontWeight.w800,
                                              ),
                                        ),
                                        4.verticalSpace(),
                                        Text(
                                          evaluation == null
                                              ? 'لم يتم جلب بيانات التقييم بعد'
                                              : 'إجمالي الدرجة: ${evaluation.totalScore}',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: AppColor.darkGrey,
                                              ),
                                        ),
                                        8.verticalSpace(),
                                        Text(
                                          evaluation == null
                                              ? ''
                                              : 'رقم التقييم: ${evaluation.id} • الموظف: ${evaluation.employeeId}',
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
                        itemCount: controller.details.length,
                        separatorBuilder: (_, __) => 16.verticalSpace(),
                        itemBuilder: (context, index) {
                          return EmployeeEvaluationCard(
                            evaluation: controller.details[index],
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
          );
        },
      ),
    );
  }
}