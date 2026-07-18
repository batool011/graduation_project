import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/complaints/data/model/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintCard({
    super.key,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = complaint.status.toLowerCase();
    final isResolved =
        normalizedStatus == 'resolved' || normalizedStatus == 'done' || normalizedStatus == 'closed';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.primaryColor.withAlpha(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  complaint.title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              _StatusBadge(status: complaint.status, isResolved: isResolved),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${AppString.complaintNumber.tr}: #${complaint.id}',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey[700],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            complaint.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                complaint.createdAt,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final bool isResolved;

  const _StatusBadge({required this.status, required this.isResolved});

  @override
  Widget build(BuildContext context) {
    final bg = isResolved ? const Color(0xFFE8F8EF) : const Color(0xFFFFF5E9);
    final textColor = isResolved ? const Color(0xFF149954) : const Color(0xFFD8872F);

    final localizedStatus = isResolved 
        ? AppString.resolved.tr 
        : (status == 'pending' ? AppString.underReview.tr : status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        localizedStatus,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}