import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget image;
  final String confirmText;
  final String cancelText;
  final bool isLoading;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.confirmText,
    required this.cancelText,
    required this.isLoading,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          image,
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : onCancel,
          child: Text(cancelText),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            foregroundColor: AppColor.white,
          ),
          onPressed: isLoading ? null : onConfirm,
          child: isLoading
              ? SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.white),
                  ),
                )
              : Text(confirmText),
        ),
      ],
    );
  }
}

Future<void> showCustomDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  required Widget image,
  required Future<void> Function() onConfirm,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
  bool barrierDismissible = false,
}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (dialogContext) {
      var isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return CustomDialog(
            title: title,
            subtitle: subtitle,
            image: image,
            confirmText: confirmText,
            cancelText: cancelText,
            isLoading: isLoading,
            onCancel: () => Navigator.of(dialogContext).pop(),
            onConfirm: () async {
              setState(() => isLoading = true);
              await onConfirm();
            },
          );
        },
      );
    },
  );
}