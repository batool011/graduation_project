import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/under_line_text.dart';

class AdditionSection extends StatelessWidget {
  const AdditionSection({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 0.05.w(context)),
      child: Row(
        children: [
          Icon(Icons.add,color:AppColor.lightCyan,size: 13,),
          GestureDetector(
            onTap: onTap,
              child: UnderLineText(text:text)),
          12.verticalSpace(),
          Expanded(child: Divider(color: AppColor.lightCyan,thickness: 0.2,endIndent: 0.05.w(context),indent: 5,))
        ],
      ),
    );
  }
}
