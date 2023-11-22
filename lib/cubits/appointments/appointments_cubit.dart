import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/appointment.dart';
import '../../data/services/repository.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(const AppointmentsInitial());

  final repository = Repository.instance;

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const AppointmentsLoading());
      final appointments = await repository.appointments(context);
      emit(AppointmentsLoaded(appointments));
    } catch (e) {
      emit(AppointmentsError('$e'));
    }
  }
}
