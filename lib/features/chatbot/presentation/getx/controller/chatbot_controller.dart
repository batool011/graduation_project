
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/chat_message_model.dart';
import '../../../data/repository/chatbot_repository.dart';

class ChatbotController extends GetxController {
  final ChatbotRepository _repository = ChatbotRepository();

  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  final RxBool isSending = false.obs;
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  int _messageCounter = 0;

  Future<void> sendMessage([String? presetText]) async {
    final text = (presetText ?? messageController.text).trim();
    if (text.isEmpty || isSending.value) return;

    messageController.clear();
    _appendMessage(text, ChatMessageSender.user);
    isSending.value = true;
    _scrollToBottomSoon();

    final result = await _repository.ask(text);

    result.fold(
      (failure) {
        _appendMessage(failure.message, ChatMessageSender.assistant, isError: true);
      },
      (reply) {
        _appendMessage(reply.reply, ChatMessageSender.assistant);
      },
    );

    isSending.value = false;
    _scrollToBottomSoon();
  }

  void _appendMessage(String text, ChatMessageSender sender, {bool isError = false}) {
    _messageCounter++;
    messages.add(
      ChatMessageModel(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}_$_messageCounter',
        text: text,
        sender: sender,
        timestamp: DateTime.now(),
        isError: isError,
      ),
    );
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

  void clearConversation() {
    messages.clear();
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
