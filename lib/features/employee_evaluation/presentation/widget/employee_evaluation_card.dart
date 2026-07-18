import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/employee_evaluation/domain/model/employee_evaluation_model.dart';
import 'package:career/features/employee_evaluation/presentation/widget/evaluation_tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeEvaluationCard extends StatelessWidget {
  final EmployeeEvaluationDetail evaluation;

  const EmployeeEvaluationCard({super.key, required this.evaluation});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.primaryColor.withValues(alpha: 0.78)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.tune_rounded, color: Colors.white, size: 30),
              ),
              14.horizontalSpace(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      evaluation.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    4.verticalSpace(),
                    Text(
                      evaluation.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  evaluation.weightLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          18.verticalSpace(),
          Row(
            children: [
              Text(
                evaluation.scoreLabel,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              10.horizontalSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.overallRating.tr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.darkGrey,
                    ),
                  ),
                  4.verticalSpace(),
                  Row(
                    children: [
                      Icon(Icons.circle_rounded, size: 10, color: AppColor.secondryColor),
                      6.horizontalSpace(),
                      Text(
                        evaluation.weightLabel,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.darkGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          18.verticalSpace(),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: _progressValue,
              minHeight: 10,
              backgroundColor: AppColor.primaryColor.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
            ),
          ),
          14.verticalSpace(),
          Row(
            children: [
              Expanded(
                child: EvaluationTag(
                  text: '${AppString.percentageAboveFourStars.tr}: ${evaluation.scoreLabel}',
                ),
              ),
              8.horizontalSpace(),
              Expanded(
                child: EvaluationTag(
                  text: '${AppString.numberOfEvaluations.tr}: ${evaluation.weightLabel}',
                ),
              ),
            ],
          ),
          14.verticalSpace(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColor.secondryColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              evaluation.raw ?? 'لا توجد ملاحظات إضافية لهذه القيمة.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: AppColor.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// KPI scores come back on a 0-10 scale (confirmed against
  /// total_score = sum(score * weight/100) in the real API response),
  /// so the progress bar is simply score / 10.
  double get _progressValue {
    final score = evaluation.scoreValue;
    if (score <= 0) return 0;
    return (score / 10).clamp(0, 1);
  }
}