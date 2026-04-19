import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  Future<Either<AppException, Response>> submitAttendance({
    required String token,
  }) async {
    return ApiHandler.request(
      () => DioHelper.postData(
        url: ApiEndPoints.attendance,
        data: {'token': token},
        requiresToken: true,
      ),
    );
  }
}