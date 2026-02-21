import 'package:deliveryapp/util/model/app_notification.dart';
import 'package:deliveryapp/util/services/path.dart';
import 'package:dio/dio.dart';

class NotificationService {
  final Dio dio;
  NotificationService(this.dio);

  Future<List<AppNotification>> getUserNotifications(int pageNumber) async {
    try {
      final response = await dio.get(MyPath.notificationsByUser(pageNumber));

      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data
            .map((notification) => AppNotification.fromJson(notification))
            .toList();
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> notificationIsRead(AppNotification appNotification) async {
    try {
      await dio.put(
        MyPath.notificationsUpdate,
        data: {"id": appNotification.id},
      );
    } catch (e) {
      throw Exception('Failed to update isRead notifications $e');
    }
  }
}
