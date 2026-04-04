import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:file_picker/file_picker.dart';

class VacationController extends GetxController {

  TextEditingController fileController = TextEditingController();
  final vacationType = <String>[
    AppString.female.tr,
    AppString.male.tr
  ].obs;
  final selectedVacation = RxnString();

  void setSelectedGender(String? value) {
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
  DateTime? picked = await showDatePicker(
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
  DateTime? picked = await showDatePicker(
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
    super.onInit();
  }
}


