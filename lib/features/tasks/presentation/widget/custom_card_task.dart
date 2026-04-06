import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_container_icon.dart';
import 'package:career/features/tasks/presentation/getx/controller/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String assignedBy;
  final String startDate;
  final String endDate;

  const CustomTaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.assignedBy,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TasksController(), tag: title);

    return Obx(() {
      return Container(
        margin: EdgeInsets.all(0.01.h(context)),
        padding: EdgeInsets.all(0.03.h(context)),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColor.darkGrey,
              blurRadius: 8,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title,  style:Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColor.black,fontWeight: FontWeight.bold)),
         8.verticalSpace(),

            Text(description,  style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColor.blackLight)),
            12.verticalSpace(),
            Column(
              children: [
               CustomContainerIcon(title: AppString.assignedBy.tr, value: 'value', icon: Icons.person, color: AppColor.primaryColor),
                10.verticalSpace(),
                CustomContainerIcon(title: AppString.startDate.tr, value: 'value', icon: Icons.calendar_month_sharp, color: AppColor.primaryColor),
                10.verticalSpace(),
                CustomContainerIcon(title: AppString.endDate.tr, value: 'value', icon: Icons.calendar_month_sharp, color: AppColor.primaryColor)

              ],
            ),
             20.verticalSpace(),
            Row(
              children: [
                _circle(0, controller.status.value, title),
                _line(controller.status.value >= 1),

                _circle(1, controller.status.value, title),
                _line(controller.status.value == 2),

                _circle(2, controller.status.value, title),
              ],
            ),

           16.verticalSpace(),

            Text(
              _statusText(controller.status.value),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _statusColor(controller.status.value),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _circle(int index, int current, String tag) {
    bool active = index <= current;

    return GestureDetector(
      onTap: () => Get.find<TasksController>(tag: tag).setStatus(index),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: active ? AppColor.primaryColor : AppColor.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _line(bool active) {
    return Expanded(
      child: Container(
        height: 7,
        color: active ? AppColor.primaryColor : AppColor.grey,
      ),
    );
  }

  String _statusText(int status) {
    switch (status) {
      case 0:
        return "لم تبدأ";
      case 1:
        return "قيد التقدم";
      default :
        return "مكتملة";
    }
  }

  Color _statusColor(int status) {
    switch (status) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.orange;
      default:
        return Colors.green;
    }
  }
}
