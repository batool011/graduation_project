import 'package:career/core/constant/class/app_color.dart';
import 'package:career/features/detail-job/presentation/widget/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/controller/detail_job_controller.dart';
import '../widget/about_company_widget.dart';
import '../widget/about_position_widget.dart';
import '../widget/custom_app_bar_detail_job.dart';

class DetailJobScreen extends GetView<DetailJoController> {
  const DetailJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
        appBar: PreferredSize(preferredSize: Size(double.infinity,310), child: CustomAppBarDetailJob(),),
      body: Obx(() {
      if (controller.selectedTab.value == 0) {
        return AboutPositionWidget();
      } else {
        return AboutCompanyWidget();
      }
    }),
      bottomNavigationBar: CustomNavBar()
    );
  }
}
