import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/overtime_requests/data/model/overtime_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'overtime_chips.dart';

class OvertimeRequestItemCard extends StatelessWidget {
  const OvertimeRequestItemCard({super.key, required this.request});

  final OvertimeRequestModel request;

  @override
  Widget build(BuildContext context) {
    final isApproved = request.isApproved;
    final isRejected = request.isRejected;

    final statusColor = isApproved
        ? const Color(0xFF16A34A)
        : isRejected
            ? const Color(0xFFDC2626)
            : const Color(0xFFD9770B);

    final statusBackground = isApproved
        ? const Color(0xFFECFDF3)
        : isRejected
            ? const Color(0xFFFEF2F2)
            : const Color(0xFFFFF8E7);

    final statusIcon = isApproved
        ? Icons.check_circle_rounded
        : isRejected
            ? Icons.cancel_rounded
            : Icons.hourglass_top_rounded;

    // Approval is a binary outcome (pending/approved/rejected), not a
    // percentage of completion - a progress bar only makes sense once the
    // request is actually resolved. Showing a fabricated number (like a
    // fixed "55%") for a still-pending request would just be misleading.
    final resolvedProgress = isApproved ? 1.0 : (isRejected ? 0.0 : null);

    final screenWidth = MediaQuery.of(context).size.width;
    final maxChipWidth = screenWidth > 600 ? 280.0 : screenWidth * 0.60;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFFBFCFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9EEF6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: statusColor.withOpacity(0.14)),
                ),
                child: Icon(statusIcon, color: statusColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.reason.isEmpty ? '-' : request.reason,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.event_rounded,
                          size: 13,
                          color: Color(0xFF94A3B8),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            '${AppString.overtimeDate.tr}: ${request.dateLabel}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: const Color(0xFF64748B),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 118),
                child: OvertimeStatusChip(
                  label: request.status,
                  color: statusColor,
                  background: statusBackground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEDF2F8)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OvertimeInfoChip(
                icon: Icons.timer_outlined,
                label:
                    '${AppString.overtimeMinutes.tr}: ${request.requestedMinutes}',
                color: const Color(0xFF2563EB),
                maxWidth: maxChipWidth,
              ),
              OvertimeInfoChip(
                icon: Icons.badge_outlined,
                label: '${AppString.shift.tr}: ${request.shift.name}',
                color: const Color(0xFF7C3AED),
                maxWidth: maxChipWidth,
              ),
              OvertimeInfoChip(
                icon: Icons.person_outline_rounded,
                label: '${AppString.username.tr}: ${request.user.username}',
                color: const Color(0xFF0D9488),
                maxWidth: maxChipWidth,
              ),
            ],
          ),
          if (resolvedProgress != null) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: resolvedProgress,
                minHeight: 7,
                backgroundColor: const Color(0xFFE7EDF5),
                color: statusColor,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.receipt_outlined,
                size: 14,
                color: Color(0xFF94A3B8),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${AppString.request.tr} #${request.id}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.schedule_rounded,
                size: 14,
                color: Color(0xFF94A3B8),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  request.createdAtLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w700,
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
