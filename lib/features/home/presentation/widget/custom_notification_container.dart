import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_size.dart';

class CustomNotificationContainer extends StatelessWidget {
  const CustomNotificationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.06.w(context)),
      padding: EdgeInsets.symmetric(
        vertical: 0.02.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColor.secondryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 0.03.w(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            Text(
              "رصيدك الحالي",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "3000",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(

                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
