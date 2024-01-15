import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final repository = Repository.instance;
  ResetPasswordBloc() : super(const ResetPasswordInitial(0)) {
    on<ResetPasswordEvent>((event, emit) async {
      switch (event.runtimeType) {
        case ResetPasswordForget:
          await _forget(emit, event: event as ResetPasswordForget);
          break;

        case ResetPasswordOTP:
          await _checkOTP(emit, event: event as ResetPasswordOTP);
          break;

        case ResetPasswordReset:
          await _reset(emit, event: event as ResetPasswordReset);
          break;

        case ResetPasswordResend:
          await _resend(emit, event: event as ResetPasswordResend);
          break;
      }
    });
  }

  Future<void> _resend(
    Emitter<ResetPasswordState> emit, {
    required ResetPasswordResend event,
  }) async {
    try {
      emit(const ResetPasswordLoading(2, isResend: true));
      await repository.resendOTP(
        event.context,
        username: event.username,
      );
      emit(const ResetPasswordLoaded(2, isResend: true));
    } catch (e) {
      emit(ResetPasswordError('$e', 2, isResend: true));
    }
  }

  Future<void> _reset(
    Emitter<ResetPasswordState> emit, {
    required ResetPasswordReset event,
  }) async {
    try {
      emit(const ResetPasswordLoading(3));
      await repository.reset(
        event.context,
        username: event.username,
        code: event.code,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );
      emit(const ResetPasswordLoaded(3));
    } catch (e) {
      emit(ResetPasswordError('$e', 3));
    }
  }

  Future<void> _checkOTP(
    Emitter<ResetPasswordState> emit, {
    required ResetPasswordOTP event,
  }) async {
    try {
      emit(const ResetPasswordLoading(2));
      await repository.checkOTP(
        event.context,
        username: event.username,
        code: event.code,
      );
      emit(const ResetPasswordLoaded(2));
    } catch (e) {
      emit(ResetPasswordError('$e', 2));
    }
  }

  Future<void> _forget(
    Emitter<ResetPasswordState> emit, {
    required ResetPasswordForget event,
  }) async {
    try {
      emit(const ResetPasswordLoading(1));
      await repository.forgetPassword(event.context, username: event.username);
      emit(const ResetPasswordLoaded(1));
    } catch (e) {
      emit(ResetPasswordError('$e', 1));
    }
  }
}
