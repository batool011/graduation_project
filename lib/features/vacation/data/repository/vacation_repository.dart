import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../models/vacation_request_model.dart';

class VacationRepository {
  Future<Either<AppException, VacationRequest>> createVacationRequest({
    required String fromDate,
    required int duration,
    required String reason,
    String status = 'pending',
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.postData(
        url: ApiEndPoints.createVacation,
        data: {
          'from_date': fromDate,
          'duration': duration,
          'reason': reason,
          'status': status,
        },
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) {
        final data = response.data;
        if (data is Map<String, dynamic> && data['data'] is Map<String, dynamic>) {
          return Right(VacationRequest.fromJson(data['data']));
        }
        return Left(AppException('Invalid response format'));
      },
    );
  }

  Future<Either<AppException, VacationRequestsPage>> getVacationRequests() async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.vacations,
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return Right(VacationRequestsPage.fromJson(data));
        }
        return Left(AppException('Invalid response format'));
      },
    );
  }

  Future<Either<AppException, VacationRequest>> getVacationRequestDetail(int id) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.getVacationDetail(id),
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) {
        final data = response.data;
        if (data is Map<String, dynamic> && data['data'] is Map<String, dynamic>) {
          return Right(VacationRequest.fromJson(data['data'] as Map<String, dynamic>));
        }
        return Left(AppException('Invalid response format'));
      },
    );
  }
}
