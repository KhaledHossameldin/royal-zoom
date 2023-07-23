import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/consultants/consultant.dart';
import '../../data/models/major.dart';
import '../../data/services/repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());

  final repository = Repository.instance;

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const SearchLoading());
      final result = await Future.wait([
        repository.majors(context),
        repository.consultants(context, params: {'my_consultant_only': '1'}),
      ]);
      emit(SearchLoaded(
        majors: result[0] as List<Major>,
        consultants: (result[1] as Map<String, Object>)['consultants']
            as List<Consultant>,
      ));
    } catch (e) {
      emit(SearchError('$e'));
    }
  }
}
