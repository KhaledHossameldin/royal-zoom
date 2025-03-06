import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

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

  /// record audio
  final _recorder = AudioRecorder();
  final RecordConfig _config = const RecordConfig();
  Future recordAudio() async {
    try {
      if (await _recorder.hasPermission()) {
        final path = '${(await getTemporaryDirectory()).path}/recording.mp4';
        await _recorder.start(_config, path: path);
      }
    } catch (e) {
      Logger().d(e);
    }
  }

  Future<String?> stopRecording() async {
    try {
      final x = await _recorder.getAmplitude();
      Logger().d(x.max);
      final path = await _recorder.stop();
      return path;
    } catch (e) {
      Logger().d(e);
      return null;
    }
  }

  Future cancelRecord() async {
    _recorder.stop();
  }

  final audioPlayer = PlayerController();

  Future play(String content) async {
    final path = (await FileDownloader.downloadFile(url: content))!.path;
    await audioPlayer.preparePlayer(path: path, noOfSamples: 20);
  }
}
