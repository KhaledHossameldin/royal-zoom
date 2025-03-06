import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../data/enums/consultant_response_type.dart';
import '../../../../data/enums/consultation_content_type.dart';
import '../../../../domain/usecases/update_consultations.dart';
import 'edit_consultation_state.dart';

class EditConsultationCubit extends Cubit<EditConsultationState> {
  EditConsultationCubit(this._updateConsultation)
      : super(EditConsultationState.initState());

  final IUpdateConsultationUseCase _updateConsultation;
  void updateConsultation({
    required int id,
    required ConsultationContentType contentType,
    required ConsultantResponseType consultantResponseType,
    required String content,
  }) {
    emit(state.copyWith(sendUpdatedConsultation: const BaseLoadingState()));
    _updateConsultation(
            id: id,
            content: content,
            consultantResponseType: consultantResponseType,
            contentType: contentType)
        .then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(sendUpdatedConsultation: const BaseSuccessState()));
      } else {
        emit(state.copyWith(
            sendUpdatedConsultation: BaseFailState(result.error)));
      }
    });
  }
}
