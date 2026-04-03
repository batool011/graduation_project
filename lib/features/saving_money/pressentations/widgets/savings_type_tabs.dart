// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/savings_controller.dart';

// class SavingsTypeTabs extends StatelessWidget {
//   final controller = Get.find<SavingsController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         tabItem("الكل", "all"),
//         tabItem("البيضاء", "white"),
//         tabItem("الفضية", "silver"),
//         tabItem("البرونزية", "bronze"),
//         tabItem("الذهبية", "gold"),
//       ],
//     ));
//   }

//   Widget tabItem(String title, String type) {
//     return GestureDetector(
//       onTap: () => controller.changeType(type),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: controller.selectedType.value == type
//               ? Colors.blue
//               : Colors.grey.shade300,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: controller.selectedType.value == type
//                 ? Colors.white
//                 : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
