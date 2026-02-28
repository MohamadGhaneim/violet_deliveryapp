import 'package:deliveryapp/util/model/app_notification.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          notification.isRead
              ? const Color(0xFFF3F6F8) // read
              : const Color(0xFFE8F4FD), // unread

      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          notification.isRead
              ? Icons.notifications_none
              : Icons.notifications_active,
          color: notification.isRead ? Colors.grey : Colors.orange,
        ),

        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight:
                notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.body),
            Text(
              formatNotificationDate(notification.createdAt),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

String formatNotificationDate(String createdAt) {
  final DateTime date = DateTime.parse(createdAt).toLocal();
  final DateTime now = DateTime.now();

  final Duration diff = now.difference(date);

  if (diff.inMinutes < 10) {
    return "Now";
  } else if (diff.inHours < 24 && now.day == date.day) {
    return "Today";
  } else if (diff.inDays == 1) {
    return "Yesterday";
  } else if (diff.inDays < 7) {
    return "This week";
  } else {
    return "${date.year}-${twoDigits(date.month)}-${twoDigits(date.day)}";
  }
}

String twoDigits(int n) => n.toString().padLeft(2, '0');
