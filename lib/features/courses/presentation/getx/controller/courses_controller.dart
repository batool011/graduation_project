import 'package:get/get.dart';
import '../../../../../core/widget/snak_bar_service.dart';
import '../../../data/model/course_model.dart';
import '../../../data/repository/courses_repository.dart';

class CoursesController extends GetxController {
  final CoursesRepository _repository = CoursesRepository();

  final RxList<CourseModel> courses = <CourseModel>[].obs;
  final RxBool isLoading = false.obs;

  final Rx<CourseModel?> selectedCourse = Rx<CourseModel?>(null);
  final RxBool isDetailLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    isLoading.value = true;
    final result = await _repository.getCourses();
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (data) => courses.assignAll(data),
    );
    isLoading.value = false;
  }

  Future<void> fetchCourseDetail(int id) async {
    isDetailLoading.value = true;
    selectedCourse.value = null;
    final result = await _repository.getCourseDetail(id);
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (data) => selectedCourse.value = data,
    );
    isDetailLoading.value = false;
  }
}