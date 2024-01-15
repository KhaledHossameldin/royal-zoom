part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {
  final BuildContext? context;
  const AuthenticationEvent(this.context);
}

class AuthenticationLogout extends AuthenticationEvent {
  const AuthenticationLogout(super.context);
}

class AuthenticationLogin extends AuthenticationEvent {
  final String username;
  final String password;
  final bool isRemember;
  const AuthenticationLogin(
    super.context, {
    required this.username,
    required this.password,
    required this.isRemember,
  });
}

class AuthenticationRegister extends AuthenticationEvent {
  final String username;
  final String password;
  final String confirm;
  const AuthenticationRegister(
    super.context, {
    required this.username,
    required this.password,
    required this.confirm,
  });
}

class AuthenticationResend extends AuthenticationEvent {
  final String username;
  const AuthenticationResend(
    super.context, {
    required this.username,
  });
}

class AuthenticationActivate extends AuthenticationEvent {
  final String code;
  final String username;
  const AuthenticationActivate(
    super.context, {
    required this.username,
    required this.code,
  });
}
