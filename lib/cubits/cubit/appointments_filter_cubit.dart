import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/consultants/consultant.dart';
import '../../data/models/consultations/consultation.dart';
import '../../data/services/repository.dart';

part 'appointments_filter_state.dart';

class AppointmentsFilterCubit extends Cubit<AppointmentsFilterState> {
  AppointmentsFilterCubit() : super(const AppointmentsFilterInitial());

  final repository = Repository.instance;

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const AppointmentsFilterLoading());
      final values = await Future.wait([
        repository.allConsultants(context),
        repository.allConsultations(context),
      ]);
      emit(AppointmentsFilterLoaded(
        values[0] as List<Consultant>,
        values[1] as List<Consultation>,
      ));
    } catch (e) {
      emit(AppointmentsFilterError('$e'));
    }
  }
}
