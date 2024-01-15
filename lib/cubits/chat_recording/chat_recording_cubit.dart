import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../data/services/repository.dart';

part 'chat_recording_state.dart';

class ChatRecordingCubit extends Cubit<ChatRecordingState> {
  ChatRecordingCubit() : super(const ChatRecordingInitial());

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
    emit(ChatRecordingWorking(vsync: vsync));
    final currentState = state as ChatRecordingWorking;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentState.seconds.value++;
    });
  }

  Future<void> stop() async {
    await record.stop();
    timer?.cancel();
    timer = null;
    emit(const ChatRecordingInitial());
  }

  @override
  Future<void> close() {
    timer?.cancel();
    record.dispose();
    repository.disposeAudio();
    return super.close();
  }
}
