import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/notification/data/model/app_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_size.dart';

class CustomNotificationContainer extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onDelete;

  const CustomNotificationContainer({
    super.key,
    required this.notification,
    required this.onDelete,
  });

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (date == today) {
      return AppString.today.tr;
    } else if (date == yesterday) {
      return AppString.yesterday.tr;
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUnread = !notification.isRead;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 0.05.w(context),
        vertical: 0.01.h(context),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 0.03.w(context),
        vertical: 0.018.h(context),
      ),
      decoration: BoxDecoration(
        color: isUnread
            ? AppColor.primaryColor.withValues(alpha: 0.03)
            : AppColor.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: -12,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: isUnread
              ? AppColor.primaryColor.withValues(alpha: 0.10)
              : AppColor.grey.withValues(alpha: 0.14),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isUnread
                    ? [
                  AppColor.primaryColor.withValues(alpha: 0.22),
                  AppColor.primaryColor.withValues(alpha: 0.08),
                ]
                    : [
                  AppColor.grey.withValues(alpha: 0.18),
                  AppColor.grey.withValues(alpha: 0.07),
                ],
              ),
              border: Border.all(
                color: isUnread
                    ? AppColor.primaryColor.withValues(alpha: 0.14)
                    : AppColor.grey.withValues(alpha: 0.12),
              ),
            ),
            child: Icon(
              isUnread
                  ? Icons.notifications_active_rounded
                  : Icons.notifications_none_rounded,
              size: 27,
              color: isUnread ? AppColor.primaryColor : AppColor.darkGrey,
            ),
          ),
          14.horizontalSpace(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColor.black,
                          height: 1.2,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color:
                            AppColor.primaryColor.withValues(alpha: 0.16),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          AppString.newNotification.tr,
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                  ],
                ),
                6.verticalSpace(),
                Text(
                  notification.body.isEmpty
                      ? AppString.noAdditionalContent.tr
                      : notification.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 13,
                    color: AppColor.darkGrey.withValues(alpha: 0.85),
                    height: 1.45,
                  ),
                ),
                10.verticalSpace(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.grey.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 12,
                        color: AppColor.darkGrey.withValues(alpha: 0.55),
                      ),
                      4.horizontalSpace(),
                      Text(
                        _formatDate(notification.createdAt),
                        style:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColor.darkGrey
                              .withValues(alpha: 0.72),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          10.horizontalSpace(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColor.errorColor.withValues(alpha: 0.09),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.errorColor.withValues(alpha: 0.14),
                      width: 0.8,
                    ),
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColor.errorColor,
                    size: 18,
                  ),
                ),
              ),
              10.verticalSpace(),
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: isUnread
                      ? AppColor.primaryColor
                      : AppColor.grey.withValues(alpha: 0.35),
                  shape: BoxShape.circle,
                  boxShadow: isUnread
                      ? [
                    BoxShadow(
                      color:
                      AppColor.primaryColor.withValues(alpha: 0.30),
                      blurRadius: 8,
                    ),
                  ]
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}