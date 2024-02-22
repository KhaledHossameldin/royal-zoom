import '../../core/results/result.dart';
import '../../data/models/chat/message.dart';
import '../repositories/general/chat_repo_i.dart';

class GetChatMessagesUseCase implements IGetChatMessagesUseCase {
  final IChatRepo _repo;
  GetChatMessagesUseCase(this._repo);
  @override
  Future<Result<List<ChatMessage>>> call({
    required int chatId,
  }) async {
    return await _repo.getChatMessages(chatId: chatId);
  }
}

abstract class IGetChatMessagesUseCase {
  Future<Result<List<ChatMessage>>> call({
    required int chatId,
  });
}
