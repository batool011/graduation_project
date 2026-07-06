import 'package:career/features/profile/data/repository/profile_repository.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}