import 'package:career/core/widget/snak_bar_service.dart';
import 'package:career/features/complaints/data/model/complaint_model.dart';
import 'package:career/features/complaints/data/repository/complaints_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintsController extends GetxController {
  final ComplaintsRepository _repo = ComplaintsRepository();

  final RxList<ComplaintModel> complaints = <ComplaintModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  int get totalCount => complaints.length;
  int get resolvedCount {
    return complaints
        .where(
          (item) {
            final value = item.status.toLowerCase();
            return value == 'resolved' || value == 'done' || value == 'closed';
          },
        )
        .length;
  }

  int get pendingCount {
    return complaints
        .where(
          (item) {
            final value = item.status.toLowerCase();
            return value == 'pending' || value == 'open' || value == 'in_progress';
          },
        )
        .length;
  }

  void prepareNewComplaint() {
    titleController.clear();
    descriptionController.clear();
  }

  Future<void> loadComplaints() async {
    isLoading.value = true;
    try {
      final result = await _repo.getComplaints();
      result.fold(
        (failure) => SnackbarService.error(failure.message),
        (data) => complaints.assignAll(data),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitComplaint() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      SnackbarService.error('يرجى تعبئة عنوان الشكوى والتفاصيل');
      return;
    }

    if (title.length < 4) {
      SnackbarService.error('عنوان الشكوى قصير جدا');
      return;
    }

    if (description.length < 10) {
      SnackbarService.error('يرجى كتابة تفاصيل أوضح للشكوى');
      return;
    }

    isSubmitting.value = true;
    try {
      final result = await _repo.addComplaint(
        title: title,
        description: description,
      );

      result.fold(
        (failure) => SnackbarService.error(failure.message),
        (response) async {
          titleController.clear();
          descriptionController.clear();
          Get.back();
          final body = response.data;
          final apiMessage =
              body is Map<String, dynamic>
                  ? (body['message']?.toString().trim() ?? '')
                  : '';
          SnackbarService.success(
            apiMessage.isNotEmpty ? apiMessage : 'تم إرسال الشكوى بنجاح',
          );
          await loadComplaints();
        },
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadComplaints();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}