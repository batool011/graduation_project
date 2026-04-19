import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  final List<Map<String, String>> faqData = const [
    {
      "questionKey": "faqQuestion1",
      "answerKey": "faqAnswer1",
    },
    {
      "questionKey": "faqQuestion2",
      "answerKey": "faqAnswer2",
    },
    {
      "questionKey": "faqQuestion3",
      "answerKey": "faqAnswer3",
    },
    {
      "questionKey": "faqQuestion4",
      "answerKey": "faqAnswer4",
    },
    {
      "questionKey": "faqQuestion5",
      "answerKey": "faqAnswer5",
    },
    {
      "questionKey": "faqQuestion6",
      "answerKey": "faqAnswer6",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: AppString.helpCenter.tr,)),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: faqData.length,
        itemBuilder: (context, index) {
          final item = faqData[index];
          return FAQTile(
            questionKey: item['questionKey']!,
            answerKey: item['answerKey']!,
          );
        },
      ),
    );
  }
}

class FAQTile extends StatefulWidget {
  final String questionKey;
  final String answerKey;

  const FAQTile({super.key, required this.questionKey, required this.answerKey});

  @override
  State<FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 0.02.h(context)),
      child: ExpansionTile(
        iconColor: AppColor.secondryColor,
        collapsedIconColor: AppColor.secondryColor,
        title: Text(widget.questionKey.tr,
            style: TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: EdgeInsets.all(0.013.h(context)),
            child: Text(widget.answerKey.tr),
          ),
        ],
      ),
    );
  }
}