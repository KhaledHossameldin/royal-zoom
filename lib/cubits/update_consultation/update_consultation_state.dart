part of 'update_consultation_cubit.dart';

@immutable
abstract class UpdateConsultationState {
  const UpdateConsultationState();
}

class UpdateConsultationInitial extends UpdateConsultationState {
  const UpdateConsultationInitial();
}

class UpdateConsultationLoading extends UpdateConsultationState {
  const UpdateConsultationLoading();
}

class UpdateConsultationLoaded extends UpdateConsultationState {
  const UpdateConsultationLoaded();
}

class UpdateConsultationError extends UpdateConsultationState {
  final String message;
  const UpdateConsultationError(this.message);
}
