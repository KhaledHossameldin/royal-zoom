import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/consultant_response_type.dart';
import '../../data/enums/consultation_status.dart';
import '../../data/models/consultants/consultant.dart';
import '../../data/models/consultations/consultation.dart';
import '../../data/models/consultations/consultations_filter.dart';
import '../../data/services/repository.dart';

part 'consultations_state.dart';

class ConsultationsCubit extends Cubit<ConsultationsState> {
  ConsultationsCubit() : super(const ConsultationsInitial());

  final repository = Repository.instance;

  ConsultationsFilter _filter = ConsultationsFilter();
  int _page = 1;

  ConsultationStatus? get firstStatus => _filter.status?[0];
  DateTimeRange? get dateRange => _filter.dateRange;

  void toggleFavorite(int id) {
    final currentState = (state as ConsultationsLoaded);
    final currentConsultations = currentState.consultations;
    int index = currentConsultations.indexWhere((element) => element.id == id);
    currentConsultations[index] = currentConsultations[index]
        .copyWith(isFavourite: !currentConsultations[index].isFavourite);
    emit(ConsultationsLoaded(
      currentConsultations,
      canFetchMore: currentState.canFetchMore,
      hasEndedScrolling: currentState.hasEndedScrolling,
    ));
  }

  void clearFilters() => _filter.clear();

  void applyFilters({
    List<ConsultationStatus>? status,
    DateTimeRange? dateRange,
    String? searchText,
    int? mainMajorId,
    int? subMajorId,
    List<Consultant>? consultants,
    List<ConsultantResponseType>? responseTypes,
    bool? isPaid,
    ConsultationsFilter? filter,
  }) {
    if (filter != null) {
      _filter = filter;
      return;
    }
    _filter = _filter.copyWith(
      status: status,
      dateRange: dateRange,
      searchText: searchText,
      mainMajorId: mainMajorId,
      subMajorId: subMajorId,
      consultants: consultants,
      responseTypes: responseTypes,
      isPaid: isPaid,
    );
  }

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
