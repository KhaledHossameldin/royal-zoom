import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../data/enums/chat_content_type.dart';
import '../../data/enums/chat_resource_type.dart';
import '../../data/models/chat/chat.dart';
import '../../data/models/chat/chat_message.dart';
import '../../data/services/repository.dart';

part 'chat_messages_state.dart';

class ChatMessagesCubit extends Cubit<ChatMessagesState> {
  ChatMessagesCubit() : super(const ChatMessagesInitial());

  final repository = Repository.instance;

  Future<void> send(
    BuildContext context, {
    required ValueNotifier<bool> isSending,
    required String content,
    required ChatContentType type,
  }) async {
    try {
      isSending.value = true;
      final message = await repository.sendMessage(
        context,
        chatId: (state as ChatMessagesLoaded).chat.id,
        content: content,
        type: type,
      );
      final currentState = (state as ChatMessagesLoaded);
      emit(ChatMessagesLoaded(
          currentState.chat, [...currentState.messages, message]));
      isSending.value = false;
    } catch (e) {
      isSending.value = false;
    }
  }

  Future<void> fetch(
    BuildContext context, {
    required int id,
    required ChatResourceType type,
    Chat? chatt,
  }) async {
    // try {
    //   emit(const ChatMessagesLoading());
    //   final chat = (chatt != null)
    //       ? chatt
    //       : await repository.startChat(context, id: id, type: type);
    //   if (!context.mounted) {
    //     return;
    //   }
    //   final values = await Future.wait([
    //     repository.chatMessages(context, id: chat.id),
    //     repository.connect(
    //       chat.id,
    //       (event) {
    //         event as PusherEvent;
    //         if (event.eventName == 'new-chat-message-${chat.id}') {
    //           final message = ChatMessage.fromReceivedMap(
    //               json.decode(event.data)['message']);
    //           final currentState = (state as ChatMessagesLoaded);
    //           emit(ChatMessagesLoaded(
    //             currentState.chat,
    //             [...currentState.messages, message],
    //           ));
    //         }
    //       },
    //     ),
    //   ]);
    //   emit(ChatMessagesLoaded(chat, values[0] as List<ChatMessage>));
    // } catch (e) {
    //   emit(ChatMessagesError('$e'));
    // }
  }

  @override
  Future<void> close() {
    final chat = (state as ChatMessagesLoaded).chat;
    repository.disconnect(chat.id);
    return super.close();
  }
}
