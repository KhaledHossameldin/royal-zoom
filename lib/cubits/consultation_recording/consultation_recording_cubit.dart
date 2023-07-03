import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'consultation_recording_state.dart';

class ConsultationRecordingCubit extends Cubit<ConsultationRecordingState> {
  ConsultationRecordingCubit() : super(const ConsultationRecordingInitial());

  Timer? timer;
  final record = Record();
  String? recordPath;
  final player = AudioPlayer();

  Future<void> start({required TickerProvider vsync}) async {
    final path = await getTemporaryDirectory();
    recordPath = '${path.path}/record.mp4';
    if (await record.hasPermission()) {
      record.start(path: recordPath);
    }
    emit(ConsultationRecordingWorking(vsync: vsync));
    final currentState = state as ConsultationRecordingWorking;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentState.seconds.value++;
    });
  }

  Future<void> stop() async {
    await record.stop();
    await player.setFilePath(recordPath!);
    final currentState = state as ConsultationRecordingWorking;
    timer?.cancel;
    emit(ConsultationRecordingEnded(seconds: currentState.seconds.value));
  }

  Future<void> play() async => player.play();

  void cancel() {
    emit(const ConsultationRecordingInitial());
  }

  @override
  Future<void> close() {
    timer?.cancel();
    record.dispose();
    player.dispose();
    return super.close();
  }
}
