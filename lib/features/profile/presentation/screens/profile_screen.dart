// lib/features/profile/presentation/screens/profile_screen.dart

import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/controller/profile_controller.dart';
import '../widget/profile_document_card.dart';
import '../widget/profile_header.dart';
import '../widget/profile_info_card.dart';
import '../widget/profile_shift_card.dart';
import '../widget/profile_stat_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller;
    if (Get.isRegistered<ProfileController>()) {
      controller = Get.find<ProfileController>();
    } else {
      controller = Get.put(ProfileController());
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.myProfile.tr),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.profile.value == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        }

        final profile = controller.profile.value;

        if (profile == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_off_outlined,
                  size: 60,
                  color: AppColor.darkGrey,
                ),
                const SizedBox(height: 16),
                Text(
                  AppString.noData.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.darkGrey,
                      ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.fetchProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppString.retry.tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshProfile,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: height * 0.03),
            child: Column(
              children: [
                ProfileHeader(profile: profile),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Expanded(
                        child: ProfileStatCard(
                          title: AppString.status.tr,
                          value: profile.statusLabel,
                          icon: Icons.verified_user_rounded,
                          color: profile.isApproved
                              ? AppColor.green
                              : AppColor.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ProfileStatCard(
                          title: AppString.documents.tr,
                          value: '${controller.documentsCount}',
                          icon: Icons.folder_rounded,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                ProfileInfoCard(
                  title: AppString.personalInformation.tr,
                  icon: Icons.person_outline_rounded,
                  children: [
                    _InfoRow(
                      label: AppString.fullName.tr,
                      value: profile.name,
                      icon: Icons.person_outline_rounded,
                    ),
                    _InfoRow(
                      label: AppString.username.tr,
                      value: profile.username,
                      icon: Icons.alternate_email_rounded,
                    ),
                    _InfoRow(
                      label: AppString.email.tr,
                      value: profile.email,
                      icon: Icons.email_outlined,
                    ),
                    _InfoRow(
                      label: AppString.joinDate.tr,
                      value: _formatDate(profile.createdAt),
                      icon: Icons.calendar_today_outlined,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                ProfileShiftCard(
                  shiftName: controller.shiftName,
                  shiftTime: controller.shiftTime,
                ),
                const SizedBox(height: 12),

                ProfileDocumentCard(
                  personalIdPhotos: profile.documents.personalIdPhoto,
                  employmentContracts: profile.documents.employmentContract,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return '${parsed.day}/${parsed.month}/${parsed.year}';
    } catch (e) {
      return date;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.grey.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppColor.primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColor.darkGrey,
                        fontSize: 11,
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
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