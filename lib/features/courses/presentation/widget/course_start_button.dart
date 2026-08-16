import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_color.dart';

/// Generic pill CTA button used across the course detail/exam screens
/// ("Start Exam", "Retry Exam", etc.) - kept as one shared widget so every
/// call-to-action in the training module looks and behaves the same way.
class CourseStartButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool outlined;

  const CourseStartButton({
    super.key,
    required this.label,
    this.icon = Icons.play_circle_filled_rounded,
    this.onTap,
    this.isLoading = false,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null || isLoading;

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : AppColor.primaryColor,
        borderRadius: BorderRadius.circular(20),
        border: outlined ? Border.all(color: AppColor.primaryColor, width: 1.4) : null,
        boxShadow: outlined
            ? null
            : [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled ? null : onTap,
          borderRadius: BorderRadius.circular(20),
          child: Opacity(
            opacity: disabled && !isLoading ? 0.5 : 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        outlined ? AppColor.primaryColor : Colors.white,
                      ),
                    ),
                  )
                else
                  Icon(
                    icon,
                    color: outlined ? AppColor.primaryColor : AppColor.secondryColor,
                    size: 26,
                  ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: outlined ? AppColor.primaryColor : Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
