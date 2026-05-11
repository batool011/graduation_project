import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/features/vacation/data/models/vacation_request_model.dart';
import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class VacationRequestDetailScreen extends GetView<VacationController> {
  const VacationRequestDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final requestId = Get.arguments as int;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadVacationRequestDetail(requestId);
    });

    Future<void> openAttachment(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      Get.snackbar('خطأ', 'رابط المرفق غير صالح');
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      Get.snackbar('خطأ', 'تعذر فتح المرفق');
    }
  }

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: CustomAppBar(text: 'تفاصيل الإجازة'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04.w(context), vertical: 0.02.h(context)),
          child: Obx(() {
            final request = controller.vacationDetail.value;

            if (controller.isVacationDetailLoading.value && request == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (request == null) {
              return _LoadingErrorState(onRetry: () => controller.loadVacationRequestDetail(requestId));
            }

            final statusColor = Color(request.statusColorValue);

            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primaryColor.withOpacity(0.12),
                        AppColor.white,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: AppColor.primaryColor.withOpacity(0.12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.14),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(Icons.beach_access_rounded, color: statusColor, size: 28),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  request.formattedFromDate,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: AppColor.black,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'طلب رقم #${request.id}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColor.blackLight,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          _StatusBadge(label: request.statusLabel, color: statusColor),
                        ],
                      ),
                      const SizedBox(height: 18),
                      _InfoGrid(request: request),
                      const SizedBox(height: 18),
                      Text(
                        'السبب',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColor.black,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.lightGrey.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          request.reason,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                height: 1.5,
                                color: AppColor.black,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'المرفقات',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColor.black,
                      ),
                ),
                const SizedBox(height: 12),
                if (request.attachments.isEmpty)
                  _EmptyAttachmentsState()
                else
                  ...request.attachments.map(
                    (attachment) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _AttachmentCard(
                        attachment: attachment,
                        onTap: () => openAttachment(attachment.fileUrl),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.request});

  final VacationRequest request;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DetailTile(
            label: 'المدة',
            value: '${request.duration} أيام',
            icon: Icons.timelapse_rounded,
            color: AppColor.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _DetailTile(
            label: 'الحالة',
            value: request.statusLabel,
            icon: Icons.verified_outlined,
            color: Color(request.statusColorValue),
          ),
        ),
      ],
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
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
                        fontWeight: FontWeight.w800,
                        color: AppColor.black,
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

class _AttachmentCard extends StatelessWidget {
  const _AttachmentCard({required this.attachment, required this.onTap});

  final VacationAttachment attachment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColor.grey.withOpacity(0.7)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.description_outlined, color: AppColor.primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attachment.documentProvider.isEmpty ? 'مرفق' : attachment.documentProvider,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColor.black,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      attachment.filePath,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.blackLight,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.open_in_new_rounded, color: AppColor.primaryColor),
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

class _EmptyAttachmentsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.grey.withOpacity(0.7)),
      ),
      child: Column(
        children: [
          const Icon(Icons.attach_file_rounded, color: AppColor.primaryColor, size: 34),
          const SizedBox(height: 10),
          Text(
            'لا توجد مرفقات لهذا الطلب',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _LoadingErrorState extends StatelessWidget {
  const _LoadingErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 42, color: AppColor.errorColor),
          const SizedBox(height: 10),
          Text(
            'تعذر تحميل التفاصيل',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}