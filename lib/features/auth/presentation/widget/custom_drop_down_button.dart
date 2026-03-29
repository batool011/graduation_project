import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../core/constant/class/app_color.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hint;
  final Function(String?) onChanged;
  final Widget prefixIcon;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.hint,
    required this.onChanged,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {

    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            value: value,
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
                      value ?? hint,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColor.darkGrey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down,
                      size: 22, color: AppColor.lightCyan),
                ],
              ),
            ),

            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              );
            }).toList(),

            onChanged: onChanged,

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
