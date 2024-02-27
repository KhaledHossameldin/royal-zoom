import '../../../../../core/states/base_init_state.dart';
import '../../../../../core/states/base_states.dart';

class ChatsState {
  BaseState showAllChatsState;
  BaseState showChatMessagesState;
  BaseState sendMessageState;

  ChatsState({
    required this.showAllChatsState,
    required this.showChatMessagesState,
    required this.sendMessageState,
  });

  factory ChatsState.initState() => ChatsState(
        showAllChatsState: BaseInitState(),
        showChatMessagesState: BaseInitState(),
        sendMessageState: BaseInitState(),
      );

  ChatsState copyWith({
    BaseState? showAllChatsState,
    BaseState? showChatMessagesState,
    BaseState? sendMessageState,
  }) {
    return ChatsState(
      showAllChatsState: showAllChatsState ?? this.showAllChatsState,
      showChatMessagesState:
          showChatMessagesState ?? this.showChatMessagesState,
      sendMessageState: sendMessageState ?? this.sendMessageState,
    );
  }
}
