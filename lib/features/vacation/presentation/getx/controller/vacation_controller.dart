import 'package:flutter/cupertino.dart';
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
  @override
  void onInit() {
    super.onInit();
  }
}


