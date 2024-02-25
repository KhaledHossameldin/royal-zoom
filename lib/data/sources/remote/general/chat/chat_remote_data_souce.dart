import '../../../../../core/data_source/base_remote_data_source.dart';
import '../../../../../core/network/endpoints/network.dart';
import '../../../../../core/network/http_method.dart';
import '../../../../../core/results/result.dart';
import '../../../../enums/user_type.dart';
import '../../../../models/chat/chat_message.dart';
import '../../../../models/new_chat/new_chat.dart';

class ChatRemoteDataSource {
  Future<Result<NewChat>> startChat({
    required UserType type,
    required num resouceId,
    required num resouceType,
  }) async {
    return await RemoteDataSource.request(
        converter: (model) => NewChat.fromJson(model),
        method: HttpMethod.POST,
        url: Network.chatss(type),
        data: {
          'resource_id': resouceId,
          'resource_type': resouceType,
        });
  }

  Future<Result<List<ChatMessage>>> getChatMessages({
    required int chatId,
    required UserType type,
  }) async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((model) => ChatMessage.fromMap(model)).toList(),
      method: HttpMethod.GET,
      url: Network.getMessages(type, chatId),
    );
  }

  Future<Result<List<NewChat>>> getChats({required UserType type}) async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((model) => NewChat.fromJson(model)).toList(),
      method: HttpMethod.GET,
      url: Network.chatss(type),
    );
  }

  Future<Result<NewChat>> getChat(
      {required UserType type, required int id}) async {
    return await RemoteDataSource.request(
      converter: (model) => NewChat.fromJson(model),
      method: HttpMethod.GET,
      url: Network.chat(type, id),
    );
  }
}
