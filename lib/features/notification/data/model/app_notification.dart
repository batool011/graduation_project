import 'dart:convert';

class AppNotification {
  final String id;
  final int notificationId;
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime createdAt;

  const AppNotification({
    required this.id,
    required this.notificationId,
    required this.title,
    required this.body,
    required this.data,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notificationId': notificationId,
      'title': title,
      'body': body,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String? ?? '',
      notificationId: json['notificationId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      data: Map<String, dynamic>.from(json['data'] as Map? ?? const {}),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  String get serializedData => jsonEncode(data);
}