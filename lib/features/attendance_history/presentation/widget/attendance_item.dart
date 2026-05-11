import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import '../../data/models/attendance_history_model.dart';

class AttendanceItem extends StatelessWidget {
  const AttendanceItem({super.key, required this.item});

  final AttendanceHistory item;

  @override
  Widget build(BuildContext context) {
    final statusColor = Color(AttendanceStatusMapper.colorValue(item.status));
    final statusLabel = AttendanceStatusMapper.label(item.status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.grey.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.dayAndDateLabel,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.employee.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.blackLight,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(label: statusLabel, color: statusColor),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  label: 'Check in',
                  value: item.checkInTime ?? '-',
                  icon: Icons.login_rounded,
                  iconColor: AppColor.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoTile(
                  label: 'Check out',
                  value: item.checkOutTime ?? '-',
                  icon: Icons.logout_rounded,
                  iconColor: AppColor.secondryColor,
                ),
              ),
            ],
          ),
          12.verticalSpace(),
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  label: 'Working hours',
                  value: item.totalWorkingHours ?? '00:00:00',
                  icon: Icons.schedule_rounded,
                  iconColor: statusColor,
                ),
              ),
              12.verticalSpace(),
              Expanded(
                child: _InfoTile(
                  label: 'Minutes',
                  value: item.workingMinutes.toString(),
                  icon: Icons.timelapse_rounded,
                  iconColor: AppColor.blackLight,
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
  const _StatusBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.lightGrey.withOpacity(0.75),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor),
         10.horizontalSpace(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColor.blackLight),
                ),
                4.verticalSpace(),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColor.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
