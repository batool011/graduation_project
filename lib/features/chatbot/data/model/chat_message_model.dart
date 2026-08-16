enum ChatMessageSender { user, assistant }

class ChatMessageModel {
  final String id;
  final String text;
  final ChatMessageSender sender;
  final DateTime timestamp;
  final bool isError;

  ChatMessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.isError = false,
  });

  bool get isUser => sender == ChatMessageSender.user;
}
