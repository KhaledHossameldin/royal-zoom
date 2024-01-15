import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/appointment_status.dart';
import '../../data/models/appointments/appointment.dart';
import '../../data/models/appointments/filter.dart';
import '../../data/services/repository.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(const AppointmentsInitial());

  final repository = Repository.instance;

  AppointmentFilter _filter = AppointmentFilter();

  DateTimeRange? get dateRange => _filter.dateRange;
  AppointmentStatus? get status => _filter.status;
  int? get consultantId => _filter.consultantId;
  int? get consultationId => _filter.consultationId;

  void clearFilter() => _filter = _filter.clear();

  void applyFilter({
    DateTimeRange? dateRange,
    AppointmentStatus? status,
    int? consultantId,
    int? consultationId,
  }) =>
      _filter = _filter.copyWith(
        dateRange: dateRange,
        status: status,
        consultantId: consultantId,
        consultationId: consultationId,
      );

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const AppointmentsLoading());
      final appointments = await repository.appointments(
        context,
        params: _filter.toMap(),
      );
      emit(AppointmentsLoaded(appointments));
    } catch (e) {
      emit(AppointmentsError('$e'));
    }
  }
}
