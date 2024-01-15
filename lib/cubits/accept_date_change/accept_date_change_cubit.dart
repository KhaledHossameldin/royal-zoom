import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/repository.dart';

part 'accept_date_change_state.dart';

class DateChangeCubit extends Cubit<DateChangeState> {
  DateChangeCubit() : super(const DateChangeInitial());

  final repository = Repository.instance;

  Future<void> accept(BuildContext context, {required int id}) async {
    try {
      emit(const DateChangeAccepting());
      await repository.acceptChangeTimeRequest(context, id: id);
      emit(const DateChangeAccepted());
    } catch (e) {
      emit(DateChangeError('$e'));
    }
  }

  Future<void> reject(BuildContext context, {required int id}) async {
    try {
      emit(const DateChangeRejecting());
      await repository.acceptChangeTimeRequest(context, id: id);
      emit(const DateChangeRejected());
    } catch (e) {
      emit(DateChangeError('$e'));
    }
  }
}
