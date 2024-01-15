part of 'chat_messages_cubit.dart';

@immutable
abstract class ChatMessagesState {
  const ChatMessagesState();
}

class ChatMessagesInitial extends ChatMessagesState {
  const ChatMessagesInitial();
}

class ChatMessagesLoading extends ChatMessagesState {
  const ChatMessagesLoading();
}

class ChatMessagesLoaded extends ChatMessagesState {
  final Chat chat;
  final List<ChatMessage> messages;
  const ChatMessagesLoaded(this.chat, this.messages);
}

class ChatMessagesError extends ChatMessagesState {
  final String message;
  const ChatMessagesError(this.message);
}
