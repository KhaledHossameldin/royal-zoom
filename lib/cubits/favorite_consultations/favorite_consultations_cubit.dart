import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/consultations/favorite.dart';
import '../../data/services/repository.dart';

part 'favorite_consultations_state.dart';

class FavoriteConsultationsCubit extends Cubit<FavoriteConsultationsState> {
  FavoriteConsultationsCubit() : super(const FavoriteConsultationsInitial());

  final repository = Repository.instance;

  void toggleFavorite(int id) {
    final consultations = (state as FavoriteConsultationsLoaded).consultations;
    int index =
        consultations.indexWhere((element) => element.consultation.id == id);
    consultations[index].consultation = consultations[index]
        .consultation
        .copyWith(isFavourite: !consultations[index].consultation.isFavourite);
    emit(FavoriteConsultationsLoaded(consultations));
  }

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const FavoriteConsultationsLoading());
      final consultations = await repository.getFavoriteConsultations(context);
      emit(FavoriteConsultationsLoaded(consultations));
    } catch (e) {
      emit(FavoriteConsultationsError('$e'));
    }
  }
}
