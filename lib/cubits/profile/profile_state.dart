part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {
  final List<Country>? countries;
  final List<Timezone>? timezones;
  final List<Currency>? currencies;
  final List<Language>? languages;
  const ProfileState({
    this.countries,
    this.timezones,
    this.currencies,
    this.languages,
  });
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading({
    super.timezones,
    super.countries,
    super.currencies,
    super.languages,
  });
}

class ProfileLoaded extends ProfileState {
  final List<City>? cities;
  const ProfileLoaded({
    required super.timezones,
    required super.countries,
    required super.currencies,
    required super.languages,
    this.cities,
  });
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(
    this.message, {
    super.timezones,
    super.countries,
    super.currencies,
    super.languages,
  });
}
