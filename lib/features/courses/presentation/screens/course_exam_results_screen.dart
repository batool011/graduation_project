import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../data/model/course_exam_model.dart';
import '../getx/controller/courses_controller.dart';

class CourseExamResultsScreen extends StatefulWidget {
  final int courseId;
  const CourseExamResultsScreen({super.key, required this.courseId});

  @override
  State<CourseExamResultsScreen> createState() => _CourseExamResultsScreenState();
}

class _CourseExamResultsScreenState extends State<CourseExamResultsScreen> {
  final CoursesController controller = Get.find<CoursesController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchExamResults(widget.courseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.examAttemptsHistory.tr),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isExamHistoryLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor));
          }

          if (controller.examAttemptsHistory.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history_rounded, size: 56, color: AppColor.darkGrey),
                    const SizedBox(height: 16),
                    Text(
                      AppString.noPreviousAttempts.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColor.blackLight),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.examAttemptsHistory.length,
            itemBuilder: (context, index) {
              return _AttemptCard(attempt: controller.examAttemptsHistory[index]);
            },
          );
        }),
      ),
    );
  }
}

class _AttemptCard extends StatelessWidget {
  const _AttemptCard({required this.attempt});

  final CourseExamAttemptModel attempt;

  @override
  Widget build(BuildContext context) {
    final color = attempt.passed ? const Color(0xFF16A34A) : const Color(0xFFDC2626);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: -10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              attempt.passed ? Icons.check_rounded : Icons.close_rounded,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppString.attemptNumber.tr} ${attempt.attemptNumber}',
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '${attempt.correctAnswers} / ${attempt.totalQuestions} ${AppString.correctAnswersCount.tr}',
                  style: TextStyle(fontSize: 12, color: AppColor.blackLight),
                ),
              ],
            ),
          ),
          Text(
            '${attempt.score.round()}%',
            style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
