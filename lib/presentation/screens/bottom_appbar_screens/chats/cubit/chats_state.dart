import '../../../../../core/states/base_init_state.dart';
import '../../../../../core/states/base_states.dart';

class ChatsState {
  BaseState showAllChatsState;
  BaseState showChatMessagesState;

  ChatsState({
    required this.showAllChatsState,
    required this.showChatMessagesState,
  });

  factory ChatsState.initState() => ChatsState(
        showAllChatsState: BaseInitState(),
        showChatMessagesState: BaseInitState(),
      );

  ChatsState copyWith({
    BaseState? showAllChatsState,
    BaseState? showChatMessagesState,
  }) {
    return ChatsState(
      showAllChatsState: showAllChatsState ?? this.showAllChatsState,
      showChatMessagesState:
          showChatMessagesState ?? this.showChatMessagesState,
    );
  }
}
