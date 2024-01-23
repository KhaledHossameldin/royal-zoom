import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/user_type.dart';
import '../../data/models/authentication/user_data.dart';
import '../../data/services/repository.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit({UserData? data, UserType? type})
      : super(data != null && type != null
            ? SwitchLoaded(data: data, type: type)
            : const SwitchInitial());

  final repository = Repository.instance;

  Future<void> convert(BuildContext context, {required UserType type}) async {
    UserType currentType = UserType.normal;
    if (state is SwitchError) {
      currentType = (state as SwitchError).type ?? type;
    }
    if (state is SwitchLoaded) {
      currentType = (state as SwitchLoaded).type;
    }
    try {
      emit(const SwitchLoading());
      final data = await repository.getProfileData(context, type: type);
      emit(SwitchLoaded(data: data, type: type));
    } catch (e) {
      emit(SwitchError('$e', type: currentType));
    }
  }

  Future<void> set({required UserData data, required UserType type}) async {
    emit(SwitchLoaded(data: data, type: type));
  }
}
