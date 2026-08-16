import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../data/model/course_enrollment_model.dart';
import '../getx/controller/courses_controller.dart';
import '../widget/my_course_card.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  final CoursesController controller = Get.isRegistered<CoursesController>()
      ? Get.find<CoursesController>()
      : Get.put(CoursesController());

  @override
  void initState() {
    super.initState();
    // Always refresh on entry - the controller may have been preloaded at
    // app launch (see MainBinding) before a manager assigned this
    // employee any course, so trusting the cached list alone can miss
    // newly-assigned courses until a manual pull-to-refresh.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMyCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Obx(() {
            if (controller.isLoading.value && controller.myCourses.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.myCourses.isEmpty) {
              return RefreshIndicator(
                onRefresh: controller.fetchMyCourses,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 8),
                    _TopHeader(controller: controller),
                    const SizedBox(height: 24),
                    _EmptyCoursesState(onRefresh: controller.fetchMyCourses),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }

            final visibleCourses = controller.filteredCourses;
            // Surface the most urgent course first: overdue, then in
            // progress, then assigned, completed/failed last.
            final featured = _mostUrgent(controller.myCourses);

            return RefreshIndicator(
              onRefresh: controller.fetchMyCourses,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  _TopHeader(controller: controller),
                  const SizedBox(height: 18),
                  if (featured != null) ...[
                    MyCourseCard(enrollment: featured, featured: true),
                    const SizedBox(height: 20),
                  ],
                  _AllCoursesHeader(count: visibleCourses.length),
                  const SizedBox(height: 14),
                  if (visibleCourses.isEmpty)
                    _FilteredEmptyState(onClearFilter: () => controller.setStatusFilter(null))
                  else
                    ...visibleCourses
                        .where((e) => e.id != featured?.id)
                        .map(
                          (enrollment) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: MyCourseCard(enrollment: enrollment),
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  CourseEnrollmentModel? _mostUrgent(List<CourseEnrollmentModel> courses) {
    if (courses.isEmpty) return null;
    final sorted = [...courses]..sort((a, b) => _urgencyRank(a).compareTo(_urgencyRank(b)));
    return sorted.first;
  }

  int _urgencyRank(CourseEnrollmentModel e) {
    if (e.isOverdue && !e.isCompleted) return 0;
    if (e.isInProgress) return 1;
    if (e.isAssigned) return 2;
    if (e.isFailed) return 3;
    return 4; // completed
  }
}

class _AllCoursesHeader extends StatelessWidget {
  const _AllCoursesHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppString.allCourses.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColor.black,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColor.primaryColor.withOpacity(0.14)),
          ),
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            height: 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: LinearGradient(
                colors: [AppColor.grey.withOpacity(0.35), Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader({required this.controller});

  final CoursesController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C8CF8), Color(0xFF5B6BE6), Color(0xFF3D48B5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B6BE6).withOpacity(0.30),
            blurRadius: 30,
            offset: const Offset(0, 16),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.16)),
                ),
                child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.myCourses.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Obx(
                          () => Text(
                        '${controller.myCourses.length} ${AppString.allCourses.tr.toLowerCase()}'
                            '${controller.overdueCount > 0 ? ' • ${controller.overdueCount} ${AppString.courseOverdue.tr.toLowerCase()}' : ''}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.82),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _StatusFilterBar(controller: controller),
        ],
      ),
    );
  }
}

class _StatusFilterBar extends StatelessWidget {
  const _StatusFilterBar({required this.controller});

  final CoursesController controller;

  @override
  Widget build(BuildContext context) {
    final filters = <_FilterData>[
      _FilterData(status: null, label: AppString.allCourses.tr, icon: Icons.grid_view_rounded),
      _FilterData(
        status: CourseEnrollmentStatus.assigned,
        label: AppString.courseStatusAssigned.tr,
        icon: Icons.hourglass_top_rounded,
      ),
      _FilterData(
        status: CourseEnrollmentStatus.inProgress,
        label: AppString.courseStatusInProgress.tr,
        icon: Icons.autorenew_rounded,
      ),
      _FilterData(
        status: CourseEnrollmentStatus.completed,
        label: AppString.courseStatusCompleted.tr,
        icon: Icons.verified_rounded,
      ),
      _FilterData(
        status: CourseEnrollmentStatus.failed,
        label: AppString.courseStatusFailed.tr,
        icon: Icons.error_outline_rounded,
      ),
    ];

    return Obx(
          () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((item) {
            final selected = controller.selectedStatusFilter.value == item.status;

            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ChoiceChip(
                selected: selected,
                onSelected: (_) => controller.setStatusFilter(item.status),
                showCheckmark: false,
                avatar: Icon(
                  item.icon,
                  size: 16,
                  color: selected ? const Color(0xFF3D48B5) : Colors.white,
                ),
                label: Text(item.label),
                labelStyle: TextStyle(
                  color: selected ? const Color(0xFF3D48B5) : Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
                selectedColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.14),
                side: BorderSide(
                  color: selected ? Colors.transparent : Colors.white.withOpacity(0.18),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _FilterData {
  const _FilterData({required this.status, required this.label, required this.icon});

  final String? status;
  final String label;
  final IconData icon;
}

class _EmptyShell extends StatelessWidget {
  const _EmptyShell({required this.icon, required this.title, required this.subtitle, required this.action});

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.grey.withOpacity(0.14)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.07),
            blurRadius: 28,
            offset: const Offset(0, 16),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [Color(0xFFEEF2FF), Color(0xFFE4EAFF)]),
              border: Border.all(color: const Color(0xFF4F46E5).withOpacity(0.12)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withOpacity(0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: Icon(icon, size: 40, color: const Color(0xFF4F46E5)),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColor.blackLight,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 22),
          action,
        ],
      ),
    );
  }
}

class _FilteredEmptyState extends StatelessWidget {
  const _FilteredEmptyState({required this.onClearFilter});

  final VoidCallback onClearFilter;

  @override
  Widget build(BuildContext context) {
    return _EmptyShell(
      icon: Icons.filter_alt_off_rounded,
      title: AppString.noCoursesForFilter.tr,
      subtitle: AppString.noCoursesAssignedSubtitle.tr,
      action: OutlinedButton.icon(
        onPressed: onClearFilter,
        icon: const Icon(Icons.clear_rounded, size: 18),
        label: Text(AppString.clearFilter.tr),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF4F46E5),
          backgroundColor: const Color(0xFF4F46E5).withOpacity(0.04),
          side: BorderSide(color: const Color(0xFF4F46E5).withOpacity(0.6)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}

class _EmptyCoursesState extends StatelessWidget {
  const _EmptyCoursesState({required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return _EmptyShell(
      icon: Icons.school_outlined,
      title: AppString.noCoursesAssigned.tr,
      subtitle: AppString.noCoursesAssignedSubtitle.tr,
      action: ElevatedButton.icon(
        onPressed: () => onRefresh(),
        icon: const Icon(Icons.refresh_rounded, size: 18),
        label: Text(AppString.refresh.tr),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4F46E5),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
