import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../getx/controller/savings_association_controller.dart';

class SavingsDiscussionRoomScreen extends StatefulWidget {
  const SavingsDiscussionRoomScreen({super.key, required this.associationId, required this.title});

  final int associationId;
  final String title;

  @override
  State<SavingsDiscussionRoomScreen> createState() => _SavingsDiscussionRoomScreenState();
}

class _SavingsDiscussionRoomScreenState extends State<SavingsDiscussionRoomScreen> {
  final SavingsAssociationController controller = Get.find<SavingsAssociationController>();

  @override
  void initState() {
    super.initState();
    controller.messages.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMessages(widget.associationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: '${AppString.discussionRoom.tr} - ${widget.title}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isMessagesLoading.value && controller.messages.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.messages.isEmpty) {
                  return Center(
                    child: Text(AppString.noMessagesYet.tr, style: TextStyle(color: AppColor.blackLight)),
                  );
                }
                return ListView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.all(14),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final m = controller.messages[index];
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.grey.withOpacity(0.4)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              m.name ?? m.username ?? '-',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColor.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(m.message, style: const TextStyle(fontSize: 13.5)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(12, 10, 12, 10 + MediaQuery.of(context).padding.bottom),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, -4))],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      minLines: 1,
                      maxLines: 4,
                      onSubmitted: (_) => controller.sendMessage(widget.associationId),
                      decoration: InputDecoration(
                        hintText: AppString.typeYourMessage.tr,
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
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
                        onTap: controller.isSendingMessage.value ? null : () => controller.sendMessage(widget.associationId),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: controller.isSendingMessage.value
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
            ),
          ],
        ),
      ),
    );
  }
}
