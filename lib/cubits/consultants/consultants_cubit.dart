import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/consultants/consultant.dart';
import '../../data/models/consultants/filters.dart';
import '../../data/services/repository.dart';

part 'consultants_state.dart';

class ConsultantsCubit extends Cubit<ConsultantsState> {
  ConsultantsCubit() : super(const ConsultantsInitial());

  final repository = Repository.instance;

  ConsultantsFilter _filter = ConsultantsFilter();
  int _page = 1;

  int? get majorId => _filter.majorId;
  int? get countryId => _filter.countryId;
  int? get cityId => _filter.cityId;

  void clearFilter() => _filter = _filter.clear();

  void applyFilter({
    int? majorId,
    int? countryId,
    int? cityId,
    String? searchKey,
  }) =>
      _filter = _filter.copyWith(
        majorId: majorId,
        countryId: countryId,
        cityId: cityId,
        searchKey: searchKey,
      );

  Future<void> fetchMore(BuildContext context) async {
    final consultants = (state as ConsultantsLoaded).consultants;
    emit(ConsultantsLoaded(consultants, hasEndedScrolling: true));
    final response = await repository.consultants(
      context,
      filter: _filter,
      page: _page,
    );
    final newConsultants = response['consultants'] as List<Consultant>;
    final perPage = response['per_page'] as int;
    consultants.addAll(newConsultants);
    _page++;
    emit(ConsultantsLoaded(
      consultants,
      hasEndedScrolling: false,
      canFetchMore: newConsultants.length == perPage,
    ));
  }

  Future<void> fetch(BuildContext context) async {
    try {
      _page = 1;
      emit(const ConsultantsLoading());
      final response = await repository.consultants(
        context,
        filter: _filter,
        page: _page,
      );
      final consultants = response['consultants'] as List<Consultant>;
      final perPage = response['per_page'] as int;
      _page++;
      if (consultants.isEmpty) {
        emit(const ConsultantsEmpty());
        return;
      }
      emit(ConsultantsLoaded(
        consultants,
        canFetchMore: consultants.length == perPage,
      ));
    } catch (e) {
      emit(ConsultantsError('$e'));
    }
  }
}
