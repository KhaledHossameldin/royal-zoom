import '../../../../../core/states/base_init_state.dart';
import '../../../../../core/states/base_states.dart';

class LoginState {
  BaseState loginState;
  BaseState normalTypeState;
  BaseState consultantTypeState;
  LoginState(
      {required this.loginState,
      required this.normalTypeState,
      required this.consultantTypeState});
  factory LoginState.initState() => LoginState(
        loginState: BaseInitState(),
        normalTypeState: BaseInitState(),
        consultantTypeState: BaseInitState(),
      );
  LoginState copyWith({
    BaseState? loginState,
    BaseState? normalTypeState,
    BaseState? consultantTypeState,
  }) =>
      LoginState(
          loginState: loginState ?? this.loginState,
          normalTypeState: normalTypeState ?? this.normalTypeState,
          consultantTypeState: consultantTypeState ?? this.consultantTypeState);
}
