import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_color.dart';

class CustomTextFieldVacation extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final VoidCallback? onSuffixTap;
  final TextInputType ? textInputType;
  final bool readOnly;
  final void Function()?onTap;
  final Widget? child;
  const CustomTextFieldVacation({
    super.key,
    this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.onSuffixTap,
    this.textInputType,
    this.readOnly=false, this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 0.05.w(context)),
      child: child ?? TextFormField(
        keyboardType: textInputType,
        onTap: onTap,
        readOnly: readOnly,
        style: TextStyle(fontSize: 14, color: AppColor.black),
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefix,
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
          contentPadding: EdgeInsets.symmetric(
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
