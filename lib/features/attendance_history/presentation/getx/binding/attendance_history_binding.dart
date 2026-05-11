import 'package:get/get.dart';

import '../controller/attendance_history_controller.dart';

class AttendanceHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceHistoryController>(
      () => AttendanceHistoryController(),
    );
  }
}
