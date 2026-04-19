import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/material.dart';

import '../constant/class/app_size.dart';

class CustomDatePickerField extends StatelessWidget {
  final String hintText;
  final String value;
  final TextEditingController? controller;
  final VoidCallback onTap;
  final Widget? prefixIcon;

  const CustomDatePickerField({
    super.key,
    required this.hintText,
    this.value = '',
    this.controller,
    required this.onTap,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = controller?.text.isNotEmpty == true ? controller!.text : value;

    if (controller != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
        child: TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          style: TextStyle(fontSize: 14, color: AppColor.black),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.darkGrey),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColor.darkGrey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColor.primaryColor, width: 1.0),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 0.05.w(context),
              vertical: 0.018.h(context),
            ),
            filled: true,
            fillColor: AppColor.lightGrey,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
      child: Material(
        color: AppColor.lightGrey,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 0.04.w(context),
              vertical: 0.018.h(context),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: value.isEmpty ? Colors.transparent : AppColor.primaryColor.withOpacity(0.25),
              ),
            ),
            child: Row(
              children: [
                prefixIcon ?? const Icon(Icons.calendar_today_outlined, color: AppColor.primaryColor, size: 20),
                SizedBox(width: 0.03.w(context)),
                Expanded(
                  child: Text(
                      displayValue.isEmpty ? hintText : displayValue,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: displayValue.isEmpty ? AppColor.darkGrey : AppColor.black,
                          fontSize: 14,
                        ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.darkGrey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<DateTime?> showAppDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  final theme = Theme.of(context);

  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    builder: (context, child) {
      return Theme(
        data: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: AppColor.primaryColor,
            onPrimary: Colors.white,
            surface: AppColor.white,
            onSurface: AppColor.black,
          ),
          dialogTheme: const DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          ),
        ),
        child: child ?? const SizedBox.shrink(),
      );
    },
  );
}