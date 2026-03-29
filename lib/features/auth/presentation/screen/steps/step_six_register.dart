import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:career/features/auth/presentation/widget/custom_text_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/class/app_string.dart';
import '../../getx/controller/register_controller.dart';
import '../../widget/sub_title_steps.dart';

class StepSixRegister extends GetView<RegisterController> {
  const StepSixRegister({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        SubTitleSteps(text: AppString.uploadYourPhoto.tr,),
        23.verticalSpace(),
       CustomTextAuth(text: AppString.pleaseEnterYourPhoto.tr),
        43.verticalSpace(),
        GetBuilder<RegisterController>(
          builder: (controller) {
            return Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: controller.imageFile != null
                      ? FileImage(controller.imageFile!)
                      : AssetImage(AppAsset.profileImage) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),

        12.verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add,color: AppColor.lightCyan,size: 14,),
            UnderLineText(text: AppString.addAPhoto.tr,onTap: (){
              controller.pickImageFromGallery();
              },
            ),
          ],
        )
      ],
    );
  }
}
