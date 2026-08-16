import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatSuggestionsBar extends StatelessWidget {
  const ChatSuggestionsBar({super.key, required this.onSelect});

  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final suggestions = <_Suggestion>[
      _Suggestion(AppString.suggestedVacationBalance.tr, Icons.beach_access_rounded),
      _Suggestion(AppString.suggestedWorkSchedule.tr, Icons.calendar_month_rounded),
      _Suggestion(AppString.suggestedEvaluation.tr, Icons.star_rounded),
      _Suggestion(AppString.suggestedHowToVacation.tr, Icons.help_outline_rounded),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: suggestions.map((s) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onSelect(s.text),
            borderRadius: BorderRadius.circular(999),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColor.primaryColor.withOpacity(0.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(s.icon, size: 15, color: AppColor.primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    s.text,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _Suggestion {
  const _Suggestion(this.text, this.icon);
  final String text;
  final IconData icon;
}
