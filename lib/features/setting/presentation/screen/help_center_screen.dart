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
      "question": "How can I request a leave?",
      "answer": "Go to the Vacation section, select your leave type and dates, and submit your request."
    },
    {
      "question": "How can I check my attendance?",
      "answer": "In the Attendance section, you can see your daily check-in and check-out history."
    },
    {
      "question": "How do I manage my savings?",
      "answer": "Go to the Savings section to see your current balance, history, and receipts."
    },
    {
      "question": "How do I earn reward points?",
      "answer": "HR assigns reward points based on performance, attendance, and achievements."
    },
    {
      "question": "How do I mark my attendance?",
      "answer": "Open the Attendance section and tap 'Check In' when you arrive at work and 'Check Out' when you leave. You can also view your daily attendance history."
    },
    {
      "question": "How do notifications help me?",
      "answer": "The app sends notifications to remind you about upcoming meetings, scheduled breaks, or any important updates from HR."
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
            question: item['question']!,
            answer: item['answer']!,
          );
        },
      ),
    );
  }
}

class FAQTile extends StatefulWidget {
  final String question;
  final String answer;

  const FAQTile({super.key, required this.question, required this.answer});

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
        title: Text(widget.question,
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
            child: Text(widget.answer),
          ),
        ],
      ),
    );
  }
}