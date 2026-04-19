import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../../core/widget/custom_date_picker_field.dart';

class VacationController extends GetxController {

  TextEditingController fileController = TextEditingController();
  late final RxList<String> vacationType;
  final selectedVacation = RxnString();

  void setSelectedVacationType(String? value) {
    selectedVacation.value = value;
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

  Future<void> selectDateFrom(BuildContext context) async {
  DateTime? picked = await showAppDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2024),
  lastDate: DateTime(2100),
  );

  if (picked != null) {
  dateFrom.value = "${picked.day}/${picked.month}/${picked.year}";
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
  dateTo.value = "${picked.day}/${picked.month}/${picked.year}";
  }
  }

  @override
  void onInit() {
    vacationType = <String>[
      AppString.annualLeave.tr,
      AppString.sickLeave.tr,
      AppString.emergencyLeave.tr,
    ].obs;
    super.onInit();
  }
}


