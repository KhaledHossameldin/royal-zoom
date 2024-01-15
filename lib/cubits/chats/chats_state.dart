part of 'chats_cubit.dart';

@immutable
abstract class ChatsState {
  const ChatsState();
}

class ChatsInitial extends ChatsState {
  const ChatsInitial();
}

class ChatsLoading extends ChatsState {
  const ChatsLoading();
}

class ChatsLoaded extends ChatsState {
  final List<Chat> chats;
  const ChatsLoaded(this.chats);
}

class ChatsEmpty extends ChatsState {
  const ChatsEmpty();
}

class ChatsError extends ChatsState {
  final String message;
  const ChatsError(this.message);
}
