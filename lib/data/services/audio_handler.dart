import 'package:just_audio/just_audio.dart';

class AudioHandler {
  static AudioHandler instance = AudioHandler._();
  AudioHandler._();

  final _player = AudioPlayer();

  Future<void> play() async {
    await stop();
    await _player.play();
  }

  Future<void> stop() async => await _player.stop();

  Future<void> setFilePath(String path) async => _player.setFilePath(path);

  Future<Duration?> setUrl(String url) async {
    try {
      final duration = await _player.setUrl(url);
      await _player.stop();
      return duration;
    } catch (e) {
      return null;
    }
  }

  void dispose() => _player.dispose();

  Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream;
}
