import '../../../../../core/states/base_init_state.dart';
import '../../../../../core/states/base_states.dart';

class ChatsState {
  BaseState showAllChatsState;
  ChatsState({
    required this.showAllChatsState,
  });

  factory ChatsState.initState() =>
      ChatsState(showAllChatsState: BaseInitState());

  ChatsState copyWith({BaseState? showAllChatsState}) {
    return ChatsState(
        showAllChatsState: showAllChatsState ?? this.showAllChatsState);
  }
}
