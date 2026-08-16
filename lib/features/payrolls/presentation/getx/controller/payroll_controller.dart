import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/widget/snak_bar_service.dart';
import 'package:career/features/payrolls/data/models/payroll_model.dart';
import 'package:career/features/payrolls/data/repository/payroll_repository.dart';
import 'package:get/get.dart';

class PayrollController extends GetxController {
  final PayrollRepository repo = PayrollRepository();

  final RxList<PayrollRecord> payrolls = <PayrollRecord>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final Rxn<PayrollPaginationMeta> paginationMeta = Rxn<PayrollPaginationMeta>();

  // Automatically start with the current month and year
  final RxInt selectedMonth = DateTime.now().month.obs;
  final RxInt selectedYear = DateTime.now().year.obs;
  final RxInt perPage = 15.obs;

  int _currentPage = 1;

  List<String> get availableMonths => const <String>[
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  List<int> get availableYears {
    final currentYear = DateTime.now().year;
    // Generates the current year + 5 previous years
    return List<int>.generate(6, (index) => currentYear - index);
  }

  String get requestUrl => ApiEndPoints.payrollsMine(
    month: selectedMonth.value,
    year: selectedYear.value,
    perPage: perPage.value,
  );

  String get monthTitle {
    final monthIndex = (selectedMonth.value.clamp(1, 12) - 1).toInt();
    return '${availableMonths[monthIndex]} ${selectedYear.value}';
  }

  PayrollRecord? get latestPayroll => payrolls.isEmpty ? null : payrolls.first;

  bool get hasMorePages {
    final meta = paginationMeta.value;
    if (meta == null) return false;
    return meta.currentPage < meta.totalPages;
  }

  Future<void> fetchPayrolls({
    required int month,
    required int year,
    required int perPage,
  }) async {
    selectedMonth.value = month;
    selectedYear.value = year;
    this.perPage.value = perPage;
    isLoading.value = true;
    _currentPage = 1;

    try {
      final result = await repo.getMyPayrolls(
        month: month,
        year: year,
        perPage: perPage,
        page: 1,
      );

      result.fold(
        (failure) {
          SnackbarService.error(failure.message);
        },
        (data) {
          payrolls.assignAll(data);
          paginationMeta.value = repo.lastMeta;
        },
      );
    } catch (e) {
      SnackbarService.error('An unexpected error occurred while fetching payrolls.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMorePayrolls() async {
    if (!hasMorePages || isLoadingMore.value) return;

    isLoadingMore.value = true;
    final nextPage = _currentPage + 1;

    try {
      final result = await repo.getMyPayrolls(
        month: selectedMonth.value,
        year: selectedYear.value,
        perPage: perPage.value,
        page: nextPage,
      );

      result.fold(
        (failure) => SnackbarService.error(failure.message),
        (data) {
          payrolls.addAll(data);
          paginationMeta.value = repo.lastMeta;
          _currentPage = nextPage;
        },
      );
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshPayrolls() async {
    await fetchPayrolls(
      month: selectedMonth.value,
      year: selectedYear.value,
      perPage: perPage.value,
    );
  }

  Future<void> updatePeriod({required int month, required int year}) async {
    // Prevent unnecessary API calls if the period hasn't changed
    if (month == selectedMonth.value && year == selectedYear.value) {
      return;
    }

    await fetchPayrolls(month: month, year: year, perPage: perPage.value);
  }

  @override
  void onInit() {
    super.onInit();
    fetchPayrolls(
      month: selectedMonth.value,
      year: selectedYear.value,
      perPage: perPage.value,
    );
  }
}
