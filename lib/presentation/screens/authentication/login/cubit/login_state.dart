import '../../../../../core/states/base_init_state.dart';
import '../../../../../core/states/base_states.dart';

class LoginState {
  BaseState loginState;
  LoginState({required this.loginState});
  factory LoginState.initState() => LoginState(loginState: BaseInitState());
  LoginState copyWith({BaseState? loginState}) =>
      LoginState(loginState: loginState ?? this.loginState);
}
