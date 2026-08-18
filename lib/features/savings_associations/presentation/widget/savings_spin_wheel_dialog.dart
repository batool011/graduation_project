import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../data/model/savings_association_model.dart';
import '../../data/realtime/savings_realtime_service.dart';

const _kSegmentColors = [
  Color(0xFFEC4899), Color(0xFFF43F5E), Color(0xFFF97316), Color(0xFFF59E0B),
  Color(0xFF84CC16), Color(0xFF10B981), Color(0xFF06B6D4), Color(0xFF3B82F6),
  Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFA855F7), Color(0xFFD946EF),
];

/// Shown automatically when a `cycle.spin.result` broadcast arrives while
/// the employee has this association's detail screen open. The winner is
/// already final by the time this dialog even opens (the backend decided
/// and saved it before broadcasting) - this widget only ever plays a
/// reveal animation of a result that can no longer change. There is no
/// "spin" trigger here at all: employees only ever watch, they can never
/// initiate a draw (that is a manager-only, web-only action).
class SavingsSpinWheelDialog extends StatefulWidget {
  const SavingsSpinWheelDialog({
    super.key,
    required this.eligibleMembers,
    required this.result,
  });

  final List<SavingsMemberModel> eligibleMembers;
  final SavingsSpinResult result;

  static Future<void> show(
    BuildContext context, {
    required List<SavingsMemberModel> eligibleMembers,
    required SavingsSpinResult result,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SavingsSpinWheelDialog(eligibleMembers: eligibleMembers, result: result),
    );
  }

  @override
  State<SavingsSpinWheelDialog> createState() => _SavingsSpinWheelDialogState();
}

class _SavingsSpinWheelDialogState extends State<SavingsSpinWheelDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  late final List<SavingsMemberModel> _members;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();

    _members = widget.eligibleMembers.isNotEmpty
        ? widget.eligibleMembers
        : [
            SavingsMemberModel(
              id: 0,
              userId: widget.result.recipientUserId,
              username: null,
              name: widget.result.recipientName,
              invitationStatus: 'joined',
              payoutOrder: null,
              hasCollected: false,
              collectedAt: null,
              respondedAt: null,
            ),
          ];

    final index = _members.indexWhere((m) => m.userId == widget.result.recipientUserId);
    final safeIndex = index == -1 ? 0 : index;
    final segmentAngle = (2 * math.pi) / _members.length;
    final targetCenter = safeIndex * segmentAngle + segmentAngle / 2;

    // Several full spins, then land exactly on the already-known winner.
    final endRadians = (2 * math.pi * 5) + ((2 * math.pi) - targetCenter);

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 4200));
    _rotation = Tween<double>(begin: 0, end: endRadians).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => _revealed = true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _revealed ? Icons.celebration_rounded : Icons.groups_rounded,
              color: AppColor.primaryColor,
              size: 26,
            ),
            const SizedBox(height: 8),
            Text(
              '${AppString.cyclesProgress.tr} #${widget.result.cycleNumber}',
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            const SizedBox(height: 18),
            if (!_revealed)
              SizedBox(
                width: 240,
                height: 240,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _rotation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotation.value,
                          child: CustomPaint(
                            size: const Size(240, 240),
                            painter: _WheelPainter(members: _members),
                          ),
                        );
                      },
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black87, width: 3),
                      ),
                    ),
                    const Positioned(
                      top: -4,
                      child: Icon(Icons.arrow_drop_down_rounded, size: 40, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            if (_revealed) ...[
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryColor.withOpacity(0.12),
                ),
                child: Icon(Icons.emoji_events_rounded, color: AppColor.primaryColor, size: 44),
              ),
              const SizedBox(height: 14),
              Text(
                AppString.youAreRecipient.tr,
                style: TextStyle(color: AppColor.blackLight, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                widget.result.recipientName,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(AppString.refresh.tr),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  _WheelPainter({required this.members});

  final List<SavingsMemberModel> members;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sweep = (2 * math.pi) / members.length;

    for (var i = 0; i < members.length; i++) {
      final paint = Paint()..color = _kSegmentColors[i % _kSegmentColors.length];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * sweep - math.pi / 2,
        sweep,
        true,
        paint,
      );
    }

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.black87
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    for (var i = 0; i < members.length; i++) {
      final angle = i * sweep + sweep / 2 - math.pi / 2;
      final labelOffset = Offset(
        center.dx + (radius * 0.62) * math.cos(angle),
        center.dy + (radius * 0.62) * math.sin(angle),
      );
      final name = (members[i].name ?? members[i].username ?? '').split(' ').first;

      final tp = TextPainter(
        text: TextSpan(
          text: name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 60);

      canvas.save();
      canvas.translate(labelOffset.dx, labelOffset.dy);
      canvas.rotate(angle + math.pi / 2);
      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate) => oldDelegate.members != members;
}
