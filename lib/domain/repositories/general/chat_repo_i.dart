import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../data/enums/chat_content_type.dart';
import '../../../data/models/chat/chat_message.dart';
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
  Future<Result<EmptyEntity>> sendMessage({
    required int chatId,
    required String content,
    required ChatContentType contentType,
  });
}
