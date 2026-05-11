import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqTile extends StatefulWidget {
  final String questionKey;
  final String answerKey;

  const FaqTile({
    super.key,
    required this.questionKey,
    required this.answerKey,
  });

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 0.02.h(context)),
      child: ExpansionTile(
        iconColor: AppColor.secondryColor,
        collapsedIconColor: AppColor.secondryColor,
        title: Text(
          widget.questionKey.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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