import 'package:get/get.dart';
import '../../../../../core/widget/snak_bar_service.dart';
import '../../../data/model/course_model.dart';
import '../../../data/model/course_enrollment_model.dart';
import '../../../data/model/course_exam_model.dart';
import '../../../data/repository/courses_repository.dart';

class CoursesController extends GetxController {
  final CoursesRepository _repository = CoursesRepository();

  // ───────────────────────── My Courses (list) ─────────────────────────
  final RxList<CourseEnrollmentModel> myCourses = <CourseEnrollmentModel>[].obs;
  final RxBool isLoading = false.obs;

  /// null = "All". Otherwise one of CourseEnrollmentStatus.*
  final Rx<String?> selectedStatusFilter = Rx<String?>(null);

  List<CourseEnrollmentModel> get filteredCourses {
    final filter = selectedStatusFilter.value;
    if (filter == null) return myCourses.toList();
    return myCourses.where((e) => e.status == filter).toList();
  }

  int get overdueCount => myCourses.where((e) => e.isOverdue).length;

  void setStatusFilter(String? status) {
    selectedStatusFilter.value = status;
  }

  Future<void> fetchMyCourses({bool silently = false}) async {
    if (!silently) isLoading.value = true;
    final result = await _repository.getMyCourses();
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (data) => myCourses.assignAll(data),
    );
    if (!silently) isLoading.value = false;
  }

  CourseEnrollmentModel? enrollmentForCourse(int courseId) {
    for (final enrollment in myCourses) {
      if (enrollment.courseId == courseId) return enrollment;
    }
    return null;
  }

  // ───────────────────────── Course detail & content ─────────────────────────
  final Rx<CourseModel?> selectedCourse = Rx<CourseModel?>(null);
  final RxBool isDetailLoading = false.obs;
  final Rx<CourseEnrollmentModel?> selectedEnrollment = Rx<CourseEnrollmentModel?>(null);
  final RxnInt viewingContentId = RxnInt();

  Future<void> fetchCourseDetail(int courseId) async {
    isDetailLoading.value = true;
    selectedCourse.value = null;
    selectedEnrollment.value = enrollmentForCourse(courseId);

    final result = await _repository.getCourseDetail(courseId);
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (data) => selectedCourse.value = data,
    );
    isDetailLoading.value = false;
  }

  Future<void> markContentViewed({
    required int courseId,
    required int contentId,
  }) async {
    viewingContentId.value = contentId;

    final result = await _repository.markContentViewed(
      courseId: courseId,
      contentId: contentId,
    );

    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (updatedEnrollment) {
        selectedEnrollment.value = updatedEnrollment;
        _replaceEnrollmentInList(updatedEnrollment);
      },
    );

    viewingContentId.value = null;
  }

  void _replaceEnrollmentInList(CourseEnrollmentModel updated) {
    final index = myCourses.indexWhere((e) => e.id == updated.id);
    if (index == -1) return;
    myCourses[index] = updated;
    myCourses.refresh();
  }

  // ───────────────────────── Exam ─────────────────────────
  final RxList<CourseExamQuestionModel> examQuestions = <CourseExamQuestionModel>[].obs;
  final RxInt examPassPercentage = 0.obs;
  final RxBool isExamLoading = false.obs;
  final RxMap<int, String> selectedAnswers = <int, String>{}.obs;
  final RxBool isSubmittingExam = false.obs;
  final Rx<CourseExamAttemptModel?> lastExamAttempt = Rx<CourseExamAttemptModel?>(null);

  final RxList<CourseExamAttemptModel> examAttemptsHistory = <CourseExamAttemptModel>[].obs;
  final RxBool isExamHistoryLoading = false.obs;

  bool get isExamReadyToSubmit =>
      examQuestions.isNotEmpty && selectedAnswers.length == examQuestions.length;

  int get answeredQuestionsCount => selectedAnswers.length;

  void resetExamState() {
    examQuestions.clear();
    examPassPercentage.value = 0;
    selectedAnswers.clear();
    lastExamAttempt.value = null;
  }

  Future<void> fetchExamQuestions(int courseId) async {
    isExamLoading.value = true;
    resetExamState();

    final result = await _repository.getExamQuestions(courseId);
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (exam) {
        examQuestions.assignAll(exam.questions);
        examPassPercentage.value = exam.passPercentage;
      },
    );
    isExamLoading.value = false;
  }

  void selectAnswer(int questionId, String answer) {
    selectedAnswers[questionId] = answer;
  }

  Future<bool> submitExam(int courseId) async {
    if (!isExamReadyToSubmit) {
      SnackbarService.error('يرجى الإجابة على جميع الأسئلة قبل الإرسال');
      return false;
    }

    isSubmittingExam.value = true;

    final answers = examQuestions
        .map((q) => {
              'question_id': q.id,
              'answer': selectedAnswers[q.id] ?? '',
            })
        .toList();

    final result = await _repository.submitExam(courseId: courseId, answers: answers);

    var success = false;
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (attempt) {
        lastExamAttempt.value = attempt;
        success = true;
      },
    );

    if (success) {
      // Resync progress/status from the backend rather than recomputing
      // the 70/30 content/exam split on the client.
      await fetchMyCourses(silently: true);
      selectedEnrollment.value = enrollmentForCourse(courseId);
    }

    isSubmittingExam.value = false;
    return success;
  }

  Future<void> fetchExamResults(int courseId) async {
    isExamHistoryLoading.value = true;
    final result = await _repository.getExamResults(courseId);
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (attempts) => examAttemptsHistory.assignAll(attempts),
    );
    isExamHistoryLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyCourses();
  }
}
