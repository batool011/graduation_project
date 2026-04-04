import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../constant/class/app_string.dart';

class CustomTextFieldSearch extends StatelessWidget {
  final TextEditingController? controller;
  const CustomTextFieldSearch({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 0.05.w(context)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
         prefixIcon: SvgPicture.asset(AppAsset.search,fit: BoxFit.scaleDown,),
          hintText: AppString.search.tr,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(color: AppColor.primaryColor.withAlpha(50)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: AppColor.primaryColor,
              width: 1.0,
            ),
          ),
          contentPadding:EdgeInsets.symmetric(
            horizontal:  0.05.w(context),
            vertical:  0.02.h(context),
          ),
          filled: true,
          fillColor: AppColor.white,
        ),
      ),
    );
  }
}
