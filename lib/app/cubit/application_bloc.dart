import 'package:flutter_bloc/flutter_bloc.dart';

import 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState.initialState());

  Future<void> init() async {}
}
