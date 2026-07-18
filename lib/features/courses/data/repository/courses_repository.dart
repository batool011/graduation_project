import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:dartz/dartz.dart';
import '../model/course_model.dart';

class CoursesRepository {
  Future<Either<AppException, List<CourseModel>>> getCourses({
    String? title,
    String? duration,
    String? courseTarget,
    int page = 1,
    int perPage = 15,
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url:
         ApiEndPoints.getCourses(
           title: title,
          duration: duration,
           courseTarget: courseTarget,
          page: page,
           perPage: perPage,
         ),
        requiresToken: true,
      ),
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          final data = response.data['data'];
          final coursesJson = data['courses'] as List<dynamic>;
          final courses = coursesJson
              .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Right(courses);
        } catch (e) {
          return Left(AppException('تعذر تحميل الدورات'));
        }
      },
    );
  }

  Future<Either<AppException, CourseModel>> getCourseDetail(int id) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url:ApiEndPoints.getCourseDetail(id),
        requiresToken: true,
      ),
    );

    return result.fold(
      (failure) => Left(failure),
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
}