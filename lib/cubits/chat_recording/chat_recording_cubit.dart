import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../core/di/di_manager.dart';
import '../../core/utils/audio/audio_handler.dart';

part 'chat_recording_state.dart';

class ChatRecordingCubit extends Cubit<ChatRecordingState> {
  ChatRecordingCubit() : super(const ChatRecordingInitial());

  Timer? timer;

  Future<void> start({required TickerProvider vsync}) async {
    DIManager.findDep<AudioHandler>().recordAudio();
    emit(ChatRecordingWorking(vsync: vsync));
    final currentState = state as ChatRecordingWorking;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentState.seconds.value++;
    });
  }

  Future<void> stop(int chatId, Function(String uri) onUpload) async {
    timer?.cancel();
    timer = null;
    DIManager.findDep<AudioHandler>().stopRecording().then((uri) {
      if (uri != null) {
        Logger().d(uri);
        onUpload(uri);
      }
    });
    timer?.cancel();
    timer = null;
    emit(const ChatRecordingInitial());
  }

  void cancelRecording() {
    timer?.cancel();
    timer = null;
    DIManager.findDep<AudioHandler>().cancelRecord();
    emit(const ChatRecordingInitial());
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
