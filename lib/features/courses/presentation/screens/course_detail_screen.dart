import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../data/model/course_model.dart';
import '../../data/model/course_enrollment_model.dart';
import '../getx/controller/courses_controller.dart';
import '../widget/course_detail_header.dart';
import '../widget/course_file_tile.dart';
import '../widget/course_start_button.dart';
import 'course_exam_screen.dart';
import 'course_exam_results_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final int courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  final CoursesController controller = Get.isRegistered<CoursesController>()
      ? Get.find<CoursesController>()
      : Get.put(CoursesController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCourseDetail(widget.courseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: Obx(() {
        if (controller.isDetailLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.primaryColor),
          );
        }

        final CourseModel? course = controller.selectedCourse.value;
        if (course == null) {
          return _ErrorState(courseId: widget.courseId, controller: controller);
        }

        final CourseEnrollmentModel? enrollment = controller.selectedEnrollment.value;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CourseDetailHeader(course: course, enrollment: enrollment),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06,
                  vertical: MediaQuery.of(context).size.height * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle(
                      title: AppString.courseContents.tr,
                      badge: '${course.contents.length} ${AppString.file.tr}',
                    ),
                    const SizedBox(height: 16),
                    if (course.contents.isEmpty)
                      _NoContentPlaceholder()
                    else
                      ...course.contents.map(
                            (content) => Obx(
                              () => CourseFileTile(
                            content: content,
                            isMarking: controller.viewingContentId.value == content.id,
                            onOpened: () => controller.markContentViewed(
                              courseId: course.id,
                              contentId: content.id,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    _ExamSection(course: course, enrollment: enrollment),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.badge});

  final String title;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 28,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
            fontSize: 20,
          ),
        ),
        const Spacer(),
        if (badge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badge!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

class _NoContentPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.grey),
      ),
      child: Center(
        child: Text(
          AppString.noCourseMaterialsYet.tr,
          style: TextStyle(color: AppColor.blackLight),
        ),
      ),
    );
  }
}

/// Bottom call-to-action area: start / retry the exam, a completed
/// summary with a link to the attempts history, or a plain "no exam yet"
/// notice - this section is ALWAYS shown (never hidden outright) so the
/// exam feature stays discoverable even when a course has no questions
/// yet, instead of silently vanishing and looking like it doesn't exist.
class _ExamSection extends StatelessWidget {
  const _ExamSection({required this.course, required this.enrollment});

  final CourseModel course;
  final CourseEnrollmentModel? enrollment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: AppString.examTitle.tr),
        const SizedBox(height: 16),
        _buildBody(context),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    if (!course.hasExam) {
      return _NoExamPlaceholder();
    }

    // The backend already confirmed this course has an exam. If we
    // haven't resolved this employee's enrollment yet - e.g. "My Courses"
    // was fetched before the manager assigned this course, and hasn't
    // been refreshed since - default to offering "Start Exam" rather than
    // hiding it behind a wrong empty state. CourseExamService verifies
    // the real enrollment server-side regardless.
    if (enrollment == null || enrollment!.isAssigned || enrollment!.isInProgress) {
      return CourseStartButton(
        label: AppString.startExam.tr,
        icon: Icons.play_circle_filled_rounded,
        onTap: () => Get.to(() => CourseExamScreen(courseId: course.id)),
      );
    }

    if (enrollment!.isCompleted) {
      return _ResultSummaryCard(
        color: const Color(0xFF16A34A),
        icon: Icons.emoji_events_rounded,
        title: AppString.examPassedTitle.tr,
        subtitle: AppString.examPassedMessage.tr,
        score: enrollment!.latestScore,
        passPercentage: course.passPercentage,
        courseId: course.id,
      );
    }

    if (enrollment!.isFailed) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultSummaryCard(
            color: const Color(0xFFDC2626),
            icon: Icons.error_outline_rounded,
            title: AppString.examFailedTitle.tr,
            subtitle: AppString.examFailedMessage.tr,
            score: enrollment!.latestScore,
            passPercentage: course.passPercentage,
            courseId: course.id,
          ),
          const SizedBox(height: 16),
          CourseStartButton(
            label: AppString.retryExam.tr,
            icon: Icons.refresh_rounded,
            onTap: () => Get.to(() => CourseExamScreen(courseId: course.id)),
          ),
        ],
      );
    }

    return CourseStartButton(
      label: AppString.startExam.tr,
      icon: Icons.play_circle_filled_rounded,
      onTap: () => Get.to(() => CourseExamScreen(courseId: course.id)),
    );
  }
}

class _NoExamPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.grey),
      ),
      child: Row(
        children: [
          Icon(Icons.quiz_outlined, color: AppColor.darkGrey, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppString.noExamForCourse.tr,
              style: TextStyle(color: AppColor.blackLight, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultSummaryCard extends StatelessWidget {
  const _ResultSummaryCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.score,
    required this.passPercentage,
    required this.courseId,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final num? score;
  final int? passPercentage;
  final int courseId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color),
                ),
              ),
              if (score != null)
                Text(
                  '${score!.round()}%',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: color),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: TextStyle(color: AppColor.blackLight, fontSize: 13, height: 1.4)),
          if (passPercentage != null) ...[
            const SizedBox(height: 6),
            Text(
              '${AppString.passScore.tr}: $passPercentage%',
              style: TextStyle(color: AppColor.blackLight, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () => Get.to(() => CourseExamResultsScreen(courseId: courseId)),
            icon: Icon(Icons.history_rounded, size: 18, color: color),
            label: Text(
              AppString.viewExamResults.tr,
              style: TextStyle(color: color, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.courseId, required this.controller});

  final int courseId;
  final CoursesController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: AppColor.darkGrey),
            const SizedBox(height: 16),
            Text(
              AppString.unableToDisplayCourse.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColor.darkGrey),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => controller.fetchCourseDetail(courseId),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(AppString.retry.tr),
            ),
          ],
        ),
      ),
    );
  }
}
