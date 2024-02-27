import '../../core/results/result.dart';
import '../../data/models/new_chat/new_chat.dart';
import '../repositories/general/chat_repo_i.dart';

class StartChatUseCase implements IStartChatUseCase {
  final IChatRepo _repo;
  StartChatUseCase(this._repo);
  @override
  Future<Result<NewChat>> call(
      {required num resouceId, required num resouceType}) async {
    return await _repo.startChat(
        resouceId: resouceId, resouceType: resouceType);
  }
}

abstract class IStartChatUseCase {
  Future<Result<NewChat>> call({
    required num resouceId,
    required num resouceType,
  });
}
