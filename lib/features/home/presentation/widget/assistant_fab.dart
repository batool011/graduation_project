import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssistantFab extends StatelessWidget {
  const AssistantFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Get.toNamed(RoutesName.chatbot),
      backgroundColor: AppColor.primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
      icon: const Icon(Icons.smart_toy_rounded),
      label: Text(
        AppString.assistant.tr,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
