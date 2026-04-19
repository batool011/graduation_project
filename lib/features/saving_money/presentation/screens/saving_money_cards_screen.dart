import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/savings_controller.dart';
import '../widgets/savings_card_item.dart';

class SavingsCardsScreen extends StatelessWidget {
  final controller = Get.find<SavingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: AppString.availableSavingsCards.tr,)),

      body: Column(
        children: [
          SizedBox(height: 10),
          // SavingsTypeTabs(),
          SizedBox(height: 10),

          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.filteredCards.length,
              itemBuilder: (context, index) {
                return SavingsCardItem(card: controller.filteredCards[index]);
              },
            )),
          ),
        ],
      ),

     
    );
  }
}
