import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/auth/presentation/widget/addition_section.dart';
import 'package:career/features/auth/presentation/widget/custom_delete_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/class/app_asset.dart';
import '../../../../../core/constant/class/app_string.dart';
import '../../getx/controller/register_controller.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/sub_title_steps.dart';

class StepThreeRegister extends GetView<RegisterController> {
  const StepThreeRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SubTitleSteps(text: AppString.contactInformation.tr,),
        23.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.location,fit: BoxFit.scaleDown,),hintText: AppString.address.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.number,fit: BoxFit.scaleDown,),hintText: AppString.contactNumber.tr),
        Obx(() {
          return Column(
            children: List.generate(
              controller.numberControllers.length,
                  (index) => Padding(
                    padding:  EdgeInsets.only(top: 0.012.h(context)),
                    child: CustomTextField(
                      prefix: SvgPicture.asset(AppAsset.number,fit: BoxFit.scaleDown,),
                      suffixIcon: CustomDeleteIcon(onTap: (){controller.removeNumberField(index);},),
                      hintText: AppString.contactNumber.tr,
                      controller: controller.numberControllers[index],
                    ),
                  ),
            ),
          );
        }),
        12.verticalSpace(),
       AdditionSection(text:  AppString.addANumber.tr,onTap: (){controller.addNumberField();},),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.contactEmail,fit: BoxFit.scaleDown,),hintText: AppString.emailAddress.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.whatsapp,fit: BoxFit.scaleDown,),hintText: AppString.whatsAppNumber.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.website,fit: BoxFit.scaleDown,),hintText: AppString.website.tr),

        Obx(() {
          return Column(
            children: List.generate(
              controller.linkControllers.length,
                  (index) => Padding(
                padding:  EdgeInsets.only(top: 0.012.h(context)),
                child: CustomTextField(
                  prefix: SvgPicture.asset(AppAsset.website,fit: BoxFit.scaleDown,),
                  suffixIcon: CustomDeleteIcon(onTap: (){controller.removeLinkField(index);},),
                  hintText: AppString.website.tr,
                  controller: controller.linkControllers[index],
                ),
              ),
            ),
          );
        }),
        12.verticalSpace(),
        AdditionSection(text:  AppString.addALink.tr,onTap: (){controller.addLinkField();},),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.facebook,fit: BoxFit.scaleDown,),hintText: AppString.facebookLink.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.linkedIn,fit: BoxFit.scaleDown,),hintText: AppString.linkedinLink.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.insta,fit: BoxFit.scaleDown,),hintText: AppString.inastagramLink.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.tikTok,fit: BoxFit.scaleDown,),hintText: AppString.tikTokLink.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.snapChat,fit: BoxFit.scaleDown,),hintText: AppString.snapChatLink.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.dribble,fit: BoxFit.scaleDown,),hintText: AppString.dribbleLink.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.behance,fit: BoxFit.scaleDown,),hintText: AppString.behanceLink.tr),

      ],
    );
  }
}
