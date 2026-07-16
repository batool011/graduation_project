import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/features/vacation/data/models/vacation_request_model.dart';
import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VacationRequestsSection extends StatelessWidget {
  const VacationRequestsSection({super.key, required this.controller});

  final VacationController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final totalCount = controller.vacationMeta.value?.total ?? controller.vacationRequests.length;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.event_note_rounded, color: AppColor.primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.vacationRequests.tr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColor.black,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$totalCount ${AppString.request.tr}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.blackLight,
                          ),
                    ),
                  ],
                ),
              ),
              if (controller.isVacationListLoading.value)
                const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2.2),
                )
              else
                _CountPill(count: totalCount),
            ],
          ),
          const SizedBox(height: 16),
          if (controller.isVacationListLoading.value)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 28),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (controller.vacationRequests.isEmpty)
            _EmptyVacationsState(onRefresh: controller.fetchVacationRequests)
          else
            ListView.separated(
              itemCount: controller.vacationRequests.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = controller.vacationRequests[index];
                return VacationRequestCard(
                  item: item,
                  onTap: () => Get.toNamed(
                    RoutesName.vacationRequestDetails,
                    arguments: item.id,
                  ),
                );
              },
            ),
        ],
      );
    });
  }
}

class VacationRequestCard extends StatelessWidget {
  const VacationRequestCard({super.key, required this.item, this.onTap});

  final VacationRequest item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = Color(item.statusColorValue);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.grey.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(Icons.beach_access_rounded, color: statusColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.formattedFromDate,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColor.black,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${AppString.requestNumber.tr}${item.id}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColor.blackLight,
                              ),
                        ),
                      ],
                    ),
                  ),
                  _StatusBadge(label: item.statusLabel, color: statusColor),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                item.reason,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.black,
                      height: 1.4,
                    ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _MetaTile(
                      label: AppString.duration.tr,
                      value: '${item.duration} ${item.duration == 1 ? AppString.day.tr : AppString.days.tr}',
                      icon: Icons.timer_outlined,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MetaTile(
                      label: AppString.status.tr,
                      value: item.statusLabel,
                      icon: Icons.verified_outlined,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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

class _MetaTile extends StatelessWidget {
  const _MetaTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColor.blackLight,
                      ),
                ),
                const SizedBox(height: 4),
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

class _CountPill extends StatelessWidget {
  const _CountPill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$count',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _EmptyVacationsState extends StatelessWidget {
  const _EmptyVacationsState({required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.lightGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(Icons.beach_access_outlined, size: 40, color: AppColor.primaryColor),
          const SizedBox(height: 12),
          Text(
            AppString.noVacationRequests.tr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            AppString.updateDataOrSendNew.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.blackLight,
                ),
          ),
          const SizedBox(height: 14),
          TextButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(AppString.refresh.tr),
          ),
        ],
      ),
    );
  }
}