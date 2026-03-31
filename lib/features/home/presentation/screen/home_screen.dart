import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/home/presentation/widget/custom_button_sign.dart';
import 'package:career/features/home/presentation/widget/custom_card_home.dart';
import 'package:career/features/home/presentation/widget/statics.dart';
import 'package:career/features/home/presentation/widget/yourBalance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/controller/home_controller.dart';
import '../widget/custom_home_app_bar.dart';
import '../widget/custom_slider.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: Column(
        children: [

          25.verticalSpace(),
          CustomHomeAppBar(),
          CustomSlider(),
          10.verticalSpace(),
          
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                CustomButtonSign(),
                15.verticalSpace(),
                Yourbalance(),
                10.verticalSpace(),
                Statics(),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.06.w(context),
                    vertical: 0.02.h(context),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Divider(indent: 10, endIndent: 10)),
                      Text(
                        "الاشعارات",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  padding:  EdgeInsets.all(0.02.h(context)),
                  childAspectRatio: 0.9,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: const [
                    CustomCardHome(
                      icon: Icons.beach_access,
                      title: 'الإجازات',
                      subtitle: 'عرض التفاصيل',
                    ),
                    CustomCardHome(
                      icon: Icons.checklist,
                      title: 'المهام',
                      subtitle: 'عرض التفاصيل',
                    ),
                    CustomCardHome(
                      icon: Icons.calendar_today,
                      title: 'جدول حضوري',
                      subtitle: 'عرض التفاصيل',
                    ),
                    CustomCardHome(
                      icon: Icons.savings_outlined,
                      title: 'الادخار',
                      subtitle: 'عرض التفاصيل',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
