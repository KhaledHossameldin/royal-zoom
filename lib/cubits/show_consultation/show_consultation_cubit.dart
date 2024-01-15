import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/models/consultations/details.dart';
import '../../data/services/repository.dart';

part 'show_consultation_state.dart';

class ShowConsultationCubit extends Cubit<ShowConsultationState> {
  ShowConsultationCubit() : super(const ShowConsultationInitial());

  final repository = Repository.instance;

  void toggleFavorite() {
    final consultation = (state as ShowConsultationLoaded).consultation;
    emit(ShowConsultationLoaded(consultation.copyWith(
      isFavourite: !consultation.isFavourite,
    )));
  }

  Future<void> fetch(
    BuildContext context, {
    required int id,
    required AudioPlayer? player,
  }) async {
    try {
      emit(const ShowConsultationLoading());
      final consultation = await repository.showConsultation(
        context,
        id: id,
        player: player,
      );
      emit(ShowConsultationLoaded(consultation));
    } catch (e) {
      emit(ShowConsultationError('$e'));
    }
  }
}
