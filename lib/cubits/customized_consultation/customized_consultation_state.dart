part of 'customized_consultation_cubit.dart';

@immutable
abstract class CustomizedConsultationState {
  const CustomizedConsultationState();
}

class CustomizedConsultationInitial extends CustomizedConsultationState {
  const CustomizedConsultationInitial();
}

class CustomizedConsultationSending extends CustomizedConsultationState {
  const CustomizedConsultationSending();
}

class CustomizedConsultationSent extends CustomizedConsultationState {
  final int id;
  const CustomizedConsultationSent(this.id);
}

class CustomizedConsultationError extends CustomizedConsultationState {
  final String message;
  const CustomizedConsultationError(this.message);
}
