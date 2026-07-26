import 'dart:io';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/auth/presentation/widget/custom_text_auth.dart';
import 'package:career/features/auth/presentation/widget/document_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/class/app_string.dart';
import '../../../../../core/widget/under_line_text.dart';
import '../../getx/controller/register_controller.dart';
import '../../widget/sub_title_steps.dart';

class StepThreeRegister extends GetView<RegisterController> {
  const StepThreeRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
      children: [
        SubTitleSteps(text: AppString.uploadYourPhoto.tr),
        23.verticalSpace(),
        CustomTextAuth(text: AppString.pleaseEnterYourPhoto.tr),
        20.verticalSpace(),

        GetBuilder<RegisterController>(
          builder: (controller) {
            return Center(
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryColor.withOpacity(0.15),
                      image: controller.imageFile != null
                          ? DecorationImage(
                              image: FileImage(controller.imageFile!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: controller.imageFile == null
                        ? const Icon(
                            Icons.person_rounded,
                            color: AppColor.primaryColor,
                            size: 60,
                          )
                        : null,
                  ),
                  if (controller.imageFile != null)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          controller.imageFile = null;
                          controller.update();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),

        12.verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppColor.secondryColor, size: 14),
            UnderLineText(
              text: AppString.addAPhoto.tr,
              onTap: () {
                controller.pickImageFromGallery();
              },
            ),
          ],
        ),
        30.verticalSpace(),

        DocumentPicker(
          title: AppString.employmentContract.tr,
          hint: AppString.employmentContractHint.tr,
          icon: Icons.description_rounded,
          file: controller.employmentContractFile, 
          onPick: controller.pickEmploymentContract,
          onRemove: controller.removeEmploymentContract,
        ),
        30.verticalSpace(),
      ],
    );
  }
}