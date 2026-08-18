import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/material.dart';

class OvertimeDialogActionButton extends StatelessWidget {
  const OvertimeDialogActionButton({
    super.key,
    required this.label,
    required this.isPrimary,
    required this.isLoading,
    required this.isDisabled,
    required this.onPressed,
  });

  final String label;
  final bool isPrimary;
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.72 : 1,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          gradient: isPrimary && !isDisabled
              ? LinearGradient(
                  colors: [
                    Color(0xFF4F46E5)      ,
                    Color(0xFF4F46E5)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isPrimary
              ? (isDisabled ? const Color(0xFFCBD5E1) : null)
              : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(16),
          border: isPrimary
              ? null
              : Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: isPrimary && !isDisabled
              ? [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.22),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: isDisabled ? null : onPressed,
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      label,
                      style: TextStyle(
                        color: isPrimary
                            ? Colors.white
                            : const Color(0xFF334155),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
