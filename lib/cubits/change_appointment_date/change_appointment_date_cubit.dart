import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/repository.dart';

part 'change_appointment_date_state.dart';

class ChangeAppointmentDateCubit extends Cubit<ChangeAppointmentDateState> {
  ChangeAppointmentDateCubit() : super(const ChangeAppointmentDateInitial());
  final repositroy = Repository.instance;

  Future<void> change(
    BuildContext context, {
    required int id,
    required String date,
  }) async {
    try {
      emit(const ChangeAppointmentDateLoading());
      final requestId = await repositroy.changeAppointmentDate(
        context,
        id: id,
        date: date,
      );
      emit(ChangeAppointmentDateLoaded(requestId));
    } catch (e) {
      emit(ChangeAppointmentDateError('$e'));
    }
  }
}
