import 'dart:io';

import 'package:logger/logger.dart';

import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../../data/enums/chat_content_type.dart';
import '../repositories/general/chat_repo_i.dart';
import 'upload_file_usecase.dart';

class SendMessageUseCase implements ISendMessageUseCase {
  final IChatRepo _repo;
  final IUploadFileUseCase _upload;
  SendMessageUseCase(this._repo, this._upload);
  @override
  Future<Result<EmptyEntity>> call({
    required int chatId,
    required String content,
    required ChatContentType contentType,
  }) async {
    String? path;
    if (contentType == ChatContentType.attachment ||
        contentType == ChatContentType.voice) {
      final file = File(content);
      final size = await file.length();
      Logger().d(size);
      final tempResult = await _upload(file);
      Logger().d('line 26');
      if (tempResult.hasDataOnly) {
        Logger().d(tempResult.data);
        path = tempResult.data;
      } else {
        Logger().d(tempResult.error?.message);
        return Result(error: tempResult.error);
      }
    }
    return _repo.sendMessage(
        chatId: chatId, content: path ?? content, contentType: contentType);
  }
}

abstract class ISendMessageUseCase {
  Future<Result<EmptyEntity>> call({
    required int chatId,
    required String content,
    required ChatContentType contentType,
  });
}
