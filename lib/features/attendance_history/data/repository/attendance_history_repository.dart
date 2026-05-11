import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/attendance_history_model.dart';

class AttendanceHistoryRepository {
  PaginationMeta? _lastMeta;

  PaginationMeta? get lastMeta => _lastMeta;

  Future<Either<AppException, List<AttendanceHistory>>> getAttendanceHistory({
    required int month,
    required int year,
    required int perPage,
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.attendanceHistory,
        query: {'month': month, 'year': year, 'per_page': perPage},
        requiresToken: true,
      ),
    );

    return result.fold(Left.new, (response) {
      final items = _parseAttendanceHistory(response);
      return Right(items);
    });
  }

  List<AttendanceHistory> _parseAttendanceHistory(Response response) {
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
        .map(AttendanceHistory.fromJson)
        .toList();
  }

  PaginationMeta? _parseMeta(dynamic value) {
    if (value is Map<String, dynamic>) {
      return PaginationMeta.fromJson(value);
    }
    return null;
  }
}
