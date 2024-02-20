import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../domain/usecases/default_majors_usecase.dart';
import 'major_and_experience_state.dart';

class MajorAndExperienceCubit extends Cubit<MajorAndExperienceState> {
  MajorAndExperienceCubit({required this.defaultMajorsUsecase})
      : super(MajorAndExperienceState.initState());

  final IDefaultMajorsUsecase defaultMajorsUsecase;
  void fetch() {
    emit(state.copyWith(majorAndExperiencesState: const BaseLoadingState()));
    defaultMajorsUsecase().then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(
          majorAndExperiencesState: BaseSuccessState(result.data),
        ));
      } else {
        emit(state.copyWith(
          majorAndExperiencesState: BaseFailState(result.error),
        ));
      }
    });
  }
}
