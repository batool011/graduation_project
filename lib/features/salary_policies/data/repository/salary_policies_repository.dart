import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:career/features/salary_policies/data/model/salary_policy_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SalaryPoliciesRepository {
  Future<Either<AppException, List<SalaryPolicyModel>>>
  getSalaryPolicies() async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.salaryPolicies,
        requiresToken: true,
      ),
    );

    return result.fold(Left.new, (response) {
      return Right(_parseSalaryPolicies(response));
    });
  }

  List<SalaryPolicyModel> _parseSalaryPolicies(Response response) {
    final body = response.data;
    final List<dynamic> source;

    if (body is Map<String, dynamic>) {
      final data = body['data'];
      if (data is List) {
        source = data;
      } else {
        source = <dynamic>[];
      }
    } else if (body is List) {
      source = body;
    } else {
      source = <dynamic>[];
    }

    return source
        .whereType<Map<String, dynamic>>()
        .map(SalaryPolicyModel.fromJson)
        .toList()
      ..sort((left, right) => right.sortDate.compareTo(left.sortDate));
  }
}
