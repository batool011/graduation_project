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
      margin: EdgeInsets.symmetric(horizontal: 0.06.w(context)),
      padding: EdgeInsets.symmetric(
        vertical: 0.02.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 0.03.w(context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(width: 80,height: 80,imageUrl: AppAsset.splash,borderRadius: BorderRadius.circular(20),),
            13.horizontalSpace(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  8.verticalSpace(),
                  Text(
                    notification.body.isEmpty ? 'لا يوجد محتوى إضافي' : notification.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            10.horizontalSpace(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.delete_outline, color: AppColor.errorColor, size: 22),
                  ),
                ),
                34.verticalSpace(),
                Text(
                  _formatDate(notification.createdAt),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: AppColor.darkGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
