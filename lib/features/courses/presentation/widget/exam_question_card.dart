import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../data/model/course_exam_model.dart';

class ExamQuestionCard extends StatelessWidget {
  final int index;
  final CourseExamQuestionModel question;
  final String? selectedAnswer;
  final ValueChanged<String> onSelect;

  const ExamQuestionCard({
    super.key,
    required this.index,
    required this.question,
    required this.selectedAnswer,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final answered = selectedAnswer != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: answered ? AppColor.primaryColor.withOpacity(0.3) : AppColor.grey.withOpacity(0.5),
          width: answered ? 1.3 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: -10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: answered
                      ? AppColor.primaryColor
                      : AppColor.primaryColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: answered ? Colors.white : AppColor.primaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  question.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Color(0xFF1A1A2E),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...question.options.map((option) {
            final selected = selectedAnswer == option;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => onSelect(option),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: selected ? AppColor.primaryColor.withOpacity(0.08) : AppColor.lightGrey,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected ? AppColor.primaryColor : Colors.transparent,
                        width: 1.4,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                          size: 20,
                          color: selected ? AppColor.primaryColor : AppColor.blackLight,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                              color: selected ? AppColor.primaryColor : AppColor.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
