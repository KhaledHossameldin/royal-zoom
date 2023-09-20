import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/authentication/user.dart';
import '../../data/services/repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final repository = Repository.instance;

  User? get user {
    if (state is! AuthenticationLoaded) {
      return null;
    }
    return (state as AuthenticationLoaded).user;
  }

  AuthenticationBloc(User? user)
      : super(user == null
            ? const AuthenticationInitial(0)
            : AuthenticationLoaded(0, user: user)) {
    on<AuthenticationEvent>((event, emit) async {
      switch (event.runtimeType) {
        case AuthenticationLogout:
          await _logout(emit, event: event as AuthenticationLogout);
          break;

        case AuthenticationLogin:
          await _login(emit, event: event as AuthenticationLogin);
          break;

        case AuthenticationRegister:
          await _register(emit, event: event as AuthenticationRegister);
          break;

        case AuthenticationResend:
          await _resend(emit, event: event as AuthenticationResend);
          break;

        case AuthenticationActivate:
          await _activate(emit, event: event as AuthenticationActivate);
          break;
      }
    });
  }

  Future<void> _logout(
    Emitter<AuthenticationState> emit, {
    required AuthenticationLogout event,
  }) async {
    try {
      emit(const AuthenticationLoading(4));
      await repository.logout(event.context!);
      emit(const AuthenticationLoaded(4, user: null));
    } catch (e) {
      emit(AuthenticationError('$e', 4));
    }
  }

  Future<void> _activate(
    Emitter<AuthenticationState> emit, {
    required AuthenticationActivate event,
  }) async {
    try {
      emit(const AuthenticationLoading(2));
      final user = await repository.activate(
        event.context!,
        username: event.username,
        code: event.code,
      );
      emit(AuthenticationLoaded(2, user: user));
    } catch (e) {
      emit(AuthenticationError('$e', 2));
    }
  }

  Future<void> _resend(
    Emitter<AuthenticationState> emit, {
    required AuthenticationResend event,
  }) async {
    try {
      emit(const AuthenticationLoading(2, isResend: true));
      await repository.resendOTP(
        event.context!,
        username: event.username,
      );
      emit(const AuthenticationLoaded(2, isResend: true));
    } catch (e) {
      emit(AuthenticationError('$e', 2, isResend: true));
    }
  }

  Future<void> _register(
    Emitter<AuthenticationState> emit, {
    required AuthenticationRegister event,
  }) async {
    try {
      emit(const AuthenticationLoading(1));
      if (event.context!.mounted) {
        await repository.register(
          event.context!,
          username: event.username,
          password: event.password,
          confirm: event.confirm,
        );
        emit(const AuthenticationLoaded(1));
      }
    } catch (e) {
      emit(AuthenticationError('$e', 1));
    }
  }

  Future<void> _login(
    Emitter<AuthenticationState> emit, {
    required AuthenticationLogin event,
  }) async {
    try {
      emit(const AuthenticationLoading(0));
      if (event.context!.mounted) {
        final user = await repository.login(
          event.context!,
          username: event.username,
          password: event.password,
          isRemember: event.isRemember,
        );
        emit(AuthenticationLoaded(0, user: user));
      }
    } catch (e) {
      if (e.toString().startsWith('401')) {
        emit(AuthenticationError(e.toString().substring(3), 0, isOTP: true));
        return;
      }
      emit(AuthenticationError('$e', 0));
    }
  }
}
