import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../data/services/repository.dart';

part 'send_comment_state.dart';

class SendCommentCubit extends Cubit<SendCommentState> {
  SendCommentCubit() : super(const SendCommentInitial());

  final repository = Repository.instance;

  Future<void> send(
    BuildContext context, {
    required int id,
    required String comment,
  }) async {
    try {
      emit(const SendCommentLoading());
      await repository.addConsultationComment(
        context,
        id: id,
        comment: comment,
      );
      emit(const SendCommentLoaded());
    } catch (e) {
      emit(SendCommentError('$e'));
    }
  }
}
