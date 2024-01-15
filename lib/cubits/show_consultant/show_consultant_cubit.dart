import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/consultants/details.dart';
import '../../data/services/repository.dart';

part 'show_consultant_state.dart';

class ShowConsultantCubit extends Cubit<ShowConsultantState> {
  ShowConsultantCubit() : super(const ShowConsultantInitial());

  final repository = Repository.instance;

  Future<void> fetch(BuildContext context, {required int id}) async {
    try {
      emit(const ShowConsultantLoading());
      final consultant = await repository.showConsultant(context, id: id);
      emit(ShowConsultantLoaded(consultant));
    } catch (e) {
      emit(ShowConsultantError('$e'));
    }
  }
}
