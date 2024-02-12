import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../core/states/base_wait_state.dart';
import '../../../../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginState.initState());

  final ILoginUseCase loginUseCase;
  void login(String username, String password) {
    emit(state.copyWith(loginState: const BaseLoadingState()));
    loginUseCase(username: username, password: password).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(loginState: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(loginState: BaseFailState(result.error)));
      }
    });
  }
}
