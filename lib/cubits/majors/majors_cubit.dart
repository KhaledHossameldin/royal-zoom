import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/major.dart';
import '../../data/services/repository.dart';

part 'majors_state.dart';

class MajorsCubit extends Cubit<MajorsState> {
  MajorsCubit() : super(const MajorsInitial());

  final repository = Repository.instance;

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const MajorsLoading());
      final majors = await repository.majors(context);
      emit(MajorsLoaded(majors));
    } catch (e) {
      emit(MajorsError('$e'));
    }
  }
}
