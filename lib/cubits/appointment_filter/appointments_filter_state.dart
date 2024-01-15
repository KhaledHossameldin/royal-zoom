part of 'appointments_filter_cubit.dart';

@immutable
abstract class AppointmentsFilterState {
  const AppointmentsFilterState();
}

class AppointmentsFilterInitial extends AppointmentsFilterState {
  const AppointmentsFilterInitial();
}

class AppointmentsFilterLoading extends AppointmentsFilterState {
  const AppointmentsFilterLoading();
}

class AppointmentsFilterLoaded extends AppointmentsFilterState {
  final List<Consultant> consultants;
  final List<Consultation> consultations;
  const AppointmentsFilterLoaded(this.consultants, this.consultations);
}

class AppointmentsFilterError extends AppointmentsFilterState {
  final String message;
  const AppointmentsFilterError(this.message);
}
