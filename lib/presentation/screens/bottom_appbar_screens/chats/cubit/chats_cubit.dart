import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../core/states/base_wait_state.dart';
import '../../../../../domain/usecases/get_chats_usecase.dart';
import 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this._chatsUseCase) : super(ChatsState.initState());

  final IGetChatsUseCase _chatsUseCase;
  void showAllChats() {
    emit(state.copyWith(showAllChatsState: const BaseLoadingState()));
    _chatsUseCase().then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(showAllChatsState: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(showAllChatsState: BaseFailState(result.error)));
      }
    });
  }
}
