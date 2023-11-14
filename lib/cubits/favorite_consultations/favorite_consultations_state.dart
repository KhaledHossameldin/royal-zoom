part of 'favorite_consultations_cubit.dart';

@immutable
class FavoriteConsultationsState {
  const FavoriteConsultationsState();
}

class FavoriteConsultationsInitial extends FavoriteConsultationsState {
  const FavoriteConsultationsInitial();
}

class FavoriteConsultationsLoading extends FavoriteConsultationsState {
  const FavoriteConsultationsLoading();
}

class FavoriteConsultationsLoaded extends FavoriteConsultationsState {
  final List<FavoriteConsultation> consultations;
  const FavoriteConsultationsLoaded(this.consultations);
}

class FavoriteConsultationsError extends FavoriteConsultationsState {
  final String message;
  const FavoriteConsultationsError(this.message);
}
