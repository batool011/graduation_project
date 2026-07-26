import 'dart:io';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DocumentPicker extends StatelessWidget {
  final String title;
  final String hint;
  final IconData icon;
  final Rx<File?> file; 
  final VoidCallback onPick;
  final VoidCallback onRemove;

  const DocumentPicker({
    super.key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.file,
    required this.onPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
        ),
        const SizedBox(height: 6),
        Obx(
          () => GestureDetector(
            onTap: onPick,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 0.04.w(context),
                vertical: 0.02.h(context),
              ),
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: file.value != null ? AppColor.green : AppColor.grey,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    file.value != null
                        ? Icons.check_circle_rounded
                        : icon,
                    color: file.value != null
                        ? AppColor.green
                        : AppColor.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      file.value != null
                          ? file.value!.path.split(Platform.pathSeparator).last
                          : hint,
                      style: TextStyle(
                        color: file.value != null
                            ? AppColor.black
                            : AppColor.darkGrey,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (file.value != null)
                    GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}