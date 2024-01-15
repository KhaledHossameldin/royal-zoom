part of 'appointments_cubit.dart';

@immutable
abstract class AppointmentsState {
  const AppointmentsState();
}

class AppointmentsInitial extends AppointmentsState {
  const AppointmentsInitial();
}

class AppointmentsLoading extends AppointmentsState {
  const AppointmentsLoading();
}

class AppointmentsLoaded extends AppointmentsState {
  final List<Appointment> appointments;
  const AppointmentsLoaded(this.appointments);
}

class AppointmentsError extends AppointmentsState {
  final String message;
  const AppointmentsError(this.message);
}
