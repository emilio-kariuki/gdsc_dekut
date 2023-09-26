import 'package:gdsc_bloc/data/services/repositories/notifications_repository.dart';

class NotificationProviders {
  Future<void> showImportantNotification({
    required String message,
    required String title,
  }) async {
    final response = await NotificationsRepository()
        .showImportantNotification(message: message, title: title);
    return response;
  }

  Future<void> showNormalNotification({
    required String message,
    required String title,
  }) async {
    final response = await NotificationsRepository()
        .showNormalNotification(message: message, title: title);
    return response;
  }

  Future<bool> createPushNotification({
    required String title,
    required String message,
    required String image,
    required String topic,
  }) async {
    final response = await NotificationsRepository().createPushNotification(
      title: title,
      message: message,
      image: image,
      topic: topic,
    );
    return response;
  }

  Future initializeNotifications() async {
    final response = await NotificationsRepository().initializeNotifications();
    return response;
  }

  Future initializeFirebaseMessaging() async {
    final response =
        await NotificationsRepository().initializeFirebaseMessaging();
    return response;
  }

  Future<void> cancelNotification({required int id}) async {
    final response = await NotificationsRepository().cancelNotification(id: id);
    return response;
  }

  Future<String> getFirebaseMessagingToken() async {
    final response =
        await NotificationsRepository().getFirebaseMessagingToken();
    return response;
  }

  Future<bool> sendEventNotification({
    required String title,
    required String image,
    required String description,
  }) async {
    final response = await NotificationsRepository().sendEventNotification(
      title: title,
      image: image,
      description: description,
    );
    return response;
  }
}
