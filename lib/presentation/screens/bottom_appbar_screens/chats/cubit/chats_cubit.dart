import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../../core/results/result.dart';
import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../core/states/base_wait_state.dart';
import '../../../../../core/utils/ui/snackbar/custom_snack_bar.dart';
import '../../../../../domain/usecases/get_chat_messages_usecase.dart';
import '../../../../../domain/usecases/get_chat_usecase.dart';
import '../../../../../domain/usecases/get_chats_usecase.dart';
import 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this._chatsUseCase, this._chatUsecase, this._messagesUseCase)
      : super(ChatsState.initState());

  final IGetChatsUseCase _chatsUseCase;
  void showAllChats() {
    emit(state.copyWith(showAllChatsState: const BaseLoadingState()));
    _chatsUseCase().then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(showAllChatsState: BaseSuccessState(result.data)));
      } else {
        Logger().d(result.error?.message);
        emit(state.copyWith(showAllChatsState: BaseFailState(result.error)));
      }
    });
  }

  final IGetChatUseCase _chatUsecase;
  final IGetChatMessagesUseCase _messagesUseCase;
  void showChatMessages(int chatId) {
    emit(state.copyWith(showChatMessagesState: const BaseLoadingState()));
    Future.wait<Result<dynamic>>([
      _chatUsecase(id: chatId),
      _messagesUseCase(chatId: chatId),
    ]).then((results) {
      if (results[0].hasDataOnly && results[1].hasDataOnly) {
        emit(state.copyWith(
            showChatMessagesState: BaseSuccessState({
          'chat': results[0].data,
          'messages': results[1].data,
        })));
      } else {
        Logger().d(results[0].error?.message);
        Logger().d(results[1].error?.message);
        emit(state.copyWith(
            showChatMessagesState:
                BaseFailState(results[0].error ?? results[1].error!)));
        CustomSnackbar.showErrorSnackbar(results[0].error ?? results[1].error!);
      }
    });
  }
}
