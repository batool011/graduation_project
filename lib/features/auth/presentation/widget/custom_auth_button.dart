import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/router/routes_name.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({super.key, required this.text, required this.icons});
   final String text;
   final String icons;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Get.toNamed(RoutesName.createNewAccount);},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.05.w(context), horizontal: 0.15.w(context)),
        margin: EdgeInsets.symmetric(vertical: 0.01.h(context)),
        decoration:
        BoxDecoration(color: AppColor.secondryColor,
          borderRadius: BorderRadius.circular(50),),
        child: Row(
          children: [
            SvgPicture.asset(icons),
            16.horizontalSpace(),
            Text(text,style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.bold),),
          ],
        ),),
    );
  }
}
// 0.05.w(context)