import '../../../../../core/states/base_init_state.dart';
import '../../../../../core/states/base_states.dart';

class RegisterState {
  BaseState registerState;
  RegisterState({
    required this.registerState,
  });
  factory RegisterState.initState() =>
      RegisterState(registerState: BaseInitState());

  RegisterState copyWith({
    BaseState? registerState,
  }) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
    );
  }
}
