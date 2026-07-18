import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDocumentCard extends StatelessWidget {
  final List<String> personalIdPhotos;
  final List<String> employmentContracts;

  const ProfileDocumentCard({
    super.key,
    required this.personalIdPhotos,
    required this.employmentContracts,
  });

  @override
  Widget build(BuildContext context) {
    final hasDocuments = personalIdPhotos.isNotEmpty || employmentContracts.isNotEmpty;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.folder_rounded,
                  size: 20,
                  color: AppColor.primaryColor,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                AppString.documents.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${personalIdPhotos.length + employmentContracts.length}',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!hasDocuments)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_open_rounded,
                      size: 40,
                      color: AppColor.darkGrey.withOpacity(0.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppString.noDocuments.tr,
                      style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (personalIdPhotos.isNotEmpty)
                  _DocumentChip(
                    label: AppString.personalIdPhoto.tr,
                    count: personalIdPhotos.length,
                    icon: Icons.badge_rounded,
                  ),
                if (employmentContracts.isNotEmpty)
                  _DocumentChip(
                    label: AppString.employmentContract.tr,
                    count: employmentContracts.length,
                    icon: Icons.description_rounded,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _DocumentChip extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;

  const _DocumentChip({
    required this.label,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.primaryColor.withOpacity(0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColor.primaryColor),
          const SizedBox(width: 6),
          Text(
            '$label ($count)',
            style: TextStyle(
              fontSize: 12,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}