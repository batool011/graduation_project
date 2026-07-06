import 'package:career/features/courses/presentation/screens/course_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../data/model/course_model.dart';


class CourseCard extends StatelessWidget {
  final CourseModel course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CourseDetailScreen(courseId: course.id));
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.school_outlined, color: AppColor.primaryColor, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              course.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              course.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 11),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer_outlined, size: 14, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  '${course.duration} ${course.duration == 1 ? AppString.day.tr : AppString.days.tr}',
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}