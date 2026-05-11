import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/complaints/presentation/getx/controller/complaints_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddComplaintDialog extends GetView<ComplaintsController> {
  const AddComplaintDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text('إضافة شكوى جديدة'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اكتبي عنوان واضح وتفاصيل دقيقة عشان يتم التعامل مع الشكوى بسرعة.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            12.verticalSpace(),
            TextField(
              controller: controller.titleController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'عنوان الشكوى',
                hintText: 'مثال: مشكلة في جهاز البصمة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.descriptionController,
              minLines: 3,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'تفاصيل الشكوى',
                hintText: 'اشرحي المشكلة ومتى ظهرت وأي تفاصيل تساعد في الحل.',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child:  Text('إلغاء',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),),
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
                :  Text('إرسال',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15,color: AppColor.white)),
          ),
        ),
      ],
    );
  }
}