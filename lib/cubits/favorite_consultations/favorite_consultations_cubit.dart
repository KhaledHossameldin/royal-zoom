import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/consultations/favorite.dart';
import '../../data/models/favorite_category.dart';
import '../../data/services/repository.dart';

part 'favorite_consultations_state.dart';

class FavoriteConsultationsCubit extends Cubit<FavoriteConsultationsState> {
  FavoriteConsultationsCubit() : super(const FavoriteConsultationsInitial());

  final repository = Repository.instance;

  void toggleFavorite(int id) {
    final currentState = (state as FavoriteConsultationsLoaded);
    final consultations = currentState.consultations;
    int index =
        consultations.indexWhere((element) => element.consultation.id == id);
    consultations[index].consultation = consultations[index]
        .consultation
        .copyWith(isFavourite: !consultations[index].consultation.isFavourite);
    emit(FavoriteConsultationsLoaded(consultations, currentState.categories));
  }

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const FavoriteConsultationsLoading());
      final values = await Future.wait([
        repository.getFavoriteConsultations(context),
        repository.favoriteCategories(context, type: 'consultation'),
      ]);
      emit(FavoriteConsultationsLoaded(values[0] as List<FavoriteConsultation>,
          values[1] as List<FavoriteCategory>));
    } catch (e) {
      emit(FavoriteConsultationsError('$e'));
    }
  }
}
