import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:career/features/vacation/presentation/widget/custom_text_field_vacation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VacationAttachmentPicker extends StatelessWidget {
  final VacationController controller;

  const VacationAttachmentPicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                const Icon(
                  Icons.attach_file,
                  color: AppColor.primaryColor,
                  size: 18,
                ),
                SizedBox(width: 0.02.w(context)),
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children:
                        controller.selectedFiles.isEmpty
                            ? [
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  AppString.uploadAttachment.tr,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: AppColor.darkGrey,
                                  ),
                                ),
                              ),
                            ]
                            : controller.selectedFiles
                                .map(
                                  (file) => InputChip(
                                    label: Text(
                                      file,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(fontSize: 11),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    visualDensity: VisualDensity.compact,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    labelPadding: EdgeInsets.zero,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 0,
                                    ),
                                    onDeleted: () => controller.removeFile(file),
                                    deleteIconColor: AppColor.primaryColor,
                                    deleteIcon: const Icon(
                                      Icons.close,
                                      size: 16,
                                    ),
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
    });
  }
}
