import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/features/notification/presentation/getx/controller/notification_controller.dart';
import 'package:career/features/notification/presentation/widget/custom_notification_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../core/widget/under_line_text.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: AppString.notifications.tr,)),
      backgroundColor: AppColor.scaffoldColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            8.verticalSpace(),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 0.05.w(context),vertical: 0.005.h(context)),
              child: Row(
                children: [
                  Text('${controller.notifications.length} items'),
                  const Spacer(),
                  if (controller.notifications.isNotEmpty)
                    GestureDetector(
                      onTap: controller.deleteAllNotifications,
                      child: Row(
                        children: [
                          const Icon(Icons.delete_outline,color: AppColor.errorColor,size: 20,),
                          4.horizontalSpace(),
                          UnderLineText(text: AppString.deleteAll.tr),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            16.verticalSpace(),
            Expanded(
              child: controller.notifications.isEmpty
                  ? ListView(
                      children: [
                        Lottie.asset(AppAsset.bell,height: 200),
                      ],
                    )
                  : ListView.separated(
                      padding: EdgeInsets.only(bottom: 24.h(context)),
                      itemCount: controller.notifications.length,
                      separatorBuilder: (_, __) => 10.verticalSpace(),
                      itemBuilder: (context, index) {
                        final notification = controller.notifications[index];
                        return CustomNotificationContainer(
                          notification: notification,
                          onDelete: () => controller.deleteNotification(notification.id),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}
