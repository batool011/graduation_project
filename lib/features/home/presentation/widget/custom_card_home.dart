import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/material.dart';

class CustomCardHome extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final void Function()? onTap;

  const CustomCardHome({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
     this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 140,
        decoration: BoxDecoration(
          color: AppColor.blue,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الدائرة الخضرا الصغيرة للآيكون
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColor.lightBlue.withAlpha(120),
                size: 22,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
