import 'package:get/get.dart';

class TasksController extends GetxController {
  final status = 0.obs;

  void setStatus(int index) {
    status.value = index;
  }
}
