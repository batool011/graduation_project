import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/features/saving_money/data/models/saving_card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:test/features/saving_money/data/models/saving_card_model.dart';


class SavingsCardItem extends StatelessWidget {
  final SavingCardModel card;

  const SavingsCardItem({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: _getGradient(card.type),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // النصوص
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            card.monthlyAmount,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    ),

    SizedBox(width: 12),

    // الصورة
    SizedBox(
      width: 150,   
      height: 75,
      child: Image.asset(
        card.imagePath,
        fit: BoxFit.contain,
      ),
    ),
  ],
),

          SizedBox(height: 16),
          SizedBox(
            width: 100,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
         
  Get.toNamed('/savingCardsDetails', arguments: card);


              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(AppString.subscribeNow.tr, style: TextStyle(color: Colors.white,fontSize:18)),
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient _getGradient(String type) {
    switch (type) {
      case "white":
        return LinearGradient(colors: [Colors.white, Colors.white70]);
      case "silver":
        return LinearGradient(colors: [Color(0xFFD9D9D9), Color(0xFFF2F2F2)]);
      case "bronze":
        return LinearGradient(colors: [Color.fromARGB(255, 225, 179, 134), Color.fromARGB(255, 231, 186, 138)]);
      case "gold":
        return LinearGradient(colors: [Color.fromARGB(255, 245, 226, 118), Color.fromARGB(255, 240, 222, 122)]);
      default:
        return LinearGradient(colors: [Colors.white, Colors.white]);
    }
  }
}