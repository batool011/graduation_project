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
          text: AppString.courseDetails.tr,
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
                Icon(Icons.error_outline, size: 60, color: AppColor.darkGrey),
                const SizedBox(height: 16),
                Text(
                  AppString.unableToDisplayCourse.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.darkGrey,
                  ),
                ),
              ],
            ),
          );
        }
<<<<<<< HEAD
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== الهيدر مع الـ Stack =====
              Stack(
                children: [
                  // خلفية الهيدر
=======

        // هذا هو الـ Stack الرئيسي الذي يحتوي على كل شيء
        return Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
>>>>>>> batool
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Stack(
                      children: [
<<<<<<< HEAD
                        // خلفية مزخرفة
=======
>>>>>>> batool
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
<<<<<<< HEAD
                        // المحتوى
=======
>>>>>>> batool
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.06,
                            vertical: MediaQuery.of(context).size.height * 0.03,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColor.secondryColor.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColor.secondryColor.withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
<<<<<<< HEAD
                                child: Icon(
                                  Icons.school_rounded,
                                  color: AppColor.secondryColor,
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
                                course.description.isNotEmpty 
                                    ? course.description 
                                    : AppString.noDescription.tr,
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
                              Wrap(
                                spacing: 10,
                                runSpacing: 8,
                                children: [
                                  _buildInfoBadge(
                                    icon: Icons.timer_outlined,
                                    label:
                                        '${course.duration} ${course.duration == 1 ? AppString.day.tr : AppString.days.tr}',
                                  ),
                                  _buildInfoBadge(
                                    icon: Icons.groups_outlined,
                                    label: course.courseTarget.isNotEmpty 
                                        ? course.courseTarget 
                                        : AppString.students.tr,
                                  ),
                                  _buildInfoBadge(
                                    icon: Icons.insert_drive_file_outlined,
                                    label: '${course.contents.length} ${AppString.files.tr}',
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
                  // ✅ زر الرجوع داخل الـ Stack
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

              // ===== باقي المحتوى =====
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06,
                  vertical: MediaQuery.of(context).size.height * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 5,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          AppString.courseContents.tr,
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
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${course.contents.length} ${AppString.file.tr}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
=======
                                child: Icon(Icons.school_rounded, color: AppColor.secondryColor, size: 32),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                course.title,
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                course.description.isNotEmpty ? course.description : AppString.noDescription.tr,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Wrap(
                                spacing: 10,
                                runSpacing: 8,
                                children: [
                                  _buildInfoBadge(icon: Icons.timer_outlined, label: '${course.duration} ${course.duration == 1 ? AppString.day.tr : AppString.days.tr}'),
                                  _buildInfoBadge(icon: Icons.groups_outlined, label: course.courseTarget.isNotEmpty ? course.courseTarget : AppString.students.tr),
                                  _buildInfoBadge(icon: Icons.insert_drive_file_outlined, label: '${course.contents.length} ${AppString.files.tr}'),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
>>>>>>> batool
                        ),
                      ],
                    ),
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
                        Row(
                          children: [
                            Container(
                              width: 5,
                              height: 28,
                              decoration: BoxDecoration(color: AppColor.primaryColor, borderRadius: BorderRadius.circular(4)),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              AppString.courseContents.tr,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: AppColor.primaryColor, fontSize: 20),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: AppColor.primaryColor, borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                '${course.contents.length} ${AppString.file.tr}',
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...course.contents.map((content) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 20, offset: const Offset(0, 8), spreadRadius: 2)],
                              border: Border.all(color: AppColor.grey, width: 1),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(color: AppColor.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                                  child: Icon(_getFileIcon(content.fileUrl), color: AppColor.primaryColor, size: 28),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(content.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFF1A1A2E)), maxLines: 1, overflow: TextOverflow.ellipsis),
                                      const SizedBox(height: 6),
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 4,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.storage_outlined, size: 14, color: AppColor.darkGrey),
                                              const SizedBox(width: 4),
                                              Text(content.readableSize, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColor.darkGrey, fontSize: 12)),
                                            ],
                                          ),
<<<<<<< HEAD
                                          const SizedBox(width: 4),
                                          Text(
                                            content.readableSize,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: AppColor.darkGrey,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: AppColor.darkGrey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.visibility_outlined,
                                            size: 14,
                                            color: AppColor.darkGrey,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            AppString.watch.tr,
                                            style: TextStyle(
                                              color: AppColor.darkGrey,
                                              fontSize: 12,
                                            ),
=======
                                          Container(width: 4, height: 4, decoration: BoxDecoration(color: AppColor.darkGrey, shape: BoxShape.circle)),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.visibility_outlined, size: 14, color: AppColor.darkGrey),
                                              const SizedBox(width: 4),
                                              Text(AppString.watch.tr, style: TextStyle(color: AppColor.darkGrey, fontSize: 12)),
                                            ],
>>>>>>> batool
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(color: AppColor.secondryColor, borderRadius: BorderRadius.circular(14)),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        final uri = Uri.parse(content.fileUrl);
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(14),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.download_rounded, color: Colors.white, size: 18),
                                            const SizedBox(width: 4),
                                            Text(AppString.download.tr, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
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
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: AppColor.primaryColor.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.play_circle_filled_rounded, color: AppColor.secondryColor, size: 28),
                                  const SizedBox(width: 12),
                                  Text(AppString.startCourse.tr, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
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
            ),

            // زر الرجوع في مكانه الصحيح كابن مباشر للـ Stack
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildInfoBadge({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  IconData _getFileIcon(String url) {
    if (url.contains('.pdf')) return Icons.picture_as_pdf_rounded;
    if (url.contains('.doc') || url.contains('.docx')) return Icons.description_rounded;
    if (url.contains('.xls') || url.contains('.xlsx')) return Icons.table_chart_rounded;
    if (url.contains('.ppt') || url.contains('.pptx')) return Icons.slideshow_rounded;
    if (url.contains('.jpg') || url.contains('.png') || url.contains('.jpeg')) return Icons.image_rounded;
    if (url.contains('.mp4') || url.contains('.mov') || url.contains('.avi')) return Icons.video_file_rounded;
    if (url.contains('.zip') || url.contains('.rar')) return Icons.folder_zip_rounded;
    return Icons.insert_drive_file_rounded;
  }
}