import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/consultants/available_time.dart';
import '../../data/services/repository.dart';
import '../../localization/app_localizations.dart';

part 'consultants_available_times_state.dart';

class ConsultantsAvailableTimesCubit
    extends Cubit<ConsultantsAvailableTimesState> {
  ConsultantsAvailableTimesCubit()
      : super(const ConsultantsAvailableTimesInitial());

  final Repository repository = Repository.instance;

  Future<void> fetch(BuildContext context, {required int? id}) async {
    try {
      if (id == null) {
        throw AppLocalizations.of(context).noConsultant;
      }
      emit(const ConsultantsAvailableTimesLoading());
      final times = await repository.consultantTimes(context, id: id);
      if (times.isEmpty) {
        emit(const ConsultantsAvailableTimesEmpty());
        return;
      }
      emit(ConsultantsAvailableTimesLoaded(times));
    } catch (e) {
      emit(ConsultantsAvailableTimesError('$e'));
    }
  }
}
