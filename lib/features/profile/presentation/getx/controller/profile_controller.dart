
import 'package:career/features/profile/data/model/profile_model.dart';
import 'package:get/get.dart';
import 'package:career/core/widget/snak_bar_service.dart';
import '../../../data/repository/profile_repository.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository = ProfileRepository();

  final Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isRefreshing = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    final result = await _repository.getProfile();

    result.fold(
      (failure) {
        isLoading.value = false;
        SnackbarService.error(failure.message);
      },
      (data) {
        profile.value = data;
        isLoading.value = false;
      },
    );
  }

  Future<void> refreshProfile() async {
    isRefreshing.value = true;
    final result = await _repository.getProfile();

    result.fold(
      (failure) {
        isRefreshing.value = false;
        SnackbarService.error(failure.message);
      },
      (data) {
        profile.value = data;
        isRefreshing.value = false;
        SnackbarService.success('تم تحديث الملف الشخصي');
      },
    );
  }

  String get userName => profile.value?.name ?? '';
  String get userEmail => profile.value?.email ?? '';
  String get userStatus => profile.value?.statusLabel ?? '';
  bool get isApproved => profile.value?.isApproved ?? false;
  bool get isPending => profile.value?.isPending ?? false;

  String get shiftTime {
    final shift = profile.value?.shift;
    if (shift == null) return 'غير محدد';
    return shift.formattedTime;
  }

  String get shiftName {
    return profile.value?.shift?.name ?? 'غير محدد';
  }

  int get documentsCount {
    return profile.value?.documents.totalDocuments ?? 0;
  }
}