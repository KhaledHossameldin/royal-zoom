import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/repository.dart';

part 'cancel_consultation_state.dart';

class CancelConsultationCubit extends Cubit<CancelConsultationState> {
  CancelConsultationCubit() : super(const CancelConsultationInitial());

  final repository = Repository.instance;

  Future<void> cancel(
    BuildContext context, {
    required int id,
  }) async {
    try {
      emit(const CancelConsultationCancelling());
      await repository.cancelConsultation(context, id: id);
      emit(const CancelConsultationCanceled());
    } catch (e) {
      emit(CancelConsultationError('$e'));
    }
  }
}
