import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/custom_dialog.dart';
import '../../data/model/savings_association_model.dart';
import '../../data/realtime/savings_realtime_service.dart';
import '../getx/controller/savings_association_controller.dart';
import '../widget/savings_cycle_tile.dart';
import '../widget/savings_member_tile.dart';
import '../widget/savings_spin_wheel_dialog.dart';
import '../widget/savings_status_badge.dart';
import 'savings_discussion_room_screen.dart';

class SavingsAssociationDetailScreen extends StatefulWidget {
  const SavingsAssociationDetailScreen({super.key, required this.associationId});

  final int associationId;

  @override
  State<SavingsAssociationDetailScreen> createState() => _SavingsAssociationDetailScreenState();
}

class _SavingsAssociationDetailScreenState extends State<SavingsAssociationDetailScreen> {
  final SavingsAssociationController controller = Get.isRegistered<SavingsAssociationController>()
      ? Get.find<SavingsAssociationController>()
      : Get.put(SavingsAssociationController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.fetchDetail(widget.associationId));

    // Real-time: if this association's manager spins the wheel on the web
    // app while this employee happens to have the detail screen open,
    // they see it live too - purely a spectator reveal, never a trigger.
    SavingsRealtimeService.instance.listenToAssociation(widget.associationId, (result) {
      if (!mounted) return;

      final eligible = controller.selected.value?.members
              .where((m) => m.isJoined && !m.hasCollected)
              .toList() ??
          <SavingsMemberModel>[];

      SavingsSpinWheelDialog.show(context, eligibleMembers: eligible, result: result);
      controller.fetchDetail(widget.associationId);
    });
  }

  @override
  void dispose() {
    SavingsRealtimeService.instance.stop();
    super.dispose();
  }

  Future<void> _confirmRespond(bool accept) async {
    await showCustomDialog(
      context,
      title: accept ? AppString.joinConfirmTitle.tr : AppString.declineConfirmTitle.tr,
      subtitle: accept ? AppString.joinConfirmMessage.tr : AppString.declineConfirmMessage.tr,
      image: Icon(
        accept ? Icons.check_circle_outline_rounded : Icons.cancel_outlined,
        size: 44,
        color: accept ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
      ),
      confirmText: accept ? AppString.joinAssociation.tr : AppString.declineInvitation.tr,
      cancelText: AppString.cancel.tr,
      onConfirm: () async {
        await controller.respond(associationId: widget.associationId, accept: accept);
        if (mounted) Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(
          text: AppString.savingsAssociations.tr,
          actions: [
            Obx(() {
              final a = controller.selected.value;
              if (a == null) return const SizedBox.shrink();
              return IconButton(
                onPressed: () => Get.to(() => SavingsDiscussionRoomScreen(associationId: a.id, title: a.name)),
                icon: const Icon(Icons.forum_rounded, color: Colors.white),
              );
            }),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isDetailLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor));
          }

          final a = controller.selected.value;
          if (a == null) {
            return Center(child: Text(AppString.noData.tr));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _InfoCard(association: a),
              if (a.canRespond) ...[
                const SizedBox(height: 16),
                _RespondBar(controller: controller, onRespond: _confirmRespond),
              ],
              if (a.isRandomOrder && a.isActive) ...[
                const SizedBox(height: 16),
                const _RandomNotice(),
              ],
              const SizedBox(height: 20),
              _SectionTitle(icon: Icons.groups_rounded, title: '${AppString.members.tr} (${a.members.length})'),
              const SizedBox(height: 10),
              ...a.members.map((m) => SavingsMemberTile(member: m)),
              if (a.cycles.isNotEmpty) ...[
                const SizedBox(height: 12),
                _SectionTitle(icon: Icons.timeline_rounded, title: AppString.cyclesProgress.tr),
                const SizedBox(height: 10),
                ...a.cycles.map(
                  (c) => SavingsCycleTile(
                    cycle: c,
                    isMine: c.recipientUserId != null &&
                        a.myMembership != null &&
                        c.recipientMemberId == a.myMembership!.id,
                  ),
                ),
              ],
              const SizedBox(height: 24),
            ],
          );
        }),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.association});

  final SavingsAssociationModel association;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppColor.heroGradient(),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(color: AppColor.primaryColor.withOpacity(0.25), blurRadius: 22, offset: const Offset(0, 12)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  association.name,
                  style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w900),
                ),
              ),
              SavingsStatusBadge(status: association.status),
            ],
          ),
          if (association.description != null && association.description!.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(association.description!, style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.5)),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              _stat(AppString.monthlyAmount.tr, association.monthlyAmount.toStringAsFixed(0)),
              _stat(
                AppString.members.tr,
                '${association.joinedMembersCount}${association.targetMemberCount != null ? '/${association.targetMemberCount}' : ''}',
              ),
              _stat(
                association.isFixedOrder ? AppString.payoutOrderFixed.tr : AppString.payoutOrderRandom.tr,
                '',
                icon: association.isFixedOrder ? Icons.format_list_numbered_rounded : Icons.casino_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value, {IconData? icon}) {
    return Expanded(
      child: Column(
        children: [
          if (icon != null)
            Icon(icon, color: Colors.white, size: 18)
          else
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
            ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10.5, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _RespondBar extends StatelessWidget {
  const _RespondBar({required this.controller, required this.onRespond});

  final SavingsAssociationController controller;
  final Future<void> Function(bool) onRespond;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: controller.isResponding.value ? null : () => onRespond(false),
              icon: const Icon(Icons.close_rounded, size: 18),
              label: Text(AppString.declineInvitation.tr),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFDC2626),
                side: const BorderSide(color: Color(0xFFDC2626)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: controller.isResponding.value ? null : () => onRespond(true),
              icon: controller.isResponding.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.check_rounded, size: 18),
              label: Text(AppString.joinAssociation.tr),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RandomNotice extends StatelessWidget {
  const _RandomNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        children: [
          const Icon(Icons.casino_rounded, color: Color(0xFFB45309), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              AppString.randomOrderNotice.tr,
              style: const TextStyle(color: Color(0xFF92400E), fontSize: 12.5, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: AppColor.primaryColor),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900, color: AppColor.black),
        ),
      ],
    );
  }
}
