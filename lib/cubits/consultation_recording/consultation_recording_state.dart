part of 'consultation_recording_cubit.dart';

@immutable
abstract class ConsultationRecordingState {
  const ConsultationRecordingState();
}

class ConsultationRecordingInitial extends ConsultationRecordingState {
  const ConsultationRecordingInitial();
}

class ConsultationRecordingStarted extends ConsultationRecordingState {
  const ConsultationRecordingStarted();
}

class ConsultationRecordingWorking extends ConsultationRecordingState {
  final TickerProvider vsync;
  final ValueNotifier<int> seconds = ValueNotifier(0);
  ConsultationRecordingWorking({required this.vsync});
}

class ConsultationRecordingEnded extends ConsultationRecordingState {
  final int seconds;
  const ConsultationRecordingEnded({required this.seconds});
}
