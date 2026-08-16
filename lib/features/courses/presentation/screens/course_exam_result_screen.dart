import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../getx/controller/courses_controller.dart';
import '../widget/course_start_button.dart';
import 'course_exam_screen.dart';

/// Shown right after CourseExamScreen submits - reads the fresh attempt
/// from controller.lastExamAttempt (set by CoursesController.submitExam).
class CourseExamResultScreen extends StatelessWidget {
  final int courseId;
  const CourseExamResultScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CoursesController>();

    return Obx(() {
      final attempt = controller.lastExamAttempt.value;
      final passed = attempt?.passed ?? false;
      final color = passed ? const Color(0xFF16A34A) : const Color(0xFFDC2626);

      return Scaffold(
        backgroundColor: AppColor.scaffoldColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.12),
                    border: Border.all(color: color.withOpacity(0.24), width: 2),
                  ),
                  child: Icon(
                    passed ? Icons.emoji_events_rounded : Icons.sentiment_dissatisfied_rounded,
                    size: 60,
                    color: color,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  passed ? AppString.examPassedTitle.tr : AppString.examFailedTitle.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: color),
                ),
                const SizedBox(height: 8),
                Text(
                  passed ? AppString.examPassedMessage.tr : AppString.examFailedMessage.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: AppColor.blackLight, height: 1.5),
                ),
                const SizedBox(height: 28),
                if (attempt != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColor.grey.withOpacity(0.4)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppString.yourScore.tr, style: TextStyle(color: AppColor.blackLight, fontSize: 13)),
                            Text(
                              '${attempt.score.round()}%',
                              style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 18),
                            ),
                          ],
                        ),
                        if (controller.examPassPercentage.value > 0) ...[
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppString.passScore.tr, style: TextStyle(color: AppColor.blackLight, fontSize: 12)),
                              Text(
                                '${controller.examPassPercentage.value}%',
                                style: TextStyle(color: AppColor.blackLight, fontWeight: FontWeight.w700, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppString.correctAnswersCount.tr, style: TextStyle(color: AppColor.blackLight, fontSize: 13)),
                            Text(
                              '${attempt.correctAnswers} / ${attempt.totalQuestions}',
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 28),
                if (!passed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CourseStartButton(
                      label: AppString.retryExam.tr,
                      icon: Icons.refresh_rounded,
                      onTap: () => Get.off(() => CourseExamScreen(courseId: courseId)),
                    ),
                  ),
                CourseStartButton(
                  label: AppString.backToCourse.tr,
                  icon: Icons.arrow_back_rounded,
                  outlined: !passed,
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
