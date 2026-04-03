import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/savings_controller.dart';
import '../widgets/savings_card_item.dart';
import '../widgets/savings_type_tabs.dart';

class SavingsCardsScreen extends StatelessWidget {
  final controller = Get.find<SavingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
   
        leading:  CircleAvatar(backgroundColor:Colors.white,),
        title: Text(AppString.availableSavingsCards.tr,
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.transparent,
  elevation: 0,
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColor.lightPrimaryColor,
             AppColor.lightPrimaryColor,
          Colors.white70,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.8, 1.0], 
      ),
    ),
  ),
  iconTheme: IconThemeData(color: Colors.black),
       
        
      ),

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
