import 'package:career/core/widget/snak_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/savings_association_model.dart';
import '../../../data/repository/savings_association_repository.dart';

class SavingsAssociationController extends GetxController {
  final SavingsAssociationRepository _repo = SavingsAssociationRepository();

  final RxList<SavingsAssociationModel> associations = <SavingsAssociationModel>[].obs;
  final RxBool isLoading = false.obs;

  /// null = all. Otherwise: 'invited' | 'active' | 'completed'
  final Rxn<String> selectedFilter = Rxn<String>();

  final Rx<SavingsAssociationModel?> selected = Rx<SavingsAssociationModel?>(null);
  final RxBool isDetailLoading = false.obs;
  final RxBool isResponding = false.obs;

  final RxList<SavingsMessageModel> messages = <SavingsMessageModel>[].obs;
  final RxBool isMessagesLoading = false.obs;
  final RxBool isSendingMessage = false.obs;
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  List<SavingsAssociationModel> get filteredAssociations {
    final f = selectedFilter.value;
    if (f == null) return associations.toList();
    if (f == 'invited') {
      return associations.where((a) => a.myMembership?.isInvited == true).toList();
    }
    if (f == 'active') {
      return associations.where((a) => a.isActive || a.isOpenForJoining).toList();
    }
    return associations.where((a) => a.isCompleted).toList();
  }

  int get pendingInvitesCount =>
      associations.where((a) => a.myMembership?.isInvited == true).length;

  void setFilter(String? f) => selectedFilter.value = f;

  Future<void> fetchAssociations() async {
    isLoading.value = true;
    final result = await _repo.getAll();
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (data) => associations.assignAll(data),
    );
    isLoading.value = false;
  }

  Future<void> fetchDetail(int id) async {
    isDetailLoading.value = true;
    selected.value = null;
    final result = await _repo.getOne(id);
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (data) => selected.value = data,
    );
    isDetailLoading.value = false;
  }

  Future<void> respond({required int associationId, required bool accept}) async {
    isResponding.value = true;
    final result = await _repo.respond(associationId: associationId, accept: accept);
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (data) {
        selected.value = data;
        final idx = associations.indexWhere((a) => a.id == data.id);
        if (idx != -1) {
          associations[idx] = data;
          associations.refresh();
        }
        SnackbarService.success(accept ? 'تم انضمامك للجمعية بنجاح' : 'تم رفض الدعوة');
      },
    );
    isResponding.value = false;
  }

  Future<void> fetchMessages(int associationId) async {
    isMessagesLoading.value = true;
    final result = await _repo.getMessages(associationId);
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (data) => messages.assignAll(data),
    );
    isMessagesLoading.value = false;
    _scrollToBottomSoon();
  }

  Future<void> sendMessage(int associationId) async {
    final text = messageController.text.trim();
    if (text.isEmpty || isSendingMessage.value) return;

    messageController.clear();
    isSendingMessage.value = true;
    final result = await _repo.postMessage(associationId: associationId, message: text);
    result.fold(
      (failure) => SnackbarService.error(failure.message),
      (msg) => messages.add(msg),
    );
    isSendingMessage.value = false;
    _scrollToBottomSoon();
  }

  void _scrollToBottomSoon() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchAssociations();
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
