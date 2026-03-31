import 'package:get/get.dart';
import 'package:career/core/constant/class/app_string.dart';

class VacationController extends GetxController {

  final vacationType = <String>[
    AppString.female.tr,
    AppString.male.tr
  ].obs;
  final selectedVacation = RxnString();




  void setSelectedGender(String? value) {
    selectedVacation.value = value;
  }


  @override
  void onInit() {
    super.onInit();
  }
}


