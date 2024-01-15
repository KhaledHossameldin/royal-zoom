part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final HomeStatistics statistics;
  final List<Consultation> consultations;
  const HomeLoaded({required this.statistics, required this.consultations});
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
