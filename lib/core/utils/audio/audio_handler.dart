import 'package:just_audio/just_audio.dart';

class AudioHandler {
  /// this class handles recording and playing audio files

  /// playing audio files
  final _player = AudioPlayer();
  Future playAudio(String uri) async {
    await _player.setUrl(uri);
  }

  Future pauseAudio() async {
    await _player.pause();
  }

  Future stopAudio() async {
    await _player.stop();
  }

  void dispose() => _player.dispose();
}
