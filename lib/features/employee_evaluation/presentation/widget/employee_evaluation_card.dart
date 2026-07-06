import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/employee_evaluation/domain/model/employee_evaluation_model.dart';
import 'package:career/features/employee_evaluation/presentation/widget/evaluation_tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeEvaluationCard extends StatelessWidget {
  final EmployeeEvaluationModel evaluation;

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
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.primaryColor.withValues(alpha: 0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.person_outline, color: Colors.white, size: 30),
              ),
              14.horizontalSpace(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      evaluation.employeeName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    4.verticalSpace(),
                    Text(
                      '${evaluation.jobTitle} • ${evaluation.department}',
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
                  evaluation.date,
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
                evaluation.rating.toStringAsFixed(1),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              10.horizontalSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التقييم العام',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColor.darkGrey,
                        ),
                  ),
                  4.verticalSpace(),
                  Row(
                    children: List.generate(5, (index) {
                      final isFilled = index < evaluation.rating.floor();
                      return Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Icon(
                          isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                          size: 18,
                          color: const Color(0xFFF4B400),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          18.verticalSpace(),
          Text(
            evaluation.feedback,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: AppColor.black,
                ),
          ),
          18.verticalSpace(),
          Text(
            AppString.strengths.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          10.verticalSpace(),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: evaluation.strengths
                .map((item) => EvaluationTag(text: item.tr))
                .toList(),
          ),
          18.verticalSpace(),
          Text(
            AppString.focusAreas.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          10.verticalSpace(),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: evaluation.focusAreas
                .map((item) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        color: AppColor.secondryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.secondryColor,
                            ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}