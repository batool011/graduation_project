import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../data/source/faq_items_data.dart';
import '../widget/faq_tile.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.helpCenter.tr),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqItemsData.length,
        itemBuilder: (context, index) {
          final item = faqItemsData[index];
          return FaqTile(
            questionKey: item.questionKey,
            answerKey: item.answerKey,
          );
        },
      ),
    );
  }
}
