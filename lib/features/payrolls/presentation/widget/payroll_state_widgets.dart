import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/material.dart';
import 'payroll_theme.dart';

class PayrollDecorCircle extends StatelessWidget {
  const PayrollDecorCircle({
    super.key,
    required this.size,
    required this.opacity,
    this.color = Colors.white,
  });

  final double size;
  final double opacity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(opacity),
      ),
    );
  }
}

class PayrollLoadingState extends StatelessWidget {
  const PayrollLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: PayrollTheme.softBorder),
          boxShadow: [
            BoxShadow(
              color: PayrollTheme.ink.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.6,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
