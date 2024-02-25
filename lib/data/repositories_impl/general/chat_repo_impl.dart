import '../../../core/base_repo/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../domain/repositories/general/chat_repo_i.dart';
import '../../models/chat/chat_message.dart';
import '../../models/new_chat/new_chat.dart';
import '../../sources/local/shared_prefs.dart';
import '../../sources/remote/general/chat/chat_remote_data_souce.dart';

class ChatRepo extends BaseRepository implements IChatRepo {
  final ChatRemoteDataSource _cRD;
  final SharedPrefs _prefs;
  ChatRepo(this._cRD, this._prefs);
  @override
  Future<Result<NewChat>> getChat({required int id}) async {
    return await _cRD.getChat(type: _prefs.getUserType(), id: id);
  }

  @override
  Future<Result<List<ChatMessage>>> getChatMessages(
      {required int chatId}) async {
    return await _cRD.getChatMessages(
        chatId: chatId, type: _prefs.getUserType());
  }

  @override
  Future<Result<List<NewChat>>> getChats() async {
    return await _cRD.getChats(type: _prefs.getUserType());
  }

  @override
  Future<Result<NewChat>> startChat(
      {required num resouceId, required num resouceType}) async {
    return await _cRD.startChat(
        type: _prefs.getUserType(),
        resouceId: resouceId,
        resouceType: resouceType);
  }
}
