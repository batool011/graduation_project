import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/snak_bar_service.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../../core/widget/custom_date_picker_field.dart';
import '../../../data/models/leave_type_model.dart';
import '../../../data/models/vacation_request_model.dart';
import '../../../data/repository/vacation_repository.dart';

class VacationController extends GetxController {
  final VacationRepository repo = VacationRepository();

  TextEditingController fileController = TextEditingController();
  final RxList<LeaveType> vacationTypes = <LeaveType>[].obs;
  final selectedVacation = RxnString();
  final selectedVacationLabel = RxnString();
  final isLoading = false.obs;
  final isVacationListLoading = false.obs;
  final isVacationDetailLoading = false.obs;
  final isVacationTypesLoading = false.obs;
  final vacationRequests = <VacationRequest>[].obs;
  final vacationMeta = Rxn<VacationPaginationMeta>();
  final vacationDetail = Rxn<VacationRequest>();
  final loadedVacationDetailId = RxnInt();

  void setSelectedVacationType(String? value) {
    selectedVacation.value = value;
    final selectedType = vacationTypes.firstWhereOrNull(
      (type) => type.dropdownValue == value,
    );
    selectedVacationLabel.value = selectedType?.displayText;
  }


  RxList<String> selectedFiles = <String>[].obs;

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      selectedFiles.addAll(result.files.map((file) => file.name));
    }
  }

  void removeFile(String fileName) {
    selectedFiles.remove(fileName);
  }



  RxString dateFrom = ''.obs;
  RxString dateTo = ''.obs;
  TextEditingController reasonController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  Future<void> selectDateFrom(BuildContext context) async {
  DateTime? picked = await showAppDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2024),
  lastDate: DateTime(2100),
  );

  if (picked != null) {
          dateFrom.value = "${picked.day}-${picked.month}-${picked.year}";
  }
  }

  Future<void> selectDateTo(BuildContext context) async {
  DateTime? picked = await showAppDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2024),
  lastDate: DateTime(2100),
  );

  if (picked != null) {
          dateTo.value = "${picked.day}-${picked.month}-${picked.year}";
  }
  }

  Future<void> submitVacationRequest() async {
    final from = dateFrom.value.trim();
    final duration = durationController.text.trim();
    final selectedType = selectedVacation.value;

    if (from.isEmpty || duration.isEmpty) {
      SnackbarService.error(AppString.fillAllFields.tr);
      return;
    }

    if (selectedType == null) {
      SnackbarService.error(AppString.selectVacationTypeRequired.tr);
      return;
    }

    final typeId = int.tryParse(selectedType);
    if (typeId == null) {
      SnackbarService.error(AppString.invalidVacationType.tr);
      return;
    }

    final durationInt = int.tryParse(duration);
    if (durationInt == null || durationInt <= 0) {
      SnackbarService.error(AppString.invalidNumberOfDays.tr);
      return;
    }

    isLoading.value = true;

    try {
      final result = await repo.createVacationRequest(
        fromDate: from,
        duration: durationInt,
        typeId: typeId,
        reason: selectedVacationLabel.value ?? '',
      );

      result.fold(
        (failure) {
          SnackbarService.error(failure.message.tr);
        },
        (vacationRequest) {
          dateFrom.value = '';
          dateTo.value = '';
          durationController.clear();
          reasonController.clear();
          selectedFiles.clear();
          selectedVacation.value = null;
          selectedVacationLabel.value = null;
          SnackbarService.success(AppString.vacationRequestSubmitted.tr);
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLeaveTypes() async {
    isVacationTypesLoading.value = true;

    try {
      final result = await repo.getLeaveTypes();

      result.fold(
        (failure) {
          SnackbarService.error(failure.message.tr);
        },
        (leaveTypes) {
          vacationTypes.assignAll(leaveTypes);
        },
      );
    } finally {
      isVacationTypesLoading.value = false;
    }
  }

  Future<void> fetchVacationRequests() async {
    isVacationListLoading.value = true;

    try {
      final result = await repo.getVacationRequests();

      result.fold(
        (failure) {
          SnackbarService.error(failure.message);
        },
        (page) {
          vacationRequests.assignAll(page.items);
          vacationMeta.value = page.meta;
          if (page.items.isEmpty) {
            SnackbarService.error(AppString.noVacationRequests.tr);
          }
        },
      );
    } finally {
      isVacationListLoading.value = false;
    }
  }

  Future<void> loadVacationRequestDetail(int id) async {
    if (loadedVacationDetailId.value == id && vacationDetail.value?.id == id) {
      return;
    }

    loadedVacationDetailId.value = id;
    vacationDetail.value = null;
    isVacationDetailLoading.value = true;

    try {
      final result = await repo.getVacationRequestDetail(id);

      result.fold(
        (failure) {
          SnackbarService.error(failure.message.tr);
        },
        (request) {
          vacationDetail.value = request;
        },
      );
    } finally {
      isVacationDetailLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchLeaveTypes();
  }

  @override
  void onClose() {
    reasonController.dispose();
    durationController.dispose();
    fileController.dispose();
    super.onClose();
  }
}


