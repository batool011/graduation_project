import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/core/widget/custom_button_primary.dart';
import 'package:career/features/saving_money/data/models/saving_card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingsCardDetailsScreen extends StatelessWidget {
  final SavingCardModel card;

  const SavingsCardDetailsScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: "${AppString.details.tr}${card.name}",)),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

        
            Image.asset(
              card.imagePath,
              height: 180,
            ),

            SizedBox(height: 12),

            Text(
              card.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Container(
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
                  _infoRow(AppString.monthlyAmount.tr, card.monthlyAmount, Icons.sd_card_alert, Colors.red),
                  SizedBox(height: 12),
                  _infoRow(AppString.numberOfSubscribers.tr, "35 مشترك", Icons.people, Colors.blue),
                  SizedBox(height: 12),
                  _infoRow(AppString.courseDuration, "24 شهر أو 48 شهر", Icons.calendar_month, Colors.green),
                  SizedBox(height: 12),
                  _infoRow(AppString.totalSavings.tr, "960,000 ر.س", Icons.money, Colors.brown),
                ],
              ),
            ),

            SizedBox(height: 20),
CustomButtonPrimary(text: AppString.subscribeToThisCard.tr,onTap: () {
                  Get.toNamed('/subscriptionPlans',arguments: card);

},)
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        SizedBox(width: 8),
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Spacer(),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
