import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:career/features/work_schedule/data/model/work_day_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class WorkScheduleRepository {
  Future<Either<AppException, List<WorkDayModel>>> getWeekRows() async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(url: ApiEndPoints.workSchedule, requiresToken: true),
    );

    return result.fold(
      Left.new,
      (response) => Right(_parseRows(response)),
    );
  }

  List<WorkDayModel> _parseRows(Response response) {
    final body = response.data;

    final List<dynamic> source;
    if (body is List) {
      source = body;
    } else if (body is Map<String, dynamic>) {
      source = (body['data'] as List?) ?? (body['rows'] as List?) ?? (body['schedule'] as List?) ?? <dynamic>[];
    } else {
      source = <dynamic>[];
    }

    return source
        .whereType<Map<String, dynamic>>()
        .map(
          (item) => WorkDayModel(
            day: _stringValue(item, const ['day', 'day_name', 'name']),
            date: _stringValue(item, const ['date', 'work_date']),
            checkIn: _stringValue(item, const ['checkIn', 'check_in', 'in_time'], fallback: '-'),
            checkOut: _stringValue(item, const ['checkOut', 'check_out', 'out_time'], fallback: '-'),
            status: _stringValue(item, const ['status', 'attendance_status'], fallback: 'مكتمل'),
          ),
        )
        .toList();
  }

  String _stringValue(
    Map<String, dynamic> source,
    List<String> keys, {
    String fallback = '',
  }) {
    for (final key in keys) {
      final value = source[key];
      if (value != null) {
        final text = value.toString().trim();
        if (text.isNotEmpty) return text;
      }
    }
    return fallback;
  }
}
