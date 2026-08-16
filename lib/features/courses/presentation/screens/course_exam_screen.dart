import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/custom_dialog.dart';
import '../getx/controller/courses_controller.dart';
import '../widget/course_start_button.dart';
import '../widget/exam_question_card.dart';
import 'course_exam_result_screen.dart';

class CourseExamScreen extends StatefulWidget {
  final int courseId;
  const CourseExamScreen({super.key, required this.courseId});

  @override
  State<CourseExamScreen> createState() => _CourseExamScreenState();
}

class _CourseExamScreenState extends State<CourseExamScreen> {
  final CoursesController controller = Get.isRegistered<CoursesController>()
      ? Get.find<CoursesController>()
      : Get.put(CoursesController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchExamQuestions(widget.courseId);
    });
  }

  Future<void> _handleSubmit() async {
    if (!controller.isExamReadyToSubmit) {
      return;
    }

    await showCustomDialog(
      context,
      title: AppString.submitExamConfirmTitle.tr,
      subtitle: AppString.submitExamConfirmMessage.tr,
      image: const Icon(Icons.assignment_turned_in_rounded, size: 48, color: AppColor.primaryColor),
      confirmText: AppString.submitAnswers.tr,
      cancelText: AppString.cancel.tr,
      onConfirm: () async {
        final success = await controller.submitExam(widget.courseId);
        if (success && mounted) {
          Navigator.of(context).pop();
          Get.off(() => CourseExamResultScreen(courseId: widget.courseId));
        } else if (mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.examTitle.tr),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isExamLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor));
          }

          if (controller.examQuestions.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.quiz_outlined, size: 56, color: AppColor.darkGrey),
                    const SizedBox(height: 16),
                    Text(
                      AppString.noExamForCourse.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColor.blackLight),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              _AnswerProgressBar(controller: controller),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.examQuestions.length,
                  itemBuilder: (context, index) {
                    final question = controller.examQuestions[index];
                    return Obx(
                      () => ExamQuestionCard(
                        index: index,
                        question: question,
                        selectedAnswer: controller.selectedAnswers[question.id],
                        onSelect: (answer) => controller.selectAnswer(question.id, answer),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Obx(
                  () => CourseStartButton(
                    label: AppString.submitAnswers.tr,
                    icon: Icons.send_rounded,
                    isLoading: controller.isSubmittingExam.value,
                    onTap: controller.isExamReadyToSubmit ? _handleSubmit : null,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _AnswerProgressBar extends StatelessWidget {
  const _AnswerProgressBar({required this.controller});

  final CoursesController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final total = controller.examQuestions.length;
      final answered = controller.answeredQuestionsCount;
      final ratio = total == 0 ? 0.0 : answered / total;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppString.question.tr} $answered / $total',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColor.blackLight,
                  ),
                ),
                if (!controller.isExamReadyToSubmit)
                  Text(
                    AppString.answerAllQuestions.tr,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF59E0B),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 6,
                backgroundColor: AppColor.grey.withOpacity(0.4),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
              ),
            ),
          ],
        ),
      );
    });
  }
}
