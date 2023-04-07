part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordEvent {
  const ResetPasswordEvent();
}

class ResetPasswordForget extends ResetPasswordEvent {
  final BuildContext context;
  final String username;
  const ResetPasswordForget(this.context, {required this.username});
}

class ResetPasswordResend extends ResetPasswordEvent {
  final BuildContext context;
  final String username;
  const ResetPasswordResend(this.context, {required this.username});
}

class ResetPasswordOTP extends ResetPasswordForget {
  final String code;
  const ResetPasswordOTP(
    super.context, {
    required super.username,
    required this.code,
  });
}

class ResetPasswordReset extends ResetPasswordOTP {
  final String newPassword;
  final String confirmPassword;
  const ResetPasswordReset(
    super.context, {
    required super.username,
    required super.code,
    required this.newPassword,
    required this.confirmPassword,
  });
}
