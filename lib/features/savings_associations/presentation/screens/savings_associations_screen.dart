import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../getx/controller/savings_association_controller.dart';
import '../widget/savings_association_card.dart';

class SavingsAssociationsScreen extends StatefulWidget {
  const SavingsAssociationsScreen({super.key});

  @override
  State<SavingsAssociationsScreen> createState() => _SavingsAssociationsScreenState();
}

class _SavingsAssociationsScreenState extends State<SavingsAssociationsScreen> {
  final SavingsAssociationController controller =
      Get.isRegistered<SavingsAssociationController>()
          ? Get.find<SavingsAssociationController>()
          : Get.put(SavingsAssociationController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.fetchAssociations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.savingsAssociations.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Obx(() {
            if (controller.isLoading.value && controller.associations.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.associations.isEmpty) {
              return RefreshIndicator(
                onRefresh: controller.fetchAssociations,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 8),
                    _Header(controller: controller),
                    const SizedBox(height: 40),
                    _EmptyState(onRefresh: controller.fetchAssociations),
                  ],
                ),
              );
            }

            final visible = controller.filteredAssociations;

            return RefreshIndicator(
              onRefresh: controller.fetchAssociations,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  _Header(controller: controller),
                  const SizedBox(height: 16),
                  _FilterBar(controller: controller),
                  const SizedBox(height: 16),
                  if (visible.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          AppString.noAssociations.tr,
                          style: TextStyle(color: AppColor.blackLight),
                        ),
                      ),
                    )
                  else
                    ...visible.map(
                      (a) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: SavingsAssociationCard(association: a),
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
}

class _Header extends StatelessWidget {
  const _Header({required this.controller});

  final SavingsAssociationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColor.heroGradient(),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.30),
            blurRadius: 30,
            offset: const Offset(0, 16),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.16)),
            ),
            child: const Icon(Icons.savings_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.savingsAssociations.tr,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppString.savingsAssociationsSubtitle.tr,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.82),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Obx(() {
            final n = controller.pendingInvitesCount;
            if (n == 0) return const SizedBox.shrink();
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '$n',
                style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.w900, fontSize: 13),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.controller});

  final SavingsAssociationController controller;

  @override
  Widget build(BuildContext context) {
    final filters = <_FilterData>[
      _FilterData(null, AppString.allAssociations.tr, Icons.grid_view_rounded),
      _FilterData('invited', AppString.pendingInvites.tr, Icons.mail_outline_rounded),
      _FilterData('active', AppString.activeAssociations.tr, Icons.autorenew_rounded),
      _FilterData('completed', AppString.completedAssociations.tr, Icons.verified_rounded),
    ];

    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((item) {
            final selected = controller.selectedFilter.value == item.value;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                selected: selected,
                onSelected: (_) => controller.setFilter(item.value),
                showCheckmark: false,
                avatar: Icon(item.icon, size: 15, color: selected ? Colors.white : AppColor.primaryColor),
                label: Text(item.label),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF334155),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
                selectedColor: AppColor.primaryColor,
                backgroundColor: Colors.white,
                side: BorderSide(color: selected ? Colors.transparent : const Color(0xFFE2E8F0)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
  const _FilterData(this.value, this.label, this.icon);
  final String? value;
  final String label;
  final IconData icon;
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.savings_outlined, size: 64, color: AppColor.grey),
            const SizedBox(height: 16),
            Text(
              AppString.noAssociations.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              AppString.noAssociationsSubtitle.tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.blackLight),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(AppString.refresh.tr),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
