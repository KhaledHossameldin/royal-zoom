import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../data/models/consultants/verify_major_request_body.dart';
import '../../../../domain/usecases/consultant_majors_usecase.dart';
import 'major_and_experience_state.dart';

class MajorAndExperienceCubit extends Cubit<MajorAndExperienceState> {
  MajorAndExperienceCubit({required this.consultantMajorsUsecase})
      : super(MajorAndExperienceState.initState());

  final IConsultantMajorsUsecase consultantMajorsUsecase;
  void fetch() {
    emit(state.copyWith(majorAndExperiencesState: const BaseLoadingState()));
    consultantMajorsUsecase().then((result) {
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

  void verify({required VerifyRequestBody body}) {
    emit(state.copyWith(verifyMajorState: const BaseLoadingState()));
    consultantMajorsUsecase.verify(body: body).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(verifyMajorState: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(verifyMajorState: BaseFailState(result.error)));
      }
    });
  }
}
