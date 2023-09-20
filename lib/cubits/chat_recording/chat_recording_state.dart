part of 'chat_recording_cubit.dart';

@immutable
abstract class ChatRecordingState {
  const ChatRecordingState();
}

class ChatRecordingInitial extends ChatRecordingState {
  const ChatRecordingInitial();
}

class ChatRecordingWorking extends ChatRecordingState {
  final TickerProvider vsync;
  final ValueNotifier<int> seconds = ValueNotifier(0);
  ChatRecordingWorking({required this.vsync});
}
