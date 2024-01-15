part of 'change_appointment_date_cubit.dart';

@immutable
abstract class ChangeAppointmentDateState {
  const ChangeAppointmentDateState();
}

class ChangeAppointmentDateInitial extends ChangeAppointmentDateState {
  const ChangeAppointmentDateInitial();
}

class ChangeAppointmentDateLoading extends ChangeAppointmentDateState {
  const ChangeAppointmentDateLoading();
}

class ChangeAppointmentDateLoaded extends ChangeAppointmentDateState {
  final int id;
  const ChangeAppointmentDateLoaded(this.id);
}

class ChangeAppointmentDateError extends ChangeAppointmentDateState {
  final String message;
  const ChangeAppointmentDateError(this.message);
}
