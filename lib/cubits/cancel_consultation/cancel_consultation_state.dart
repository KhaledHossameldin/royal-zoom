part of 'cancel_consultation_cubit.dart';

@immutable
abstract class CancelConsultationState {
  const CancelConsultationState();
}

class CancelConsultationInitial extends CancelConsultationState {
  const CancelConsultationInitial();
}

class CancelConsultationCancelling extends CancelConsultationState {
  const CancelConsultationCancelling();
}

class CancelConsultationCanceled extends CancelConsultationState {
  const CancelConsultationCanceled();
}

class CancelConsultationError extends CancelConsultationState {
  final String message;
  const CancelConsultationError(this.message);
}
