import 'package:career/core/constant/class/app_color.dart';
import 'package:career/features/complaints/presentation/getx/controller/complaints_controller.dart';
import 'package:career/features/complaints/presentation/widget/complaint_card.dart';
import 'package:career/features/complaints/presentation/widget/complaints_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintsBody extends GetView<ComplaintsController> {
  const ComplaintsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F9FC),
      child: Obx(() {
        final isLoading = controller.isLoading.value;
        final complaints = controller.complaints;

        if (isLoading && complaints.isEmpty) {
          return const _LoadingState();
        }

        return RefreshIndicator(
          onRefresh: controller.loadComplaints,
          color: AppColor.primaryColor,
          backgroundColor: Colors.white,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              ComplaintsSummary(
                total: controller.totalCount,
                pending: controller.pendingCount,
                resolved: controller.resolvedCount,
              ),
              const SizedBox(height: 16),
              if (complaints.isEmpty)
                const ComplaintsEmptyState()
              else
                ...complaints.map(
                      (item) => ComplaintCard(complaint: item),
                ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 78,
        height: 78,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.grey.withOpacity(0.14),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 18,
              offset: const Offset(0, 10),
              spreadRadius: -10,
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(18),
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }
}