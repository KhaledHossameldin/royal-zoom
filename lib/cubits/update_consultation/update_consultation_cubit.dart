import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/consultant_response_type.dart';
import '../../data/services/repository.dart';

part 'update_consultation_state.dart';

class UpdateConsultationCubit extends Cubit<UpdateConsultationState> {
  UpdateConsultationCubit() : super(const UpdateConsultationInitial());

  final repository = Repository.instance;

  Future<void> update(
    BuildContext context, {
    required int id,
    required ConsultantResponseType responseType,
  }) async {
    try {
      emit(const UpdateConsultationLoading());
      await repository.updateConsultation(
        context,
        id: id,
        responseType: responseType,
      );
      emit(const UpdateConsultationLoaded());
    } catch (e) {
      emit(UpdateConsultationError('$e'));
    }
  }
}
