import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:career/features/vacation/presentation/widget/custom_drop_down_vacation.dart';
import 'package:career/features/vacation/presentation/widget/custom_text_field_vacation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_date_picker_field.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/custom_button_primary.dart';

class VacationScreen extends GetView<VacationController> {
  const VacationScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: PreferredSize(preferredSize: Size(double.infinity,70),
        child: CustomAppBar(text: AppString.leaveRequest.tr,)),
    body: ListView(
      children: [
       Lottie.asset(AppAsset.permission,height: 0.2.h(context),width: 500),
        Obx(() {
          return CustomDropDownVacation(
            value: controller.selectedVacation.value,
            items: controller.vacationType,
            hint: AppString.selectVacationType.tr,
            onChanged: controller.setSelectedVacationType,
            prefixIcon: Icon(Icons.beach_access_outlined,color: AppColor.primaryColor,),
          );
        }),
        10.verticalSpace(),
        Row(
          children: [
            Obx(() {
              return Expanded(
                child: CustomDatePickerField(
                  hintText: AppString.dateFrom.tr,
                  value: controller.dateFrom.value,
                  prefixIcon: const Icon(Icons.calendar_today_outlined, color: AppColor.primaryColor, size: 20),
                  onTap: () => controller.selectDateFrom(context),
                ),
              );
            }),
            Obx(() {
              return Expanded(
                child: CustomDatePickerField(
                  hintText: AppString.dateTo.tr,
                  value: controller.dateTo.value,
                  prefixIcon: const Icon(Icons.calendar_today_outlined, color: AppColor.primaryColor, size: 20),
                  onTap: () => controller.selectDateTo(context),
                ),
              );
            }),
          ],
        ),
        10.verticalSpace(),
        CustomTextFieldVacation(hintText: AppString.reason.tr,),
        10.verticalSpace(),
        CustomTextFieldVacation(hintText: AppString.numberOfDay.tr,textInputType: TextInputType.number,),
        10.verticalSpace(),
        Obx(() {
          return CustomTextFieldVacation(
            hintText: AppString.uploadAttachment.tr,
            readOnly: true,
            prefix: const Icon(Icons.attach_file),
            onTap: controller.pickFiles,
            child: InkWell(
              onTap: controller.pickFiles,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 0.05.w(context),
                  vertical: 0.02.h(context),
                ),
                decoration: BoxDecoration(
                  color: AppColor.lightGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.attach_file, color: AppColor.primaryColor, size: 18),
                    SizedBox(width: 0.02.w(context)),
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: controller.selectedFiles.isEmpty
                            ? [
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    AppString.uploadAttachment.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: AppColor.darkGrey),
                                  ),
                                ),
                              ]
                            : controller.selectedFiles
                                .map(
                                  (file) => InputChip(
                                    label: Text(
                                      file,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    visualDensity: VisualDensity.compact,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    labelPadding: EdgeInsets.zero,
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                                    onDeleted: () => controller.removeFile(file),
                                    deleteIconColor: AppColor.primaryColor,
                                    deleteIcon: const Icon(Icons.close, size: 16),
                                    backgroundColor: AppColor.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        15.verticalSpace(),
        CustomButtonPrimary(text: AppString.applyNow.tr,),
        CustomButtonPrimary(text: AppString.showLastVacation.tr,)
      ],
    ),
  );
  }
}
