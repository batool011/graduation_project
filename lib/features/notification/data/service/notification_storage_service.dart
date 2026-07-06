import 'dart:convert';

import 'package:career/features/notification/data/model/app_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationStorageService {
  static const String _storageKey = 'stored_notifications';

  static Future<List<AppNotification>> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final rawNotifications = prefs.getStringList(_storageKey) ?? <String>[];

    final notifications = rawNotifications
        .map((item) => AppNotification.fromJson(
              Map<String, dynamic>.from(jsonDecode(item) as Map),
            ))
        .toList();

    notifications.sort((left, right) => right.createdAt.compareTo(left.createdAt));
    return notifications;
  }

  static Future<void> saveNotifications(List<AppNotification> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    final rawNotifications = notifications.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_storageKey, rawNotifications);
  }

  static Future<void> addNotification(AppNotification notification) async {
    final notifications = await loadNotifications();
    notifications.removeWhere((item) => item.id == notification.id);
    notifications.insert(0, notification);
    await saveNotifications(notifications);
  }

  static Future<void> deleteNotification(String id) async {
    final notifications = await loadNotifications();
    notifications.removeWhere((item) => item.id == id);
    await saveNotifications(notifications);
  }

  static Future<void> clearNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

  static Future<void> storeRemoteMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) {
      return;
    }

    final messageKey = _buildMessageKey(message);
    final storedNotification = AppNotification(
      id: messageKey,
      notificationId: messageKey.hashCode,
      title: notification.title?.trim().isNotEmpty == true
          ? notification.title!.trim()
          : 'إشعار جديد',
      body: notification.body?.trim().isNotEmpty == true
          ? notification.body!.trim()
          : '',
      data: Map<String, dynamic>.from(message.data),
      createdAt: message.sentTime ?? DateTime.now(),
    );

    await addNotification(storedNotification);
  }

  static String _buildMessageKey(RemoteMessage message) {
    final notification = message.notification;
    final sentTime = message.sentTime?.millisecondsSinceEpoch ?? 0;
    final title = notification?.title ?? '';
    final body = notification?.body ?? '';
    final data = message.data;

    if (message.messageId != null && message.messageId!.isNotEmpty) {
      return message.messageId!;
    }

    return '$sentTime|$title|$body|${jsonEncode(data)}';
  }
}