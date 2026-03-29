import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/detail-job/presentation/getx/controller/detail_job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends GetView<DetailJoController> {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GoogleMap(
        initialCameraPosition: controller.initialCameraPosition,
        zoomControlsEnabled: false,
        scrollGesturesEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: controller.onMapCreated,
        markers: controller.markers,
      );
    });
  }
}
