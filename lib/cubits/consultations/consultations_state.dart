part of 'consultations_cubit.dart';

@immutable
abstract class ConsultationsState {
  const ConsultationsState();
}

class ConsultationsInitial extends ConsultationsState {
  const ConsultationsInitial();
}

class ConsultationsLoading extends ConsultationsState {
  const ConsultationsLoading();
}

class ConsultationsLoaded extends ConsultationsState {
  final List<Consultation> consultations;
  final bool hasEndedScrolling;
  final bool canFetchMore;
  const ConsultationsLoaded(
    this.consultations, {
    this.hasEndedScrolling = false,
    this.canFetchMore = true,
  });
}

class ConsultationsEmpty extends ConsultationsState {
  const ConsultationsEmpty();
}

class ConsultationsError extends ConsultationsState {
  final String message;
  const ConsultationsError(this.message);
}
