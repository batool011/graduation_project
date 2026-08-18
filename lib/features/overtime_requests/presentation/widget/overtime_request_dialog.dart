import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/overtime_requests/presentation/getx/controller/overtime_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'overtime_dialog_action_button.dart';

class OvertimeRequestDialog extends StatefulWidget {
  const OvertimeRequestDialog({super.key, required this.controller});

  final OvertimeController controller;

  @override
  State<OvertimeRequestDialog> createState() => _OvertimeRequestDialogState();
}

class _OvertimeRequestDialogState extends State<OvertimeRequestDialog> {
  Worker? _submitWatcher;
  bool _submitStarted = false;

  @override
  void initState() {
    super.initState();

    _submitWatcher = ever(widget.controller.isSubmitting, (isSubmitting) {
      if (isSubmitting == true) {
        _submitStarted = true;
      } else if (_submitStarted && mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _submitWatcher?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 560),
        decoration: BoxDecoration(
          // Same color as OvertimeScreen background
          color: const Color(0xFFF5F7FC),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: const Color(0xFFE9EEF6)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withOpacity(0.08),
              blurRadius: 28,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4F46E5), Color(0xFF4F46E5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4F46E5).withOpacity(0.22),
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.edit_calendar_rounded,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.overtimeRequestForm.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          AppString.requestOvertime.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFF64748B),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Obx(() {
                final hasShift =
                    widget.controller.prefilledShiftId.value != null;
                final shiftName =
                    widget.controller.prefilledShiftName.value ?? '-';

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: const Color(0xFFDCE7FF)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F46E5).withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF4FF),
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: const Color(0xFFDCE7FF),
                          ),
                        ),
                        child: const Icon(
                          Icons.badge_rounded,
                          color: Color(0xFF4F46E5),
                          size: 19,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.shift.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                color: const Color(0xFF64748B),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              hasShift
                                  ? '$shiftName (#${widget.controller.prefilledShiftId.value})'
                                  : AppString.noData.tr,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                color: const Color(0xFF0F172A),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 14),
              _field(
                context: context,
                controller: widget.controller.dateController,
                label: AppString.overtimeDate.tr,
                icon: Icons.event_rounded,
                readOnly: true,
                onTap: () => widget.controller.pickDate(context),
                suffixIcon: Icons.keyboard_arrow_down_rounded,
              ),
              const SizedBox(height: 12),
              _field(
                context: context,
                controller: widget.controller.minutesController,
                label: AppString.overtimeMinutes.tr,
                icon: Icons.timer_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              _field(
                context: context,
                controller: widget.controller.reasonController,
                label: AppString.overtimeReason.tr,
                icon: Icons.notes_rounded,
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              _field(
                context: context,
                controller: widget.controller.shiftIdController,
                label: AppString.overtimeShiftId.tr,
                icon: Icons.badge_outlined,
                readOnly: true,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Obx(() {
                final isSubmitting = widget.controller.isSubmitting.value;

                return Row(
                  children: [
                    Expanded(
                      child: OvertimeDialogActionButton(
                        label: MaterialLocalizations.of(context)
                            .cancelButtonLabel,
                        isPrimary: false,
                        isLoading: false,
                        isDisabled: isSubmitting,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OvertimeDialogActionButton(
                        label: AppString.requestOvertime.tr,
                        isPrimary: true,
                        isLoading: isSubmitting,
                        isDisabled: isSubmitting,
                        onPressed: () => widget.controller.submitRequest(),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    IconData? suffixIcon,
  }) {
    final borderRadius = BorderRadius.circular(16);

    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(
        color: Color(0xFF0F172A),
        fontWeight: FontWeight.w600,
      ),
      cursorColor: AppColor.primaryColor,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF64748B)),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: const Color(0xFF94A3B8), size: 20)
            : null,
        filled: true,

        // White fields look better on the screen-colored dialog background
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: Color(0xFFE4E9F2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: Color(0xFFE4E9F2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: AppColor.primaryColor, width: 1.35),
        ),
        labelStyle: const TextStyle(
          color: Color(0xFF64748B),
          fontWeight: FontWeight.w600,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w700,
        ),
        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
      ),
    );
  }
}