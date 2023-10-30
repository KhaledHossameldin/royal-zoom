import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../data/services/repository.dart';

part 'consultation_recording_state.dart';

class ConsultationRecordingCubit extends Cubit<ConsultationRecordingState> {
  ConsultationRecordingCubit() : super(const ConsultationRecordingInitial());

  Timer? timer;
  final record = AudioRecorder();
  String? recordPath;
  final repository = Repository.instance;

  Future<void> start({required TickerProvider vsync}) async {
    final path = await getTemporaryDirectory();
    recordPath = '${path.path}/record.mp4';
    if (await record.hasPermission()) {
      record.start(const RecordConfig(), path: recordPath!);
    }
    emit(ConsultationRecordingWorking(vsync: vsync));
    final currentState = state as ConsultationRecordingWorking;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentState.seconds.value++;
    });
  }

  Future<void> stop() async {
    await record.stop();
    await repository.setAudioFilePath(recordPath!);
    final currentState = state as ConsultationRecordingWorking;
    timer?.cancel;
    emit(ConsultationRecordingEnded(seconds: currentState.seconds.value));
  }

  Future<void> play() async => repository.playAudio();

  void cancel() {
    emit(const ConsultationRecordingInitial());
  }

  @override
  Future<void> close() {
    timer?.cancel();
    record.dispose();
    repository.disposeAudio();
    return super.close();
  }
}
