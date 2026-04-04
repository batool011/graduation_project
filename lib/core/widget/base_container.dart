import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({super.key, required this.title, required this.body});
final String title;
final String body;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.04.w(context),vertical: 0.02.h(context)),
      margin: EdgeInsets.symmetric(horizontal: 0.04.w(context),vertical: 0.003.h(context)),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(23)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16,fontWeight: FontWeight.w500)),
          Text(body,
              maxLines: 4,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.blackLight))
        ],
      ),
    );
  }
}
