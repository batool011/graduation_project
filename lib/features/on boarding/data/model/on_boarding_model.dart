import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:get/get_utils/get_utils.dart';

class OnBoardingData {
  static final pages = [
    {
      "title1": AppString.title11.tr,
      "title2": AppString.title21.tr,
      "subtitle": AppString.subtitle1.tr,
      "image": AppAsset.onboardingFirst,
    },
    {
      "title1": AppString.title12.tr,
      "title2": AppString.title22.tr,
      "subtitle": AppString.subtitle2.tr,
      "image": AppAsset.onboardingSecond,
    },
    {
      "title1": AppString.title13.tr,
      "title2": AppString.title23.tr,
      "subtitle": AppString.subtitle3.tr,
      "image": AppAsset.onboardingThird,
    },
    {
      "title1": AppString.title14.tr,
      "title2": AppString.title24.tr,
      "subtitle": AppString.subtitle4.tr,
      "image": AppAsset.onboardingFourth,
    },
  ];
}
