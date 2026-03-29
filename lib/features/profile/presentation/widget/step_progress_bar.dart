import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int steps;

  const StepProgressBar({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {

    final int bars = steps - 1;

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 0.05.w(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          21.verticalSpace(),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               "Your Cv is completed",
               style: Theme.of(context)
                   .textTheme
                   .bodyMedium!
                   .copyWith(fontWeight: FontWeight.w900,fontSize: 16),
             ),
             Text(
             "${100}%",
             style: Theme.of(context)
                 .textTheme
                 .bodySmall!
                 .copyWith(color: AppColor.primaryColor),
           ),],
         ),
          15.verticalSpace(),
          Row(
            children: List.generate(bars, (index) {
              return Expanded(
                child: Container(
                  height: 5,
                  margin: EdgeInsets.only(right: index == bars - 1 ? 0 : 6),
                  decoration: BoxDecoration(
                    color:  AppColor.lightCyan,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}