import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/widget/custom_card.dart';
import 'package:career/features/detail-job/presentation/widget/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutCompanyWidget extends StatelessWidget {
  const AboutCompanyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all( 0.02.h(context)),
          margin: EdgeInsets.symmetric(horizontal: 0.02.h(context)),
          decoration: BoxDecoration(color: AppColor.white,
          borderRadius: BorderRadius.circular(16)),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Location",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500,fontSize: 18),),
                11.verticalSpace(),
                Row(children: [  SvgPicture.asset(AppAsset.locationHome,height: 12,),7.horizontalSpace() ,Text("Building 12, Name street, Region, City",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.blackLight,fontSize: 13),),
                ],),
                6.verticalSpace(),
                Container(
                  width: double.infinity,
                  height: .18.h(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: const MapWidget(),
                  ),
                ),
              ],
            )
        ),
        Text("Location",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500,fontSize: 18),),
        CustomCard()
      ],
    );
  }
}
