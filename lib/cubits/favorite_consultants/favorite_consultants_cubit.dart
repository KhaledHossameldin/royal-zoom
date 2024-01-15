import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/consultants/favorite.dart';
import '../../data/models/favorite_category.dart';
import '../../data/services/repository.dart';

part 'favorite_consultants_state.dart';

class FavoriteConsultantsCubit extends Cubit<FavoriteConsultantsState> {
  FavoriteConsultantsCubit() : super(const FavoriteConsultantsInitial());

  final repository = Repository.instance;

  void toggleFavorite(int id) {
    final currentState = (state as FavoriteConsultantsLoaded);
    final consultants = currentState.consultants;
    int index =
        consultants.indexWhere((element) => element.consultant.id == id);
    consultants[index].consultant = consultants[index]
        .consultant
        .copyWith(isFavourite: !consultants[index].consultant.isFavourite);
    emit(FavoriteConsultantsLoaded(consultants, currentState.categories));
  }

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const FavoriteConsultantsLoading());
      final values = await Future.wait([
        repository.getFavoriteConsultants(context),
        repository.favoriteCategories(context, type: 'consultant'),
      ]);
      emit(FavoriteConsultantsLoaded(
        values[0] as List<FavoriteConsultant>,
        values[1] as List<FavoriteCategory>,
      ));
    } catch (e) {
      emit(FavoriteConsultantsError('$e'));
    }
  }
}
