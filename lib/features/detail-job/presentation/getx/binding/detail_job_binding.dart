import 'package:career/features/detail-job/presentation/getx/controller/detail_job_controller.dart';
import 'package:get/get.dart';

class DetailJobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailJoController>(() => DetailJoController());

  }
}
