import 'package:get/get.dart';
import '../../../data/model/on_boarding_model.dart';

class OnBoardingController extends GetxController {
  final pages = OnBoardingData.pages;

  RxInt currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value == pages.length - 1) {
      Get.offAllNamed("/login");
    } else {
      currentPage.value++;
    }
  }
}
