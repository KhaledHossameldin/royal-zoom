part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordState {
  final bool? isResend;
  final int step;
  const ResetPasswordState(this.step, {this.isResend = false});
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial(super.step, {super.isResend = false});
}

class ResetPasswordLoading extends ResetPasswordState {
  const ResetPasswordLoading(super.step, {super.isResend = false});
}

class ResetPasswordLoaded extends ResetPasswordState {
  const ResetPasswordLoaded(super.step, {super.isResend = false});
}

class ResetPasswordError extends ResetPasswordState {
  final String message;
  const ResetPasswordError(this.message, super.step, {super.isResend = false});
}
