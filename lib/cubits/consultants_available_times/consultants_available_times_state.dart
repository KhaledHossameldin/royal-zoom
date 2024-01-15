part of 'consultants_available_times_cubit.dart';

@immutable
abstract class ConsultantsAvailableTimesState {
  const ConsultantsAvailableTimesState();
}

class ConsultantsAvailableTimesInitial extends ConsultantsAvailableTimesState {
  const ConsultantsAvailableTimesInitial();
}

class ConsultantsAvailableTimesLoading extends ConsultantsAvailableTimesState {
  const ConsultantsAvailableTimesLoading();
}

class ConsultantsAvailableTimesLoaded extends ConsultantsAvailableTimesState {
  final Map<String, List<ConsultantAvailableTime>> times;
  const ConsultantsAvailableTimesLoaded(this.times);
}

class ConsultantsAvailableTimesEmpty extends ConsultantsAvailableTimesState {
  const ConsultantsAvailableTimesEmpty();
}

class ConsultantsAvailableTimesError extends ConsultantsAvailableTimesState {
  final String message;
  const ConsultantsAvailableTimesError(this.message);
}
