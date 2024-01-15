import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/chat/chat.dart';
import '../../data/services/repository.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(const ChatsInitial());

  final repository = Repository.instance;

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const ChatsLoading());
      final chats = await repository.chats(context);
      if (chats.isEmpty) {
        emit(const ChatsEmpty());
        return;
      }
      emit(ChatsLoaded(chats));
    } catch (e) {
      emit(ChatsError('$e'));
    }
  }
}
