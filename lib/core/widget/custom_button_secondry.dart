import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

class CustomButtonSecondry extends StatelessWidget {
  const CustomButtonSecondry({super.key, required this.text, this.onTap});
final String text;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.03.w(context), horizontal: 0.05.w(context)),
        decoration: BoxDecoration(
          color: AppColor.secondryColor,
          borderRadius: BorderRadius.circular(50)
        ),
        child: Text(text,style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w500),),
      ),
    );
  }
}
