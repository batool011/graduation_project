import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:career/features/saving_money/data/models/saving_card_model.dart';
import 'package:career/core/constant/class/app_string.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  final SavingCardModel card;

  const SubscriptionPlansScreen({required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("خطط الإشتراك", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),

          // اسم البطاقة
          Text(
            card.name,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20),

        
            Image.asset(
              card.imagePath,
              height: 180,
            ),

            SizedBox(height: 12),


          // الخطة 1
          _planCard(
            title: "الخطة 1",
            duration: "سنتان (24 شهر)",
            monthly: card.monthlyAmount,
            total: "480,000 رس",
          ),

          SizedBox(height: 16),

          // الخطة 2
          _planCard(
            title: "الخطة 2",
            duration: "أربع سنوات (48 شهر)",
            monthly: card.monthlyAmount,
            total: "960,000 رس",
          ),

          SizedBox(height: 30),

          // زر تأكيد الاشتراك
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "تأكيد الإشتراك",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),

    
    );
  }

  Widget _planCard({
    required String title,
    required String duration,
    required String monthly,
    required String total,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(duration, style: TextStyle(fontSize: 16)),
          SizedBox(height: 6),
          Text("الإشتراك: $monthly", style: TextStyle(fontSize: 16)),
          SizedBox(height: 6),
          Text("إجمالي الإدخار: $total",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
