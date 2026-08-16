import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/complaints/data/model/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color _ink = Color(0xFF0F172A);
const Color _subInk = Color(0xFF64748B);
const Color _resolvedColor = Color(0xFF149954);
const Color _pendingColor = Color(0xFFD8872F);

class ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintCard({
    super.key,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = complaint.status.toLowerCase();

    final isResolved = normalizedStatus == 'resolved' ||
        normalizedStatus == 'done' ||
        normalizedStatus == 'closed';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColor.grey.withOpacity(0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
            spreadRadius: -8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  complaint.title.isEmpty ? '-' : complaint.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: _ink,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _StatusBadge(
                status: complaint.status,
                isResolved: isResolved,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.tag_rounded,
                size: 14,
                color: _subInk,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '${AppString.complaintNumber.tr}: #${complaint.id}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _subInk,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
              ),
            ),
            child: Text(
              complaint.description.isEmpty ? '-' : complaint.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF334155),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.schedule_rounded,
                size: 14,
                color: _subInk,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  complaint.createdAt.isEmpty ? '-' : complaint.createdAt,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _subInk,
                    fontWeight: FontWeight.w600,
                  ),
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

  const _StatusBadge({
    required this.status,
    required this.isResolved,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = status.toLowerCase();
    final isPending = normalizedStatus == 'pending';

    final color = isResolved
        ? _resolvedColor
        : isPending
        ? _pendingColor
        : AppColor.primaryColor;

    final localizedStatus = isResolved
        ? AppString.resolved.tr
        : isPending
        ? AppString.underReview.tr
        : status;

    final icon = isResolved
        ? Icons.check_circle_rounded
        : isPending
        ? Icons.hourglass_top_rounded
        : Icons.info_rounded;

    return Container(
      constraints: const BoxConstraints(maxWidth: 130),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: color.withOpacity(0.16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              localizedStatus,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}