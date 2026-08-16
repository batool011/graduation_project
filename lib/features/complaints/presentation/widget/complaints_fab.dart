import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/complaints/presentation/getx/controller/complaints_controller.dart';
import 'package:career/features/complaints/presentation/widget/add_complaint_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintsFab extends GetView<ComplaintsController> {
  const ComplaintsFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        controller.prepareNewComplaint();
        Get.dialog(const AddComplaintDialog());
      },
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.white,
      elevation: 6,
      highlightElevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(
          color: Colors.white.withOpacity(0.14),
        ),
      ),
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.add_comment_rounded,
          size: 20,
        ),
      ),
      label: Text(
        AppString.newComplaint.tr,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColor.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}