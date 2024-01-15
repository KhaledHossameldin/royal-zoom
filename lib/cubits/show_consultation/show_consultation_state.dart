part of 'show_consultation_cubit.dart';

@immutable
abstract class ShowConsultationState {
  const ShowConsultationState();
}

class ShowConsultationInitial extends ShowConsultationState {
  const ShowConsultationInitial();
}

class ShowConsultationLoading extends ShowConsultationState {
  const ShowConsultationLoading();
}

class ShowConsultationLoaded extends ShowConsultationState {
  final ConsultationDetails consultation;
  const ShowConsultationLoaded(this.consultation);
}

class ShowConsultationError extends ShowConsultationState {
  final String message;
  const ShowConsultationError(this.message);
}
