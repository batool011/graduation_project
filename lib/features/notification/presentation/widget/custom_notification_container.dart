import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/features/notification/data/model/app_notification.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_size.dart';
import '../../../../core/widget/image_widget.dart';

class CustomNotificationContainer extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onDelete;

  const CustomNotificationContainer({
    super.key,
    required this.notification,
    required this.onDelete,
  });

  String _formatDate(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();
    return '$day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.06.w(context), vertical: 0.01.h(context)),
      padding: EdgeInsets.all(0.025.w(context)),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColor.grey.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ صورة الإشعار
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ImageWidget(
              width: 70,
              height: 70,
              imageUrl: AppAsset.splash,
              fit: BoxFit.cover,
            ),
          ),
          14.horizontalSpace(),
          // ✅ محتوى الإشعار
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColor.black,
                        height: 1.2,
                      ),
                ),
                6.verticalSpace(),
                Text(
                  notification.body.isEmpty ? 'لا يوجد محتوى إضافي' : notification.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13,
                        color: AppColor.darkGrey,
                        height: 1.4,
                      ),
                ),
                10.verticalSpace(),
                // ✅ التاريخ
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: AppColor.darkGrey.withValues(alpha: 0.6),
                    ),
                    6.horizontalSpace(),
                    Text(
                      _formatDate(notification.createdAt),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColor.darkGrey.withValues(alpha: 0.7),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ✅ زر الحذف
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColor.errorColor.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: AppColor.errorColor,
                    size: 18,
                  ),
                ),
              ),
              8.verticalSpace(),
              // ✅ حالة الإشعار (مقروء/غير مقروء)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: notification.isRead == true
                      ? AppColor.grey.withValues(alpha: 0.3)
                      : AppColor.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}