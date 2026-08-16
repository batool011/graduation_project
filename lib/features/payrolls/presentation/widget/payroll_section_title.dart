import 'package:flutter/material.dart';
import 'payroll_theme.dart';

class PayrollSectionTitle extends StatelessWidget {
  const PayrollSectionTitle({
    super.key,
    required this.title,
    required this.icon,
    this.count,
  });

  final String title;
  final IconData icon;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: PayrollTheme.blue.withOpacity(0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: PayrollTheme.blue),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: PayrollTheme.ink,
                ),
          ),
        ),
        if (count != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: PayrollTheme.blue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${count ?? 0}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: PayrollTheme.blue,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        ],
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [PayrollTheme.softBorder, Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PayrollEmptySectionBox extends StatelessWidget {
  const PayrollEmptySectionBox({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PayrollTheme.softBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: PayrollTheme.softBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, size: 18, color: PayrollTheme.subInk),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: PayrollTheme.subInk,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
