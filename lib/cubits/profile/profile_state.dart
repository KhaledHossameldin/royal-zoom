part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {
  final List<Country>? countries;
  const ProfileState({this.countries});
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading({super.countries});
}

class ProfileLoaded extends ProfileState {
  final List<City>? cities;
  const ProfileLoaded({required super.countries, this.cities});
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message, {super.countries});
}
