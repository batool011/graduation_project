import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';

import '../../../../core/constant/class/app_color.dart';
import '../../data/models/leave_type_model.dart';

class CustomDropDownVacation extends StatelessWidget {
  final String? value;
  final List<LeaveType> items;
  final String hint;
  final Function(String?) onChanged;
  final Widget prefixIcon;
  final bool isLoading;

  const CustomDropDownVacation({
    super.key,
    required this.value,
    required this.items,
    required this.hint,
    required this.onChanged,
    required this.prefixIcon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    String? selectedLabel;
    for (final item in items) {
      if (item.dropdownValue == value) {
        selectedLabel = item.displayText;
        break;
      }
    }

    final bool hasItems = items.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          value: hasItems ? value : null,
          customButton: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 0.05.w(context),
              vertical: 0.02.h(context),
            ),
            decoration: BoxDecoration(
              color: AppColor.lightGrey,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                prefixIcon,
                12.horizontalSpace(),
                Expanded(
                  child: Text(
                    isLoading
                        ? hint
                        : selectedLabel ??
                            (hasItems ? hint : AppString.noVacationTypes.tr),
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: AppColor.darkGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isLoading)
                  const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 22,
                    color: AppColor.secondryColor,
                  ),
              ],
            ),
          ),

          items:
              items.map((item) {
                return DropdownMenuItem<String>(
                  value: item.dropdownValue,
                  child: Text(
                    item.displayText,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: Colors.black),
                  ),
                );
              }).toList(),

          onChanged: (isLoading || !hasItems) ? null : onChanged,

          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: AppColor.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          menuItemStyleData: const MenuItemStyleData(height: 42),
        ),
      ),
    );
  }
}
