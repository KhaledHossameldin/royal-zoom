import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../core/states/base_wait_state.dart';
import '../../../../../data/enums/user_type.dart';
import '../../../../../domain/usecases/login_usecase.dart';
import '../../../../../domain/usecases/profile_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase, this.profileUseCase)
      : super(LoginState.initState());

  final ILoginUseCase loginUseCase;
  void login(String username, String password, bool isRemember) {
    emit(state.copyWith(loginState: const BaseLoadingState()));
    loginUseCase(username: username, password: password, isRemember: isRemember)
        .then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(loginState: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(loginState: BaseFailState(result.error)));
      }
    });
  }

  final IProfileUseCase profileUseCase;
  void noramlLoginType() {
    emit(state.copyWith(normalTypeState: const BaseLoadingState()));
    profileUseCase(UserType.normal).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(normalTypeState: const BaseSuccessState()));
      } else {
        emit(state.copyWith(normalTypeState: BaseFailState(result.error)));
      }
    });
  }

  void consultantLoginType() {
    emit(state.copyWith(consultantTypeState: const BaseLoadingState()));
    profileUseCase(UserType.consultant).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(consultantTypeState: const BaseSuccessState()));
      } else {
        emit(state.copyWith(consultantTypeState: BaseFailState(result.error)));
      }
    });
  }
}
