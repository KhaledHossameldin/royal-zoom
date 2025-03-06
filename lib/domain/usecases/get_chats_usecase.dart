import '../../core/results/result.dart';
import '../../data/models/new_chat/new_chat.dart';
import '../repositories/general/chat_repo_i.dart';

class GetChatsUseCase implements IGetChatsUseCase {
  final IChatRepo _repo;
  GetChatsUseCase(this._repo);
  @override
  Future<Result<List<NewChat>>> call() async {
    return await _repo.getChats();
  }
}

abstract class IGetChatsUseCase {
  Future<Result<List<NewChat>>> call();
}
