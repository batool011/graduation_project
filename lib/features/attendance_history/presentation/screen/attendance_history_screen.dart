import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/controller/attendance_history_controller.dart';
import '../widget/attendance_history_header.dart';
import '../widget/attendance_list.dart';

class AttendanceHistoryScreen extends GetView<AttendanceHistoryController> {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar:  PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.attendanceHistory.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.04.w(context),
            vertical: 0.02.h(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final meta = controller.paginationMeta.value;
                final totalCount =
                    meta?.total ?? controller.attendanceHistory.length;

                return AttendanceHistoryHeader(
                  controller: controller,
                  totalCount: totalCount,
                );
              }),
              16.verticalSpace(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return AttendanceList(
                    items: controller.attendanceHistory,
                    onRefresh: controller.refreshHistory,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
