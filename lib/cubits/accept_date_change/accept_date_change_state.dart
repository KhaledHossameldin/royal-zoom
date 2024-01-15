part of 'accept_date_change_cubit.dart';

@immutable
abstract class DateChangeState {
  const DateChangeState();
}

class DateChangeInitial extends DateChangeState {
  const DateChangeInitial();
}

class DateChangeAccepting extends DateChangeState {
  const DateChangeAccepting();
}

class DateChangeAccepted extends DateChangeState {
  const DateChangeAccepted();
}

class DateChangeRejecting extends DateChangeState {
  const DateChangeRejecting();
}

class DateChangeRejected extends DateChangeState {
  const DateChangeRejected();
}

class DateChangeError extends DateChangeState {
  final String message;
  const DateChangeError(this.message);
}
