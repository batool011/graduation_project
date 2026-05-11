import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:career/features/tasks/data/model/task_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TasksRepository {
  Future<Either<AppException, List<TaskModel>>> getTasks() async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(url: ApiEndPoints.tasks, requiresToken: true),
    );

    return result.fold(Left.new, (response) => Right(_parseTasks(response)));
  }

  List<TaskModel> _parseTasks(Response response) {
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
            (data['tasks'] as List?) ??
            (data['rows'] as List?) ??
            <dynamic>[];
      } else {
        source =
            (body['tasks'] as List?) ?? (body['rows'] as List?) ?? <dynamic>[];
      }
    } else {
      source = <dynamic>[];
    }

    return source
        .whereType<Map<String, dynamic>>()
        .map(TaskModel.fromJson)
        .toList();
  }
}
