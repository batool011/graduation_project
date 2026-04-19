import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showLogoutConfirmationDialog(
  BuildContext context, {
  required Future<void> Function() onConfirm,
}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      var isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            title: Text(AppString.logoutConfirmationTitle.tr),
            content: Text(AppString.logoutConfirmationMessage.tr),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => Navigator.of(dialogContext).pop(),
                child: Text(AppString.cancel.tr),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: AppColor.white,
                ),
                onPressed:
                    isLoading
                        ? null
                        : () async {
                          setState(() => isLoading = true);
                          await onConfirm();
                        },
                child:
                    isLoading
                        ? SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColor.white),
                          ),
                        )
                        : Text(AppString.confirmLogout.tr),
              ),
            ],
          );
        },
      );
    },
  );
}