import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/complaints/presentation/getx/controller/complaints_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddComplaintDialog extends GetView<ComplaintsController> {
  const AddComplaintDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Text(AppString.addNewComplaint.tr),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.writeClearTitle.tr,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            12.verticalSpace(),
            TextField(
              controller: controller.titleController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: AppString.complaintTitle.tr,
                hintText: AppString.complaintTitleHint.tr,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.descriptionController,
              minLines: 3,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: AppString.complaintDetails.tr,
                hintText: AppString.complaintDetailsHint.tr,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            AppString.cancel.tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
          ),
        ),
        Obx(
          () => ElevatedButton(
            onPressed: controller.isSubmitting.value ? null : controller.submitComplaint,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 0.1.w(context)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: controller.isSubmitting.value
                ? const SizedBox(
                    width: 20,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    AppString.submit.tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          color: AppColor.white,
                        ),
                  ),
          ),
        ),
      ],
    );
  }
}