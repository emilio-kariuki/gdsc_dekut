
import '../repositories/message_repository.dart';

class MessageProviders {
  Future sendMessage({
    required String message,
    required String image,
  }) async {
    final response = await MessageRepository().sendMessage(
      message: message,
      image: image,
    );
    return response;
  }

  Future<bool> deleteMessage({required int time}) async {
    final response = await MessageRepository().deleteMessage(time: time);
    return response;
  }
}
