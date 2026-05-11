import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:career/features/complaints/data/model/complaint_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ComplaintsRepository {
  Future<Either<AppException, List<ComplaintModel>>> getComplaints() async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.getAllComplaint,
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) => Right(_parseComplaints(response)),
    );
  }

  Future<Either<AppException, Response>> addComplaint({
    required String title,
    required String description,
  }) {
    return ApiHandler.request(
      () => DioHelper.postData(
        url: ApiEndPoints.addComplaint,
        requiresToken: true,
        data: {
          'title': title,
          'description': description,
        },
      ),
    );
  }

  List<ComplaintModel> _parseComplaints(Response response) {
    final body = response.data;

    final List<dynamic> source;
    if (body is List) {
      source = body;
    } else if (body is Map<String, dynamic>) {
      final data = body['data'];
      if (data is List) {
        source = data;
      } else if (data is Map<String, dynamic>) {
        source =
            (data['items'] as List?) ??
            (data['rows'] as List?) ??
            (data['complaints'] as List?) ??
            <dynamic>[];
      } else {
        source =
            (body['rows'] as List?) ??
            (body['complaints'] as List?) ??
            <dynamic>[];
      }
    } else {
      source = <dynamic>[];
    }

    return source
        .whereType<Map<String, dynamic>>()
        .map(
          (item) => ComplaintModel(
            id: _intValue(item, const ['id', 'complaint_id']),
            title: _stringValue(item, const ['title', 'subject'], fallback: 'شكوى'),
            description: _stringValue(
              item,
              const ['description', 'message', 'content'],
              fallback: '-',
            ),
            status: _stringValue(item, const ['status', 'state'], fallback: 'pending'),
            createdAt: _stringValue(
              item,
              const ['created_at', 'createdAt', 'date'],
              fallback: '-',
            ),
          ),
        )
        .toList();
  }

  int _intValue(Map<String, dynamic> source, List<String> keys, {int fallback = 0}) {
    for (final key in keys) {
      final value = source[key];
      if (value is int) return value;
      if (value is String) {
        final parsed = int.tryParse(value.trim());
        if (parsed != null) return parsed;
      }
    }
    return fallback;
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