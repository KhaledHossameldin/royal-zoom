import '../../../core/results/result.dart';
import '../../../data/models/chat/message.dart';
import '../../../data/models/new_chat/new_chat.dart';

abstract class IChatRepo {
  Future<Result<NewChat>> startChat({
    required num resouceId,
    required num resouceType,
  });

  Future<Result<List<ChatMessage>>> getChatMessages({
    required int chatId,
  });

  Future<Result<List<NewChat>>> getChats();

  Future<Result<NewChat>> getChat({required int id});
}
