import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/complaints/presentation/getx/controller/complaints_controller.dart';
import 'package:career/features/complaints/presentation/widget/complaint_card.dart';
import 'package:career/features/complaints/presentation/widget/complaints_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintsBody extends GetView<ComplaintsController> {
  const ComplaintsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: controller.loadComplaints,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(0.02.h(context)),
          children: [
            ComplaintsSummary(
              total: controller.totalCount,
              pending: controller.pendingCount,
              resolved: controller.resolvedCount,
            ),
            14.verticalSpace(),
            if (controller.complaints.isEmpty)
              const ComplaintsEmptyState()
            else
              ...controller.complaints.map((item) => ComplaintCard(complaint: item)),
          ],
        ),
      );
    });
  }
}