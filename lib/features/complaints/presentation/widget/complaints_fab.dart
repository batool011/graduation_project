import 'package:career/core/constant/class/app_color.dart';
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
      icon: const Icon(Icons.add_comment_outlined),
      label: const Text('شكوى جديدة'),
    );
  }
}