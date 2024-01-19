import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../data/services/repository.dart';

part 'add_new_major_state.dart';

class AddNewMajorCubit extends Cubit<AddNewMajorState> {
  AddNewMajorCubit() : super(const AddNewMajorInitial());
  final repository = Repository.instance;

  Future<void> add(
    BuildContext context, {
    required int majorId,
    required bool isActive,
    required String yearsOfExperience,
    required String price,
    required String terms,
    required bool isNotificationsEnabled,
    required String name,
  }) async {
    try {
      emit(const AddNewMajorLoading());
      await repository.addNewMajorRequest(
        context,
        majorId: majorId,
        isActive: isActive,
        yearsOfExperience: yearsOfExperience,
        price: price,
        terms: terms,
        isNotificationsEnabled: isNotificationsEnabled,
        name: name,
      );
      emit(const AddNewMajorLoaded());
    } catch (e) {
      emit(AddNewMajorError('$e'));
    }
  }
}
