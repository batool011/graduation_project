import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/home/presentation/widget/assistant_fab.dart';
import 'package:career/features/home/presentation/widget/custom_button_sign.dart';
import 'package:career/features/home/presentation/widget/home_features_section.dart';
import 'package:career/features/home/presentation/widget/statics.dart';
import 'package:career/features/home/presentation/widget/your_balance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/controller/home_controller.dart';
import '../widget/custom_home_app_bar.dart';
import '../widget/custom_slider.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      floatingActionButton: const AssistantFab(),
      body: Column(
        children: [
          25.verticalSpace(),
          Obx(() => CustomHomeAppBar(name: controller.userDisplayName.value)),
          const CustomSlider(),
          10.verticalSpace(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const CustomButtonSign(),
                15.verticalSpace(),
                const YourBalance(balance: '2000'),
                10.verticalSpace(),
                const Statics(sale: '20', point: '100'),
                10.verticalSpace(),
                const HomeFeaturesSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
