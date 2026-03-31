import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/widget/custom_white_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 0.05.w(context)),
        child: Row(
          children: [
            Text("Amer Abo Saeed",style: Theme.of(context).textTheme.bodySmall,),
            Spacer(),

            GestureDetector(onTap:(){Get.toNamed(RoutesName.notification);},child: CustomWhiteContainer(icon: AppAsset.notification,withRadius: true,)),
            //CustomWhiteContainer(icon: AppAsset.setting,withRadius: true,onTap: (){Get.toNamed(RoutesName.setting);},)


          ],
        ),
      ),
    );
  }
}
