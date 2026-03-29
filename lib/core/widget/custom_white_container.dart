import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CustomWhiteContainer extends StatelessWidget {
  const CustomWhiteContainer({super.key, required this.icon, this.withRadius=false, this.onTap});
final String icon;
final bool withRadius;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(0.016.h(context)),
        margin:withRadius? EdgeInsetsDirectional.only(end : 0.02.w(context)):  EdgeInsetsDirectional.only(end : 0.04.w(context)),
        decoration: BoxDecoration(
          color: AppColor.secondryColor,
          borderRadius: withRadius? BorderRadius.circular(50): BorderRadius.circular(20),
        ),
       child: SvgPicture.asset(icon),
      ),
    );
  }
}
