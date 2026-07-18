import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:career/features/vacation/presentation/widget/vacation_request_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';

class VacationScreen extends GetView<VacationController> {
  const VacationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.leaveRequest.tr),
      ),
      body: VacationRequestForm(controller: controller),
    );
  }
}
