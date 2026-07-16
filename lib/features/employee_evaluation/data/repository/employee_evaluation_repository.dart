import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:career/features/employee_evaluation/domain/model/employee_evaluation_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class EmployeeEvaluationRepository {
  Future<Either<AppException, EmployeeEvaluationResponse>>
  getEmployeeEvaluation() async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.employeeEvaluation,
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) => Right(_parseEmployeeEvaluation(response)),
    );
  }

  EmployeeEvaluationResponse _parseEmployeeEvaluation(Response response) {
    final body = response.data;

    if (body is Map<String, dynamic>) {
      return EmployeeEvaluationResponse.fromJson(body);
    }

    throw FormatException('Invalid employee evaluation response');
  }
}