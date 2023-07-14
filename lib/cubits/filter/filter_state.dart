part of 'filter_cubit.dart';

@immutable
abstract class ConsultantsFilterState {
  final List<Major>? majors;
  final List<Country>? countries;
  const ConsultantsFilterState({this.majors, this.countries});
}

class ConsultantsFilterInitial extends ConsultantsFilterState {
  const ConsultantsFilterInitial();
}

class FilterLoading extends ConsultantsFilterState {
  const FilterLoading({super.majors, super.countries});
}

class ConsultantsFilterLoaded extends ConsultantsFilterState {
  final List<City>? cities;
  const ConsultantsFilterLoaded({
    required super.majors,
    required super.countries,
    this.cities,
  });
}

class ConsultantsFilterError extends ConsultantsFilterState {
  final String message;
  const ConsultantsFilterError(this.message, {super.majors, super.countries});
}
