import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../data/model/course_enrollment_model.dart';

/// Maps an enrollment status to a color/icon/label, shared between the
/// "My Courses" list cards and the course detail screen so the visual
/// language stays consistent everywhere in the training module.
class CourseStatusStyle {
  final Color color;
  final IconData icon;
  final String label;

  const CourseStatusStyle({
    required this.color,
    required this.icon,
    required this.label,
  });

  factory CourseStatusStyle.forStatus(String status) {
    switch (status) {
      case CourseEnrollmentStatus.completed:
        return CourseStatusStyle(
          color: const Color(0xFF16A34A),
          icon: Icons.verified_rounded,
          label: AppString.courseStatusCompleted.tr,
        );
      case CourseEnrollmentStatus.inProgress:
        return CourseStatusStyle(
          color: const Color(0xFF2563EB),
          icon: Icons.autorenew_rounded,
          label: AppString.courseStatusInProgress.tr,
        );
      case CourseEnrollmentStatus.failed:
        return CourseStatusStyle(
          color: const Color(0xFFDC2626),
          icon: Icons.error_outline_rounded,
          label: AppString.courseStatusFailed.tr,
        );
      case CourseEnrollmentStatus.assigned:
      default:
        return CourseStatusStyle(
          color: const Color(0xFFF59E0B),
          icon: Icons.hourglass_top_rounded,
          label: AppString.courseStatusAssigned.tr,
        );
    }
  }
}

class CourseStatusBadge extends StatelessWidget {
  final String status;
  final bool compact;

  const CourseStatusBadge({super.key, required this.status, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final style = CourseStatusStyle.forStatus(status);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: style.color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: style.color.withOpacity(0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(style.icon, size: compact ? 12 : 14, color: style.color),
          const SizedBox(width: 4),
          Text(
            style.label,
            style: TextStyle(
              color: style.color,
              fontSize: compact ? 10 : 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

/// Small red "overdue" flag - independent of status, shown alongside it
/// when the course is unfinished past its due date.
class CourseOverdueBadge extends StatelessWidget {
  const CourseOverdueBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFDC2626).withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFDC2626).withOpacity(0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_amber_rounded, size: 14, color: Color(0xFFDC2626)),
          const SizedBox(width: 4),
          Text(
            AppString.courseOverdue.tr,
            style: const TextStyle(
              color: Color(0xFFDC2626),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
