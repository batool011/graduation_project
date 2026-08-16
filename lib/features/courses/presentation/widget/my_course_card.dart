import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../data/model/course_enrollment_model.dart';
import '../screens/course_detail_screen.dart';
import 'course_progress_bar.dart';
import 'course_status_badge.dart';

class MyCourseCard extends StatelessWidget {
  final CourseEnrollmentModel enrollment;
  final bool featured;

  const MyCourseCard({super.key, required this.enrollment, this.featured = false});

  @override
  Widget build(BuildContext context) {
    final style = CourseStatusStyle.forStatus(enrollment.status);
    final showOverdue = enrollment.isOverdue && !enrollment.isCompleted;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => Get.to(() => CourseDetailScreen(courseId: enrollment.courseId)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: featured ? AppColor.primaryColor.withOpacity(0.03) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: featured
                  ? AppColor.primaryColor.withOpacity(0.35)
                  : AppColor.grey.withOpacity(0.16),
              width: featured ? 1.3 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: style.color.withOpacity(featured ? 0.15 : 0.08),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: style.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: style.color.withOpacity(0.18)),
                    ),
                    child: Icon(Icons.school_rounded, size: 22, color: style.color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          enrollment.title,
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
                            CourseStatusBadge(status: enrollment.status, compact: true),
                            if (showOverdue) const CourseOverdueBadge(),
                            if (enrollment.course?.isMandatory == true)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColor.secondryColor.withOpacity(0.14),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  AppString.courseMandatory.tr,
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
              CourseProgressBar(percentage: enrollment.progressPercentage, color: style.color),
              if (enrollment.dueAt != null && !enrollment.isCompleted) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.event_rounded, size: 13, color: showOverdue ? const Color(0xFFDC2626) : AppColor.blackLight),
                    const SizedBox(width: 4),
                    Text(
                      '${AppString.courseDueDate.tr}: ${_formatDate(enrollment.dueAt!)}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: showOverdue ? const Color(0xFFDC2626) : AppColor.blackLight,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}-${date.month}-${date.year}';
}
