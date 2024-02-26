import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../../core/results/result.dart';
import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../core/states/base_wait_state.dart';
import '../../../../../core/utils/ui/snackbar/custom_snack_bar.dart';
import '../../../../../data/enums/chat_content_type.dart';
import '../../../../../data/models/chat/chat_message.dart';
import '../../../../../data/models/new_chat/new_chat.dart';
import '../../../../../domain/usecases/contect_to_pusher_usecase.dart';
import '../../../../../domain/usecases/get_chat_messages_usecase.dart';
import '../../../../../domain/usecases/get_chat_usecase.dart';
import '../../../../../domain/usecases/get_chats_usecase.dart';
import '../../../../../domain/usecases/send_message_usecase.dart';
import 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(
    this._chatsUseCase,
    this._chatUsecase,
    this._messagesUseCase,
    this._send,
    this._pusherUseCase,
  ) : super(ChatsState.initState());

  final IGetChatsUseCase _chatsUseCase;
  void showAllChats() {
    emit(state.copyWith(showAllChatsState: const BaseLoadingState()));
    _chatsUseCase().then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(showAllChatsState: BaseSuccessState(result.data)));
      } else {
        Logger().d(result.error?.message);
        emit(state.copyWith(showAllChatsState: BaseFailState(result.error)));
      }
    });
  }

  final IGetChatUseCase _chatUsecase;
  final IGetChatMessagesUseCase _messagesUseCase;
  final IConnectToPusherUseCase _pusherUseCase;
  List<ChatMessage> _messages = [];
  void showChatMessages(int chatId) {
    emit(state.copyWith(showChatMessagesState: const BaseLoadingState()));
    Future.wait([
      _chatUsecase(id: chatId),
      _messagesUseCase(chatId: chatId),
      _pusherUseCase((event) {
        _listenToMessages(event, chatId);
      })
    ]).then((results) {
      final chat = results[0] as Result<NewChat>;
      final messages = results[1] as Result<List<ChatMessage>>;
      if (chat.hasDataOnly && messages.hasDataOnly) {
        _messages = messages.data!;
        emit(state.copyWith(
            showChatMessagesState: BaseSuccessState({
          'chat': chat.data,
          'messages': _messages,
        })));
      } else {
        emit(state.copyWith(
            showChatMessagesState:
                BaseFailState(chat.error ?? messages.error!)));
        CustomSnackbar.showErrorSnackbar(chat.error ?? messages.error!);
      }
    });
  }

  final ISendMessageUseCase _send;
  void sendMessage({
    required int chatId,
    required String content,
    required ChatContentType contentType,
  }) {
    emit(state.copyWith(sendMessageState: const BaseLoadingState()));
    _send(chatId: chatId, content: content, contentType: contentType)
        .then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(sendMessageState: const BaseSuccessState()));
      } else {
        emit(state.copyWith(sendMessageState: BaseFailState(result.error)));
        Logger().d(result.error?.message);
        CustomSnackbar.showErrorSnackbar(result.error!);
      }
    });
  }

  void _listenToMessages(dynamic event, int chatId) {
    if (event != null && event.eventName == 'new-chat-message-$chatId') {
      Logger().d(event.toString());
      try {
        final message = ChatMessage.fromMap(json.decode(event.data)['message']);

        final currentData =
            (state.showChatMessagesState as BaseSuccessState).data;

        _messages.add(message);
        Logger().d('messages size : ${_messages.length}');
        emit(
          state.copyWith(
            showChatMessagesState: BaseSuccessState(
              {
                'chat': currentData['chat'],
                'messages': _messages,
              },
            ),
          ),
        );
      } catch (e) {
        Logger().d(e);
      }
    }
  }
}
