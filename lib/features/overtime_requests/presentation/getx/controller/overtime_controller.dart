import 'package:career/core/widget/snak_bar_service.dart';
import 'package:career/core/cache/cach_helper.dart';
import 'package:career/core/network/api_end_point.dart';
import 'package:career/features/overtime_requests/data/model/overtime_request_model.dart';
import 'package:career/features/overtime_requests/data/repository/overtime_repository.dart';
import 'package:career/features/profile/data/model/profile_model.dart';
import 'package:career/features/profile/presentation/getx/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OvertimeController extends GetxController {
  final OvertimeRepository repo = OvertimeRepository();
  final CacheHelper _cacheHelper = CacheHelper();
  Worker? _profileWorker;

  final RxList<OvertimeRequestModel> requests = <OvertimeRequestModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final Rxn<OvertimeRequestMeta> paginationMeta = Rxn<OvertimeRequestMeta>();

  final dateController = TextEditingController();
  final minutesController = TextEditingController();
  final reasonController = TextEditingController();
  final shiftIdController = TextEditingController();

  final RxnString selectedDate = RxnString();
  final RxnInt prefilledShiftId = RxnInt();
  final RxnString prefilledShiftName = RxnString();

  final RxInt perPage = 15.obs;

  String get requestUrl =>
      ApiEndPoints.overtimeRequests(perPage: perPage.value);

  String get endpointLabel => 'GET /api/v1/overtime-requests';

  OvertimeRequestModel? get latestRequest =>
      requests.isEmpty ? null : requests.first;

  Future<void> fetchRequests() async {
    isLoading.value = true;

    try {
      final result = await repo.getRequests(perPage: perPage.value);

      result.fold(
        (failure) {
          SnackbarService.error(failure.message);
        },
        (data) {
          requests.assignAll(data);
          paginationMeta.value = repo.lastMeta;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshRequests() async {
    await fetchRequests();
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final initialDate =
        selectedDate.value != null
            ? DateTime.tryParse(selectedDate.value!) ?? now
            : now;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );

    if (picked != null) {
      final value = _formatDate(picked);
      selectedDate.value = value;
      dateController.text = value;
    }
  }

  void syncShiftFromProfile() {
    Shift? shift;

    if (!Get.isRegistered<ProfileController>()) {
      final cachedShift = _cacheHelper.getCachedProfileShift();
      if (cachedShift != null) {
        shift = Shift.fromJson(cachedShift);
      }
    } else {
      final profileController = Get.find<ProfileController>();
      final profile = profileController.profile.value;
      shift = profile?.shift;

      if (shift == null) {
        final cachedShift = _cacheHelper.getCachedProfileShift();
        if (cachedShift != null) {
          shift = Shift.fromJson(cachedShift);
        }
      }
    }

    if (shift == null) {
      return;
    }

    prefilledShiftId.value = shift.id;
    prefilledShiftName.value = shift.name;
    shiftIdController.text = shift.id.toString();
  }

  Future<void> submitRequest() async {
    final date = dateController.text.trim();
    final minutesText = minutesController.text.trim();
    final reason = reasonController.text.trim();
    final shiftIdText = shiftIdController.text.trim();

    if (date.isEmpty ||
        minutesText.isEmpty ||
        reason.isEmpty ||
        shiftIdText.isEmpty) {
      SnackbarService.error('يرجى تعبئة جميع الحقول');
      return;
    }

    final minutes = int.tryParse(minutesText);
    final shiftId = prefilledShiftId.value ?? int.tryParse(shiftIdText);

    if (minutes == null || minutes <= 0) {
      SnackbarService.error('يرجى إدخال عدد دقائق صحيح');
      return;
    }

    if (shiftId == null || shiftId <= 0) {
      SnackbarService.error('يرجى إدخال معرّف شفت صحيح');
      return;
    }

    isSubmitting.value = true;

    try {
      final result = await repo.createRequest(
        date: date,
        minutes: minutes,
        reason: reason,
        shiftId: shiftId,
      );

      result.fold(
        (failure) {
          SnackbarService.error(failure.message);
        },
        (request) {
          SnackbarService.success('تم إرسال طلب العمل الإضافي بنجاح');
          requests.insert(0, request);
          dateController.clear();
          minutesController.clear();
          reasonController.clear();
          if (prefilledShiftId.value == null) {
            shiftIdController.clear();
          }
        },
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<ProfileController>()) {
      final profileController = Get.find<ProfileController>();
      _profileWorker = ever<ProfileModel?>(
        profileController.profile,
        (_) => syncShiftFromProfile(),
      );
    }

    syncShiftFromProfile();
    fetchRequests();
  }

  @override
  void onClose() {
    _profileWorker?.dispose();
    dateController.dispose();
    minutesController.dispose();
    reasonController.dispose();
    shiftIdController.dispose();
    super.onClose();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
