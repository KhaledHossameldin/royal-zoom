part of 'switch_cubit.dart';

@immutable
abstract class SwitchState {
  const SwitchState();
}

class SwitchInitial extends SwitchState {
  const SwitchInitial();
}

class SwitchLoading extends SwitchState {
  const SwitchLoading();
}

class SwitchLoaded extends SwitchState {
  final UserData data;
  final UserType type;
  const SwitchLoaded({required this.data, required this.type});
}

class SwitchError extends SwitchState {
  final String message;
  final UserType? type;
  const SwitchError(this.message, {this.type});
}
