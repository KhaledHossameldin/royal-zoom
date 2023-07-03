part of 'fast_consultation_cubit.dart';

@immutable
abstract class FastConsultationState {
  const FastConsultationState();
}

class FastConsultationInitial extends FastConsultationState {
  const FastConsultationInitial();
}

class FastConsultationSending extends FastConsultationState {
  const FastConsultationSending();
}

class FastConsultationSent extends FastConsultationState {
  const FastConsultationSent();
}

class FastConsultationError extends FastConsultationState {
  final String message;
  const FastConsultationError(this.message);
}
