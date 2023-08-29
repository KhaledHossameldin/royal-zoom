import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/consultations/consultation.dart';
import '../../data/models/home_statistics.dart';
import '../../data/services/repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  final repository = Repository.instance;

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const HomeLoading());
      final values = await Future.wait([
        repository.homeStatistics(context),
        repository.lastConsultations(context),
      ]);
      emit(HomeLoaded(
        statistics: values[0] as HomeStatistics,
        consultations: values[1] as List<Consultation>,
      ));
    } catch (e) {
      emit(HomeError('$e'));
    }
  }
}
