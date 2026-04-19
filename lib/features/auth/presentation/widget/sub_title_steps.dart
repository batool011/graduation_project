import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_color.dart';

class SubTitleSteps extends StatelessWidget {
  const SubTitleSteps({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
