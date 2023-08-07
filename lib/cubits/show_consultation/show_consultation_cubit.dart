import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/consultations/details.dart';
import '../../data/services/repository.dart';

part 'show_consultation_state.dart';

class ShowConsultationCubit extends Cubit<ShowConsultationState> {
  ShowConsultationCubit() : super(const ShowConsultationInitial());

  final repository = Repository.instance;

  Future<void> fetch(
    BuildContext context, {
    required int id,
  }) async {
    try {
      emit(const ShowConsultationLoading());
      final consultation = await repository.showConsultation(context, id: id);
      emit(ShowConsultationLoaded(consultation));
    } catch (e) {
      emit(ShowConsultationError('$e'));
    }
  }
}
