import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:career/features/vacation/presentation/widget/vacation_requests_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VacationRequestsScreen extends StatefulWidget {
  const VacationRequestsScreen({super.key});

  @override
  State<VacationRequestsScreen> createState() => _VacationRequestsScreenState();
}

class _VacationRequestsScreenState extends State<VacationRequestsScreen> {
  final VacationController controller = Get.find<VacationController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchVacationRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: CustomAppBar(text: 'طلبات الإجازة'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.04.w(context),
            vertical: 0.02.h(context),
          ),
          child: Obx(() {
            if (controller.isVacationListLoading.value && controller.vacationRequests.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: controller.fetchVacationRequests,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  VacationRequestsSection(controller: controller),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}