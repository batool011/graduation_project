import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailJoController extends GetxController {
  RxInt selectedTab = 0.obs;

  final targetLocation = const LatLng(33.8886, 35.4955).obs;

  GoogleMapController? mapController;

  void changeTab(int index){
    selectedTab.value = index;
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  CameraPosition get initialCameraPosition => CameraPosition(
    target: targetLocation.value,
    zoom: 14,
  );

  Set<Marker> get markers => {
    Marker(
      markerId: const MarkerId("target"),
      position: targetLocation.value,
      infoWindow: const InfoWindow(title: "الموقع المطلوب"),
    )
  };
}
