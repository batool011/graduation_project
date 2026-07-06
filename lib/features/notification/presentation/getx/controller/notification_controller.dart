import 'package:career/features/notification/data/model/app_notification.dart';
import 'package:career/features/notification/data/service/notification_storage_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RxList<AppNotification> notifications = <AppNotification>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    isLoading.value = true;
    notifications.assignAll(await NotificationStorageService.loadNotifications());
    isLoading.value = false;
  }

  Future<void> deleteNotification(String id) async {
    await NotificationStorageService.deleteNotification(id);
    notifications.removeWhere((item) => item.id == id);
  }

  Future<void> deleteAllNotifications() async {
    await NotificationStorageService.clearNotifications();
    notifications.clear();
  }
}