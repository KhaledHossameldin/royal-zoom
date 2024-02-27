import '../../core/results/result.dart';
import '../../data/models/new_chat/new_chat.dart';
import '../repositories/general/chat_repo_i.dart';

class GetChatUseCase implements IGetChatUseCase {
  final IChatRepo _repo;
  GetChatUseCase(this._repo);
  @override
  Future<Result<NewChat>> call({required int id}) async {
    return await _repo.getChat(id: id);
  }
}

abstract class IGetChatUseCase {
  Future<Result<NewChat>> call({required int id});
}
