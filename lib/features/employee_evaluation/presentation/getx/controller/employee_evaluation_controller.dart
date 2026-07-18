import 'package:career/features/employee_evaluation/data/repository/employee_evaluation_repository.dart';
import 'package:career/features/employee_evaluation/domain/model/employee_evaluation_model.dart';
import 'package:get/get.dart';

class EmployeeEvaluationController extends GetxController {
  final EmployeeEvaluationRepository _repository = EmployeeEvaluationRepository();

  final RxBool isLoading = false.obs;
  final Rxn<EmployeeEvaluationResponse> response = Rxn<EmployeeEvaluationResponse>();
  final RxString errorMessage = ''.obs;

  EmployeeEvaluationSummary? get evaluation => response.value?.data?.evaluation;

  List<EmployeeEvaluationDetail> get details =>
      response.value?.data?.details ?? <EmployeeEvaluationDetail>[];

  int get evaluationsCount => details.length;

  @override
  void onInit() {
    super.onInit();
    loadEmployeeEvaluation();
  }

  Future<void> loadEmployeeEvaluation() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _repository.getEmployeeEvaluation();

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        response.value = null;
      },
      (value) {
        response.value = value;
      },
    );

    isLoading.value = false;
  }
}