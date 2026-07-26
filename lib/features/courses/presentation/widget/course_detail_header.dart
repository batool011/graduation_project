import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../data/model/course_model.dart';
import 'course_info_badge.dart';

class CourseDetailHeader extends StatelessWidget {
  final CourseModel course;

  const CourseDetailHeader({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                        CourseInfoBadge(
                          icon: Icons.timer_outlined,
                          label:
                              '${course.duration} ${course.duration == 1 ? AppString.day.tr : AppString.days.tr}',
                        ),
                        CourseInfoBadge(
                          icon: Icons.groups_outlined,
                          label: course.courseTarget.isNotEmpty
                              ? course.courseTarget
                              : AppString.students.tr,
                        ),
                        CourseInfoBadge(
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
    );
  }
}