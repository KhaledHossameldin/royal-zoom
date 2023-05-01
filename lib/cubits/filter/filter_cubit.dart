import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/authentication/city.dart';
import '../../data/models/authentication/country.dart';
import '../../data/models/major.dart';
import '../../data/services/repository.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterInitial());

  final repository = Repository.instance;

  Future<void> fetchCities(
    BuildContext context, {
    required int countryId,
  }) async {
    final currentState = state as FilterLoaded;
    emit(FilterLoading(
      majors: currentState.majors,
      countries: currentState.countries,
    ));
    final cities = await repository.cities(context, countryId: countryId);
    emit(FilterLoaded(
      majors: currentState.majors,
      countries: currentState.countries,
      cities: cities,
    ));
  }

  Future<void> fetch(BuildContext context, {int? countryId}) async {
    try {
      emit(const FilterLoading());
      final values = await Future.wait([
        repository.majors(context),
        repository.countries(context),
        if (countryId != null) repository.cities(context, countryId: countryId),
      ]);
      emit(FilterLoaded(
        majors: values[0] as List<Major>,
        countries: values[1] as List<Country>,
        cities: countryId != null ? values[2] as List<City> : null,
      ));
    } catch (e) {
      emit(FilterError('$e'));
    }
  }
}
