import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:career/features/overtime_requests/data/model/overtime_request_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class OvertimeRepository {
  OvertimeRequestMeta? _lastMeta;

  OvertimeRequestMeta? get lastMeta => _lastMeta;

  Future<Either<AppException, List<OvertimeRequestModel>>> getRequests({
    required int perPage,
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.overtimeRequests(perPage: perPage),
        requiresToken: true,
      ),
    );

    return result.fold(Left.new, (response) {
      return Right(_parseRequests(response));
    });
  }

  Future<Either<AppException, OvertimeRequestModel>> createRequest({
    required String date,
    required int minutes,
    required String reason,
    required int shiftId,
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.postData(
        url: ApiEndPoints.createOvertimeRequest,
        data: {
          'date': date,
          'minutes': minutes,
          'reason': reason,
          'shift_id': shiftId,
        },
        requiresToken: true,
      ),
    );

    return result.fold(Left.new, (response) {
      final body = response.data;
      if (body is Map<String, dynamic>) {
        final data = body['data'];
        if (data is Map<String, dynamic>) {
          return Right(OvertimeRequestModel.fromJson(data));
        }
      }
      return Right(
        OvertimeRequestModel.fromJson(
          (body is Map<String, dynamic> ? body : <String, dynamic>{})
              .cast<String, dynamic>(),
        ),
      );
    });
  }

  List<OvertimeRequestModel> _parseRequests(Response response) {
    final body = response.data;
    final List<dynamic> source;

    if (body is Map<String, dynamic>) {
      _lastMeta = _parseMeta(body['meta']);
      final data = body['data'];
      if (data is List) {
        source = data;
      } else {
        source = <dynamic>[];
      }
    } else if (body is List) {
      _lastMeta = null;
      source = body;
    } else {
      _lastMeta = null;
      source = <dynamic>[];
    }

    return source
        .whereType<Map<String, dynamic>>()
        .map(OvertimeRequestModel.fromJson)
        .toList()
      ..sort((left, right) => right.sortDate.compareTo(left.sortDate));
  }

  OvertimeRequestMeta? _parseMeta(dynamic value) {
    if (value is Map<String, dynamic>) {
      return OvertimeRequestMeta.fromJson(value);
    }
    return null;
  }
}
