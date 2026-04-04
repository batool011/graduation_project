import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/constant/class/app_color.dart';
import '../getx/controller/home_controller.dart';

class CustomSlider extends GetView<HomeController> {
  const CustomSlider({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: [
            Container(
              padding: EdgeInsets.only(
                  top: 0.02.h(context), bottom: 0.02.h(context)),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 0.20.h(context),
                    padding: EdgeInsets.symmetric(
                      vertical: 0.01.h(context),
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        191.horizontalSpace(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Start Your",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                "Career NOW!",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              5.verticalSpace(),
                              Text(
                                "Lorem ipsum is place holder text commonly used",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColor.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    top: -10,
                    start: 0,
                    child: Image.asset(AppAsset.slider),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 0.02.h(context), bottom: 0.02.h(context)),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 0.20.h(context),
                    padding: EdgeInsets.symmetric(
                      vertical: 0.01.h(context),
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        191.horizontalSpace(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Start Your",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                "Career NOW!",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              5.verticalSpace(),
                              Text(
                                "Lorem ipsum is place holder text commonly used",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColor.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    top: -10,
                    start: 0,
                    child: Image.asset(AppAsset.slider),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 0.02.h(context), bottom: 0.02.h(context)),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 0.20.h(context),
                    padding: EdgeInsets.symmetric(
                      vertical: 0.01.h(context),
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        191.horizontalSpace(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Start Your",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                "Career NOW!",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              5.verticalSpace(),
                              Text(
                                "Lorem ipsum is place holder text commonly used",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColor.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    top: -10,
                    start: 0,
                    child: Image.asset(AppAsset.slider),
                  ),
                ],
              ),
            ),

          ],
          options: CarouselOptions(
            height: 0.21.h(context),
            viewportFraction: 0.85,
            enlargeCenterPage: true,
            autoPlay: true,
            onPageChanged: (index, reason) {
              controller.changeIndex(index);
            },
          ),
        ),

        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
                  (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: 6,
                width: controller.currentIndex.value == index ? 20 : 5,
                decoration: BoxDecoration(
                  color: controller.currentIndex.value == index
                      ? AppColor.primaryColor
                      : AppColor.darkGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        }),
        13.verticalSpace(),
      ],
    );
  }
}
