import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:career/features/payrolls/data/models/payroll_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PayrollRepository {
  PayrollPaginationMeta? _lastMeta;

  PayrollPaginationMeta? get lastMeta => _lastMeta;

  Future<Either<AppException, List<PayrollRecord>>> getMyPayrolls({
    required int month,
    required int year,
    required int perPage,
    int page = 1,
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.payrollsMine(
          month: month,
          year: year,
          perPage: perPage,
          page: page,
        ),
        requiresToken: true,
      ),
    );

    return result.fold(Left.new, (response) {
      final items = _parsePayrolls(response);
      return Right(items);
    });
  }

  List<PayrollRecord> _parsePayrolls(Response response) {
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
        .map(PayrollRecord.fromJson)
        .toList()
      ..sort((left, right) => right.sortDate.compareTo(left.sortDate));
  }

  PayrollPaginationMeta? _parseMeta(dynamic value) {
    if (value is Map<String, dynamic>) {
      return PayrollPaginationMeta.fromJson(value);
    }
    return null;
  }
}
