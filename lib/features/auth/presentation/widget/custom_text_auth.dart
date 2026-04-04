import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

class CustomTextAuth extends StatelessWidget {
  const CustomTextAuth({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
     // padding: EdgeInsets.symmetric(vertical: 0.03.h(context),horizontal: 0.08.w(context) ),
      padding: EdgeInsetsDirectional.only(start: 0.08.w(context),top: 0.03.h(context),bottom: 0.03.h(context) ),
      child: Text(text,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.primaryColor.withAlpha(40)),),
    );
  }
}
