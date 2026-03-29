import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/class/app_asset.dart';
import '../../../../../core/constant/class/app_string.dart';
import '../../getx/controller/register_controller.dart';
import '../../widget/custom_drop_down_button.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/sub_title_steps.dart';

class StepFiveRegister extends GetView<RegisterController> {
  const StepFiveRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SubTitleSteps(text: AppString.workExperiences.tr,),
        23.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.company,fit: BoxFit.scaleDown,),hintText: AppString.companyName.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.position,fit: BoxFit.scaleDown,),hintText: AppString.position.tr),
        12.verticalSpace(),
        Row(
          children: [
            Obx(() {
              return Expanded(
                child: CustomDropdown(
                  value: controller.selectedGender.value,
                  items: controller.genderItems,
                  hint: AppString.dateFrom.tr,
                  onChanged: controller.setSelectedGender,
                  prefixIcon: SvgPicture.asset(AppAsset.date),
                ),
              );
            }),
            Obx(() {
              return Expanded(
                child: CustomDropdown(
                  value: controller.selectedGender.value,
                  items: controller.genderItems,
                  hint: AppString.dateTo.tr,
                  onChanged: controller.setSelectedGender,
                  prefixIcon: SvgPicture.asset(AppAsset.date),
                ),
              );
            }),
          ],
        ),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.about,fit: BoxFit.scaleDown,),hintText: AppString.about.tr,isComment: true),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.location,fit: BoxFit.scaleDown,),hintText: AppString.linksOrObject.tr),

      ],
    );
  }
}
