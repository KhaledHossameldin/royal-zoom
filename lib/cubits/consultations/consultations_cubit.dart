import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/consultation_status.dart';
import '../../data/models/consultations/consultation.dart';
import '../../data/models/consultations/consultations_filter.dart';
import '../../data/services/repository.dart';

part 'consultations_state.dart';

class ConsultationsCubit extends Cubit<ConsultationsState> {
  ConsultationsCubit() : super(const ConsultationsInitial());

  final repository = Repository.instance;

  ConsultationsFilter _filter = ConsultationsFilter();
  int _page = 1;

  ConsultationStatus? get status => _filter.status;
  DateTimeRange? get dateRange => _filter.dateRange;

  void clearFilters() => _filter.clear();

  void applyFilters({
    ConsultationStatus? status,
    DateTimeRange? dateRange,
    String? searchText,
  }) =>
      _filter = _filter.copyWith(
          status: status, dateRange: dateRange, searchText: searchText);

  Future<void> fetchMore(BuildContext context) async {
    final consultants = (state as ConsultationsLoaded).consultations;
    emit(ConsultationsLoaded(consultants, hasEndedScrolling: true));
    final response =
        await repository.consultations(context, params: _filter.toMap(_page));
    final newConsultants = response['consultations'] as List<Consultation>;
    final perPage = response['per_page'] as int;
    consultants.addAll(newConsultants);
    _page++;
    emit(ConsultationsLoaded(
      consultants,
      hasEndedScrolling: false,
      canFetchMore: newConsultants.length == perPage,
    ));
  }

  Future<void> fetch(BuildContext context) async {
    try {
      _page = 1;
      emit(const ConsultationsLoading());
      final response =
          await repository.consultations(context, params: _filter.toMap(_page));
      final consultations = response['consultations'] as List<Consultation>;
      final perPage = response['per_page'] as int;
      _page++;
      if (consultations.isEmpty) {
        emit(const ConsultationsEmpty());
        return;
      }
      emit(ConsultationsLoaded(
        consultations,
        canFetchMore: consultations.length == perPage,
      ));
    } catch (e) {
      emit(ConsultationsError('$e'));
    }
  }
}
