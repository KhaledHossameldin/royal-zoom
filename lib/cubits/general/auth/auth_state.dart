import '../../../core/states/base_init_state.dart';
import '../../../core/states/base_states.dart';

class AuthState {
  BaseState registerState;
  AuthState({
    required this.registerState,
  });
  factory AuthState.initState() => AuthState(registerState: BaseInitState());

  AuthState copyWith({
    BaseState? registerState,
  }) {
    return AuthState(
      registerState: registerState ?? this.registerState,
    );
  }
}
