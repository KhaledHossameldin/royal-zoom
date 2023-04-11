part of 'filter_cubit.dart';

@immutable
abstract class FilterState {
  final List<Major>? majors;
  final List<Country>? countries;
  const FilterState({this.majors, this.countries});
}

class FilterInitial extends FilterState {
  const FilterInitial();
}

class FilterLoading extends FilterState {
  const FilterLoading({super.majors, super.countries});
}

class FilterLoaded extends FilterState {
  final List<City>? cities;
  const FilterLoaded({
    required super.majors,
    required super.countries,
    this.cities,
  });
}

class FilterError extends FilterState {
  final String message;
  const FilterError(this.message, {super.majors, super.countries});
}
