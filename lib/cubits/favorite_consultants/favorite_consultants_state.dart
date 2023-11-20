part of 'favorite_consultants_cubit.dart';

@immutable
abstract class FavoriteConsultantsState {
  const FavoriteConsultantsState();
}

class FavoriteConsultantsInitial extends FavoriteConsultantsState {
  const FavoriteConsultantsInitial();
}

class FavoriteConsultantsLoading extends FavoriteConsultantsState {
  const FavoriteConsultantsLoading();
}

class FavoriteConsultantsLoaded extends FavoriteConsultantsState {
  final List<FavoriteConsultant> consultants;
  final List<FavoriteCategory> categories;
  const FavoriteConsultantsLoaded(this.consultants, this.categories);
}

class FavoriteConsultantsError extends FavoriteConsultantsState {
  final String message;
  const FavoriteConsultantsError(this.message);
}
