import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:dartz/dartz.dart';

import '../models/leave_type_model.dart';
import '../models/vacation_request_model.dart';

class VacationRepository {
  Future<Either<AppException, VacationRequest>> createVacationRequest({
    required String fromDate,
    required int duration,
    required int typeId,
    required String reason,
    String status = 'pending',
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.postData(
        url: ApiEndPoints.createVacation,
        data: {
          'from_date': fromDate,
          'duration': duration,
          'type_id': typeId,
          'reason': reason,
          'status': status,
        },
        requiresToken: true,
      ),
    );

    return result.fold(Left.new, (response) {
      final data = response.data;
      if (data is Map<String, dynamic> &&
          data['data'] is Map<String, dynamic>) {
        return Right(
          VacationRequest.fromJson(data['data'] as Map<String, dynamic>),
        );
      }
      return Left(AppException(AppString.invalidResponseFormat));
    });
  }

  Future<Either<AppException, VacationRequestsPage>>
  getVacationRequests() async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(url: ApiEndPoints.vacations, requiresToken: true),
    );

    return result.fold(Left.new, (response) {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return Right(VacationRequestsPage.fromJson(data));
      }
      return Left(AppException(AppString.invalidResponseFormat));
    });
  }

  Future<Either<AppException, List<LeaveType>>> getLeaveTypes() async {
    final result = await ApiHandler.request(
      () =>
          DioHelper.getData(url: ApiEndPoints.leaveTypes, requiresToken: true),
    );

    return result.fold(Left.new, (response) {
      final data = response.data;

      final items = _extractLeaveTypeItems(data);

      if (items == null) {
        return Left(AppException(AppString.invalidResponseFormat));
      }

      final leaveTypes =
          items
              .whereType<Map<String, dynamic>>()
              .map(LeaveType.fromJson)
              .toList();

      return Right(leaveTypes);
    });
  }

  List<dynamic>? _extractLeaveTypeItems(dynamic responseData) {
    if (responseData is List) {
      return responseData;
    }

    if (responseData is Map<String, dynamic>) {
      final directCandidates = <dynamic>[
        responseData['data'],
        responseData['leave_types'],
        responseData['leaveTypes'],
        responseData['items'],
        responseData['results'],
      ];

      for (final candidate in directCandidates) {
        final items = _extractLeaveTypeItems(candidate);
        if (items != null) {
          return items;
        }
      }

      for (final value in responseData.values) {
        final items = _extractLeaveTypeItems(value);
        if (items != null) {
          return items;
        }
      }
    }

    return null;
  }

  Future<Either<AppException, VacationRequest>> getVacationRequestDetail(
    int id,
  ) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.getVacationDetail(id),
        requiresToken: true,
      ),
    );

    return result.fold(Left.new, (response) {
      final data = response.data;
      if (data is Map<String, dynamic> &&
          data['data'] is Map<String, dynamic>) {
        return Right(
          VacationRequest.fromJson(data['data'] as Map<String, dynamic>),
        );
      }
      return Left(AppException(AppString.invalidResponseFormat));
    });
  }
}
