import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioHandler {
  static AudioHandler instance = AudioHandler._();
  AudioHandler._();

  final _player = AudioPlayer();

  Future<void> play() async {
    await _player.seek(Duration.zero);
    await _player.play();
  }

  Future<void> setFilePath(String path) async => _player.setFilePath(path);

  Future<Duration?> setUrl(String url) async {
    try {
      final duration = await _player.setUrl(url);
      await _player.pause();
      return duration;
    } catch (e) {
      return null;
    }
  }

  void dispose() => _player.dispose();

  Widget player({bool isPlayer = true}) {
    if (!isPlayer) {
      return const LinearProgressIndicator(value: 0.0);
    }
    return StreamBuilder<Duration>(
      stream: _player.bufferedPositionStream,
      builder: (context, snapshot) => LinearProgressIndicator(
        color: Colors.red,
        backgroundColor: Colors.green,
        value: (snapshot.data ?? Duration.zero).inSeconds /
            (_player.duration ?? const Duration(seconds: 1)).inSeconds,
      ),
    );
  }
}
