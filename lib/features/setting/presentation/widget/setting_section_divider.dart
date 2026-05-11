import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

class SettingSectionDivider extends StatelessWidget {
  const SettingSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColor.secondryColor,
      endIndent: 0.04.w(context),
      indent: 0.04.w(context),
      thickness: 0.7,
    );
  }
}