import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_asset.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_button_secondry.dart';
import '../../../../core/widget/under_line_text.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
      height: 70,
      decoration: BoxDecoration(
          color: AppColor.primaryColor
      ),
      child: Row(
        children: [
          CustomButtonSecondry(text: AppString.applyNow.tr,),
          Spacer(),
          SvgPicture.asset(AppAsset.advCyan),
          4.horizontalSpace(),
          UnderLineText(text: AppString.saveAsABookmark.tr)
        ],
      ),
    ) ;
  }
}
