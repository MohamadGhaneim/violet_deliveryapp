class AppNotification {
  final int id;
  final String title;
  final int? orderId;
  final String body;
  final bool isRead;
  final String createdAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.orderId,
    required this.isRead,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      body: json['body'] ?? "",
      isRead: json['is_read'] ?? false,
      createdAt: json['created_at'] ?? 'unknow',
      orderId: json['order_id'],
    );
  }
}
