part of 'consultants_cubit.dart';

@immutable
abstract class ConsultantsState {
  const ConsultantsState();
}

class ConsultantsInitial extends ConsultantsState {
  const ConsultantsInitial();
}

class ConsultantsLoading extends ConsultantsState {
  const ConsultantsLoading();
}

class ConsultantsLoaded extends ConsultantsState {
  final List<Consultant> consultants;
  final bool hasEndedScrolling;
  final bool canFetchMore;
  const ConsultantsLoaded(
    this.consultants, {
    this.hasEndedScrolling = false,
    this.canFetchMore = true,
  });
}

class ConsultantsEmpty extends ConsultantsState {
  const ConsultantsEmpty();
}

class ConsultantsError extends ConsultantsState {
  final String message;
  const ConsultantsError(this.message);
}
