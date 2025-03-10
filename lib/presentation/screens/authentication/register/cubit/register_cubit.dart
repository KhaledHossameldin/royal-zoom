import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../core/states/base_wait_state.dart';
import '../../../../../domain/usecases/register_usecase.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.registerUsecase})
      : super(RegisterState.initState());

  final IRegisterUsecase registerUsecase;
  void register(
      {required String username,
      required String password,
      required String confirm}) {
    emit(state.copyWith(registerState: const BaseLoadingState()));
    registerUsecase(username: username, password: password, confirm: confirm)
        .then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(registerState: const BaseSuccessState()));
      } else {
        emit(state.copyWith(registerState: BaseFailState(result.error)));
      }
    });
  }
}
