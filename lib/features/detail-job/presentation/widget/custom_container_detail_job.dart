import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

class CustomContainerDetailJob extends StatelessWidget {
  const CustomContainerDetailJob({super.key, required this.text, required this.isActive});
   final String text;
   final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.02.w(context)),
      padding: EdgeInsets.symmetric(horizontal: 0.07.w(context),vertical: 0.017.h(context)),
      decoration: BoxDecoration(
          color: isActive ? AppColor.primaryColor : AppColor.primaryColor.withAlpha(40),
        borderRadius: BorderRadius.circular(30)
      ),child: Center(
        child: Text(text,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w600,color: isActive ? AppColor.white : AppColor.primaryColor.withAlpha(50)),),
      ),
    );
  }
}
