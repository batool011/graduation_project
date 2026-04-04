import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

class CustomDeleteIcon extends StatelessWidget {
  const CustomDeleteIcon({super.key, this.onTap});
 final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(0.002.w(context)),
        margin: EdgeInsets.all(0.03.w(context)),
        decoration: BoxDecoration(
          color: AppColor.secondryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(Icons.close,size: 12,color: AppColor.white,),
      ),
    );
  }
}
