part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {
  final bool? isResend;
  final int step;
  const AuthenticationState(this.step, {this.isResend = false});
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial(super.step, {super.isResend = false});
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading(super.step, {super.isResend = false});
}

class AuthenticationLoaded extends AuthenticationState {
  final User? user;
  const AuthenticationLoaded(super.step, {super.isResend = false, this.user});
}

class AuthenticationError extends AuthenticationState {
  final String message;
  final bool isOTP;
  const AuthenticationError(
    this.message,
    super.step, {
    super.isResend = false,
    this.isOTP = false,
  });
}
