import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:dartz/dartz.dart';
import '../model/course_model.dart';
import '../model/course_enrollment_model.dart';
import '../model/course_exam_model.dart';

class CoursesRepository {
  /// The employee's own assigned courses ("My Courses"), optionally
  /// filtered by CourseEnrollmentStatus.
  Future<Either<AppException, List<CourseEnrollmentModel>>> getMyCourses({
    String? status,
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.myCourses(status: status),
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) {
        try {
          final data = response.data['data'] as List<dynamic>? ?? [];
          final enrollments = data
              .whereType<Map<String, dynamic>>()
              .map(CourseEnrollmentModel.fromJson)
              .toList();
          return Right(enrollments);
        } catch (e) {
          return Left(AppException('تعذر تحميل دوراتي التدريبية'));
        }
      },
    );
  }

  /// Full course details (title/description/contents) for the content
  /// screen. Works for any course the employee's company owns, but the
  /// interesting fields (contents) only matter once the employee is
  /// actually enrolled.
  Future<Either<AppException, CourseModel>> getCourseDetail(int id) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.getCourseDetail(id),
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) {
        try {
          final data = response.data['data'];
          return Right(CourseModel.fromJson(data as Map<String, dynamic>));
        } catch (e) {
          return Left(AppException('تعذر تحميل تفاصيل الدورة'));
        }
      },
    );
  }

  /// Marks one content item as opened/viewed and returns the updated
  /// enrollment (new progress_percentage / status).
  Future<Either<AppException, CourseEnrollmentModel>> markContentViewed({
    required int courseId,
    required int contentId,
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.postData(
        url: ApiEndPoints.markCourseContentViewed(courseId, contentId),
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) {
        try {
          final data = response.data['data'];
          return Right(CourseEnrollmentModel.fromJson(data as Map<String, dynamic>));
        } catch (e) {
          return Left(AppException('تعذر تحديث تقدمك في الدورة'));
        }
      },
    );
  }

  Future<Either<AppException, CourseExamModel>> getExamQuestions(
    int courseId,
  ) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.courseExamQuestions(courseId),
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) {
        try {
          final data = response.data['data'];
          return Right(CourseExamModel.fromJson(data as Map<String, dynamic>));
        } catch (e) {
          return Left(AppException('تعذر تحميل أسئلة الاختبار'));
        }
      },
    );
  }

  /// [answers] must be a list of {'question_id': int, 'answer': String}.
  Future<Either<AppException, CourseExamAttemptModel>> submitExam({
    required int courseId,
    required List<Map<String, dynamic>> answers,
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.postData(
        url: ApiEndPoints.submitCourseExam(courseId),
        data: {'answers': answers},
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) {
        try {
          final data = response.data['data'];
          return Right(CourseExamAttemptModel.fromJson(data as Map<String, dynamic>));
        } catch (e) {
          return Left(AppException('تعذر إرسال إجاباتك، حاول مرة أخرى'));
        }
      },
    );
  }

  Future<Either<AppException, List<CourseExamAttemptModel>>> getExamResults(
    int courseId,
  ) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.courseExamResults(courseId),
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) {
        try {
          final data = response.data['data'] as List<dynamic>? ?? [];
          final attempts = data
              .whereType<Map<String, dynamic>>()
              .map(CourseExamAttemptModel.fromJson)
              .toList();
          return Right(attempts);
        } catch (e) {
          return Left(AppException('تعذر تحميل نتائج الاختبار'));
        }
      },
    );
  }
}
