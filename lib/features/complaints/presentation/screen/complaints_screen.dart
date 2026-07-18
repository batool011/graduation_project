import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/features/complaints/presentation/getx/controller/complaints_controller.dart';
import 'package:career/features/complaints/presentation/widget/complaints_body.dart';
import 'package:career/features/complaints/presentation/widget/complaints_fab.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class ComplaintsScreen extends GetView<ComplaintsController> {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.complaints.tr),
      ),
      body: const ComplaintsBody(),
      floatingActionButton: const ComplaintsFab(),
    );
  }
}