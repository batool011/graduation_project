import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/detail-job/presentation/widget/custom_container_detail_job.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_string.dart';
import '../getx/controller/detail_job_controller.dart';
import 'first_company_container.dart';
import 'first_position_container.dart';

class CustomAppBarDetailJob extends GetView<DetailJoController> {
  const CustomAppBarDetailJob({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(
       children: [
         Padding(
           padding:EdgeInsets.symmetric(horizontal: 0.05.w(context)),
           child: Row(
             children: [
               Icon(Icons.arrow_back,color: AppColor.primaryColor.withAlpha(60),),
               20.horizontalSpace(),
               Expanded(
                 child: Text("UI UX Designer",
                   maxLines: 2,
                   style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColor.black,fontWeight: FontWeight.w900,fontSize: 28),),
               ),
               Image.asset(AppAsset.neuw)
             ],
           ),
         ),
        Obx((){
          return  Row(
            children: [
              Expanded(child: GestureDetector(onTap:(){controller.changeTab(0);},child: CustomContainerDetailJob(text: AppString.aboutPosition.tr, isActive: controller.selectedTab.value==0,))),
              Expanded(child: GestureDetector(onTap:(){controller.changeTab(1);},child: CustomContainerDetailJob(text: AppString.aboutCompany.tr, isActive: controller.selectedTab.value==1,)))

            ],);
        }),
         21.verticalSpace(),
         Obx((){
           return controller.selectedTab.value==0? FirstPositionContainer():FirstCompanyContainer();

         })
       ],
    );
  }
}
