part of 'send_comment_cubit.dart';

@immutable
abstract class SendCommentState {
  const SendCommentState();
}

class SendCommentInitial extends SendCommentState {
  const SendCommentInitial();
}

class SendCommentLoading extends SendCommentState {
  const SendCommentLoading();
}

class SendCommentLoaded extends SendCommentState {
  const SendCommentLoaded();
}

class SendCommentError extends SendCommentState {
  final String message;
  const SendCommentError(this.message);
}
