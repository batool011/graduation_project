import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/widget/snak_bar_service.dart';
import 'package:career/features/salary_policies/data/model/salary_policy_model.dart';
import 'package:career/features/salary_policies/data/repository/salary_policies_repository.dart';
import 'package:get/get.dart';

class SalaryPoliciesController extends GetxController {
  final SalaryPoliciesRepository repo = SalaryPoliciesRepository();

  final RxList<SalaryPolicyModel> policies = <SalaryPolicyModel>[].obs;
  final RxBool isLoading = false.obs;

  String get requestUrl => ApiEndPoints.salaryPolicies;

  Future<void> fetchPolicies() async {
    isLoading.value = true;

    try {
      final result = await repo.getSalaryPolicies();

      result.fold(
        (failure) {
          SnackbarService.error(failure.message);
        },
        (data) {
          policies.assignAll(data);
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPolicies() async {
    await fetchPolicies();
  }

  @override
  void onInit() {
    super.onInit();
    fetchPolicies();
  }
}
