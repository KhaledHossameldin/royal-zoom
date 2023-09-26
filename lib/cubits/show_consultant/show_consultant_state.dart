part of 'show_consultant_cubit.dart';

@immutable
abstract class ShowConsultantState {
  const ShowConsultantState();
}

class ShowConsultantInitial extends ShowConsultantState {
  const ShowConsultantInitial();
}

class ShowConsultantLoading extends ShowConsultantState {
  const ShowConsultantLoading();
}

class ShowConsultantLoaded extends ShowConsultantState {
  final ConsultantDetails consultant;
  const ShowConsultantLoaded(this.consultant);
}

class ShowConsultantError extends ShowConsultantState {
  final String message;
  const ShowConsultantError(this.message);
}
