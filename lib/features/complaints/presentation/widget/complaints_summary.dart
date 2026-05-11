import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/material.dart';

class ComplaintsSummary extends StatelessWidget {
  final int total;
  final int pending;
  final int resolved;

  const ComplaintsSummary({
    super.key,
    required this.total,
    required this.pending,
    required this.resolved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7082C0), Color(0xFF95A1D6)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'متابعة الشكاوي',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _MiniInfoCard(label: 'الإجمالي', value: total.toString())),
              const SizedBox(width: 8),
              Expanded(child: _MiniInfoCard(label: 'قيد المراجعة', value: pending.toString())),
              const SizedBox(width: 8),
              Expanded(child: _MiniInfoCard(label: 'تم الحل', value: resolved.toString())),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniInfoCard extends StatelessWidget {
  final String label;
  final String value;

  const _MiniInfoCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColor.white,
                ),
          ),
        ],
      ),
    );
  }
}

class ComplaintsEmptyState extends StatelessWidget {
  const ComplaintsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mark_unread_chat_alt_outlined,
              size: 58,
              color: Colors.grey[500],
            ),
            const SizedBox(height: 10),
            Text(
              'لا توجد شكاوي حاليا',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'ابدئي بإرسال شكوى جديدة وسيتم متابعتها من الإدارة.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}