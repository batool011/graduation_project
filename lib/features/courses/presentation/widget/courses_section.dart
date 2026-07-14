// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../core/constant/class/app_color.dart';
// import '../../../../core/constant/class/app_string.dart';
// import '../getx/controller/courses_controller.dart';
// import 'course_card.dart';

// class CoursesSection extends StatelessWidget {
//   const CoursesSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.isRegistered<CoursesController>()
//         ? Get.find<CoursesController>()
//         : Get.put(CoursesController());

//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const SizedBox(
//           height: 150,
//           child: Center(child: CircularProgressIndicator()),
//         );
//       }
//       if (controller.courses.isEmpty) {
//         return const SizedBox.shrink();
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               AppString.coursesTitle.tr,
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: AppColor.primaryColor,
//                   ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           SizedBox(
//             height: 165,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: controller.courses.length,
//               itemBuilder: (context, index) {
//                 return CourseCard(course: controller.courses[index]);
//               },
//             ),
//           ),
//           const SizedBox(height: 10),
//         ],
//       );
//     });
//   }
// }