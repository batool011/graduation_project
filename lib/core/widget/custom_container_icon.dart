import 'dart:core';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

class CustomContainerIcon extends StatelessWidget {
  final String title;
  final  String value;
  final IconData icon;
  final Color color;
  const CustomContainerIcon({super.key, required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {

      return Row(
        children: [
          Container(
            height: 0.04.h(context),
            width: 0.1.w(context),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          10.horizontalSpace(),
          Text(title, style:Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColor.black)),
          Spacer(),
          Text(value, style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColor.black)),
        ],
      );
    }

  }



