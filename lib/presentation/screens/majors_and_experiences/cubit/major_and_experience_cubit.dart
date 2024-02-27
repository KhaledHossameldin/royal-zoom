import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../data/models/consultants/update_consultant_major_body.dart';
import '../../../../data/models/consultants/verify_major_request_body.dart';
import '../../../../domain/usecases/change_consultant_major_status_usecase.dart';
import '../../../../domain/usecases/consultant_majors_usecase.dart';
import '../../../../domain/usecases/delete_consultant_major_usecase.dart';
import '../../../../domain/usecases/update_consultant_major_usecase.dart';
import '../../../../domain/usecases/verify_consultant_major_usecase.dart';
import 'major_and_experience_state.dart';

class MajorAndExperienceCubit extends Cubit<MajorAndExperienceState> {
  MajorAndExperienceCubit({
    required this.consultantMajorsUsecase,
    required this.verifyConsultantMajorUseCase,
    required this.changeConsultantMajorStatusUseCase,
    required this.updateConsultantMajorUseCase,
    required this.deleteConsultantMajorUseCase,
  }) : super(MajorAndExperienceState.initState());

  final IConsultantMajorsUsecase consultantMajorsUsecase;
  final IVerifyConsultantMajorUseCase verifyConsultantMajorUseCase;
  final IChangeConsultantMajorStatusUseCase changeConsultantMajorStatusUseCase;
  final IUpdateConsultantMajorUseCase updateConsultantMajorUseCase;
  final IDeleteConsultantMajorUseCase deleteConsultantMajorUseCase;
  void fetch() {
    emit(state.copyWith(
      majorAndExperiencesState: const BaseLoadingState(),
      changeStatusState: BaseInitState(),
      updateState: BaseInitState(),
      deleteState: BaseInitState(),
    ));
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
    verifyConsultantMajorUseCase(body: body).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(verifyMajorState: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(verifyMajorState: BaseFailState(result.error)));
      }
    });
  }

  void changeStatus({required int id, required bool isFree}) {
    emit(state.copyWith(changeStatusState: const BaseLoadingState()));
    changeConsultantMajorStatusUseCase(id: id, isFree: isFree).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(changeStatusState: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(changeStatusState: BaseFailState(result.error)));
      }
    });
  }

  void update({required UpdateConsultantMajorBody body}) {
    emit(state.copyWith(updateState: const BaseLoadingState()));
    updateConsultantMajorUseCase(body: body).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(updateState: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(updateState: BaseFailState(result.error)));
      }
    });
  }

  void delete({required int id}) {
    emit(state.copyWith(deleteState: const BaseLoadingState()));
    deleteConsultantMajorUseCase(id: id).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(deleteState: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(deleteState: BaseFailState(result.error)));
      }
    });
  }
}
