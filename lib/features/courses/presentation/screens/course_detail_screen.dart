// course_detail_screen.dart - نسخة معدلة نهائياً
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../data/model/course_model.dart';
import '../getx/controller/courses_controller.dart';

class CourseDetailScreen extends StatelessWidget {
  final int courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<CoursesController>()
        ? Get.find<CoursesController>()
        : Get.put(CoursesController());

    controller.fetchCourseDetail(courseId);

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(
          text: 'AppString.courseDetails.tr',
        ),
      ),
      body: Obx(() {
        if (controller.isDetailLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        }
        final CourseModel? course = controller.selectedCourse.value;
        if (course == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 60, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                 ' AppString.unableToDisplayCourse.tr',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== هيدر احترافي =====
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColor.primaryColor,
                          AppColor.primaryColor.withOpacity(0.7),
                          Colors.purple.shade700.withOpacity(0.5),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // خلفية مزخرفة
                        Positioned(
                          right: -50,
                          top: -50,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -30,
                          bottom: -30,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.03),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 80,
                          top: 30,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.04),
                            ),
                          ),
                        ),
                        // المحتوى
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.06,
                            vertical: MediaQuery.of(context).size.height * 0.03,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              // أيقونة كبيرة
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.school_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                course.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 24,
                                      height: 1.2,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                course.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                              ),
                              const SizedBox(height: 20),
                              // شارات المعلومات - استخدام Wrap
                              Wrap(
                                spacing: 10,
                                runSpacing: 8,
                                children: [
                                  _buildInfoBadge(
                                    icon: Icons.timer_outlined,
                                    label:
                                        '${course.duration} ${course.duration == 1 ? 'AppString.day.tr' : 'AppString.days.tr'}',
                                  ),
                                  _buildInfoBadge(
                                    icon: Icons.groups_outlined,
                                    label: course.courseTarget,
                                  ),
                                  _buildInfoBadge(
                                    icon: Icons.insert_drive_file_outlined,
                                    label: '${course.contents.length} ملفات',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // زر الرجوع
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // ===== قسم المحتوى =====
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06,
                  vertical: MediaQuery.of(context).size.height * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان الملفات
                    Row(
                      children: [
                        Container(
                          width: 5,
                          height: 28,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColor.primaryColor,
                                Colors.purple.shade700,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          'محتويات الدورة',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor,
                                fontSize: 20,
                              ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColor.primaryColor,
                                Colors.purple.shade700,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${course.contents.length} ملف',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ===== بطاقات الملفات =====
                    ...course.contents.map((content) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(10),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                              spreadRadius: 2,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey[100]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // أيقونة الملف
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColor.primaryColor.withOpacity(0.15),
                                    Colors.purple.shade700.withOpacity(0.15),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                _getFileIcon(content.fileUrl),
                                color: AppColor.primaryColor,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 14),
                            // معلومات الملف - Expanded
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    content.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Color(0xFF1A1A2E),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  // معلومات الملف - استخدام Wrap بدلاً من Row
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 4,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      // حجم الملف
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.storage_outlined,
                                            size: 14,
                                            color: Colors.grey[400],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            content.readableSize,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: Colors.grey[500],
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ],
                                      ),
                                      // نقطة فاصلة
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      // مشاهدة
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.visibility_outlined,
                                            size: 14,
                                            color: Colors.grey[400],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'مشاهدة',
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            // زر التحميل
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColor.primaryColor,
                                    Colors.purple.shade700,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    final uri = Uri.parse(content.fileUrl);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(
                                        uri,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.download_rounded,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        const Text(
                                          'تحميل',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),

                    // ===== زر بدء الدورة =====
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColor.primaryColor,
                            Colors.purple.shade700,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // إضافة وظيفة بدء الدورة
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_circle_filled_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'بدء الدورة الآن',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // دالة مساعدة لبناء شارة معلومات
  Widget _buildInfoBadge({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // دالة لتحديد أيقونة الملف حسب النوع
  IconData _getFileIcon(String url) {
    if (url.contains('.pdf')) return Icons.picture_as_pdf_rounded;
    if (url.contains('.doc') || url.contains('.docx')) {
      return Icons.description_rounded;
    }
    if (url.contains('.xls') || url.contains('.xlsx')) {
      return Icons.table_chart_rounded;
    }
    if (url.contains('.ppt') || url.contains('.pptx')) {
      return Icons.slideshow_rounded;
    }
    if (url.contains('.jpg') || url.contains('.png') || url.contains('.jpeg')) {
      return Icons.image_rounded;
    }
    if (url.contains('.mp4') || url.contains('.mov') || url.contains('.avi')) {
      return Icons.video_file_rounded;
    }
    if (url.contains('.zip') || url.contains('.rar')) {
      return Icons.folder_zip_rounded;
    }
    return Icons.insert_drive_file_rounded;
  }
}