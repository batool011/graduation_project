import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/core/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx/controller/chatbot_controller.dart';
import '../widget/chat_bubble.dart';
import '../widget/chat_suggestions_bar.dart';
import '../widget/chat_typing_indicator.dart';

class ChatbotScreen extends GetView<ChatbotController> {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(
          text: AppString.assistant.tr,
          // CustomAppBar in this project renders a plain title bar with
          // no actions slot, so the "clear chat" affordance lives inside
          // the body instead (see _ClearChatButton below) rather than
          // requiring changes to the shared app bar widget.
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.messages.isEmpty) {
                  return _WelcomeState(
                    onSuggestionTap: controller.sendMessage,
                  );
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.fromLTRB(14, 16, 14, 8),
                  itemCount:
                      controller.messages.length + (controller.isSending.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.messages.length) {
                      return const ChatTypingIndicator();
                    }
                    return ChatBubble(message: controller.messages[index]);
                  },
                );
              }),
            ),
            Obx(
              () => controller.messages.isNotEmpty
                  ? _ClearChatBar(controller: controller)
                  : const SizedBox.shrink(),
            ),
            _MessageInputBar(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _WelcomeState extends StatelessWidget {
  const _WelcomeState({required this.onSuggestionTap});

  final ValueChanged<String> onSuggestionTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColor.primaryColor, Color(0xFF5B6BE6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 20),
          Text(
            AppString.askAssistant.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            AppString.assistantSubtitle.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.blackLight,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 28),
          Align(
            alignment: Alignment.centerRight,
            child: ChatSuggestionsBar(onSelect: onSuggestionTap),
          ),
        ],
      ),
    );
  }
}

class _ClearChatBar extends StatelessWidget {
  const _ClearChatBar({required this.controller});

  final ChatbotController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: () => showCustomDialog(
            context,
            title: AppString.clearChatConfirmTitle.tr,
            subtitle: AppString.clearChatConfirmMessage.tr,
            image: const Icon(Icons.delete_outline_rounded, size: 40, color: Color(0xFFDC2626)),
            confirmText: AppString.clearChat.tr,
            cancelText: AppString.cancel.tr,
            onConfirm: () async {
              controller.clearConversation();
              Navigator.of(context).pop();
            },
          ),
          icon: const Icon(Icons.delete_outline_rounded, size: 16, color: Color(0xFF94A3B8)),
          label: Text(
            AppString.clearChat.tr,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class _MessageInputBar extends StatelessWidget {
  const _MessageInputBar({required this.controller});

  final ChatbotController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        10,
        12,
        10 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => controller.sendMessage(),
              decoration: InputDecoration(
                hintText: AppString.typeYourQuestion.tr,
                filled: true,
                fillColor: const Color(0xFFF1F5F9),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Obx(
            () => Material(
              color: AppColor.primaryColor,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: controller.isSending.value ? null : () => controller.sendMessage(),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: controller.isSending.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.2, color: Colors.white),
                        )
                      : const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
