import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool? obscureText;
  final VoidCallback? onSuffixTap;
  final TextInputType ? textInputType;
  final bool isComment ;
  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.obscureText = false,
    this.onSuffixTap,
    this.textInputType,
    this.isComment =false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.symmetric( horizontal: 0.05.w(context)),
      child: TextFormField(
        maxLines: isComment?5:1,

        keyboardType: textInputType,
        style: const TextStyle(fontSize: 14, color: AppColor.black),
        controller: controller,
        obscureText: obscureText!,
        decoration: InputDecoration(
          prefixIcon: isComment?Padding(
            padding:  EdgeInsets.only(bottom: 0.07.h(context)),
            child: prefix,
          ):prefix,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(color: AppColor.darkGrey),
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
          contentPadding: isComment? EdgeInsets.symmetric(
            horizontal:  0.05.w(context),
            vertical:  0.02.h(context),
          ):EdgeInsets.symmetric(
            horizontal:  0.05.w(context),
            vertical:  0.02.h(context),
          ),
          filled: true,
          fillColor: AppColor.lightGrey,
        ),
      ),
    );
  }
}
