import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/features/overtime_requests/presentation/getx/controller/overtime_controller.dart';
import 'package:career/features/overtime_requests/presentation/widget/overtime_hero.dart';
import 'package:career/features/overtime_requests/presentation/widget/overtime_request_dialog.dart';
import 'package:career/features/overtime_requests/presentation/widget/overtime_request_item_card.dart';
import 'package:career/features/overtime_requests/presentation/widget/overtime_requests_header.dart';
import 'package:career/features/overtime_requests/presentation/widget/overtime_state_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OvertimeScreen extends GetView<OvertimeController> {
  const OvertimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.overtimeRequests.tr),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openRequestDialog(context),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: const Icon(Icons.add_task_rounded),
        label: Text(AppString.requestOvertime.tr),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColor.primaryColor,
          onRefresh: controller.refreshRequests,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final total =
                      controller.paginationMeta.value?.total ??
                          controller.requests.length;

                  return OvertimeHero(
                    totalCount: total,
                    perPage: controller.perPage.value,
                  );
                }),
                const SizedBox(height: 22),
                Obx(() {
                  final total =
                      controller.paginationMeta.value?.total ??
                          controller.requests.length;

                  return OvertimeRequestsHeader(total: total);
                }),
                const SizedBox(height: 14),
                Obx(() {
                  if (controller.isLoading.value &&
                      controller.requests.isEmpty) {
                    return const OvertimeLoadingCard();
                  }

                  if (controller.requests.isEmpty) {
                    return OvertimeEmptyState(
                      onRefresh: controller.refreshRequests,
                    );
                  }

                  return Column(
                    children: controller.requests
                        .map(
                          (request) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: OvertimeRequestItemCard(request: request),
                          ),
                        )
                        .toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openRequestDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => OvertimeRequestDialog(controller: controller),
    );
  }
}
