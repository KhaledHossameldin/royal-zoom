import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:logger/logger.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../utilities/extensions.dart';

class VoiceMessageWidget extends StatefulWidget {
  const VoiceMessageWidget({
    super.key,
    required this.audioUri,
    required this.isSelf,
  });
  final String audioUri;
  final bool isSelf;

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  final PlayerController _playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    init();
  }

  late StreamSubscription<PlayerState> playerStateSubscription;
  Duration total = Duration.zero;
  Duration current = Duration.zero;

  File? file;
  PlayerState playerState = PlayerState.initialized;
  Future init() async {
    file = await FileDownloader.downloadFile(url: widget.audioUri);
    Logger().d(file?.path);
    await _playerController.preparePlayer(
      path: file!.path,
      shouldExtractWaveform: true,
    );
    _playerController.updateFrequency = UpdateFrequency.low;

    _playerController.getDuration().then((value) {
      Logger().d(value);
      setState(() {
        total = Duration(milliseconds: value);
      });
    });
    _playerController.onCurrentDurationChanged.listen((event) {
      setState(() {
        current = Duration(milliseconds: event);
      });
    });
    _playerController.onPlayerStateChanged.listen((state) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAudioTime(),
        5.emptyWidth,
        _buildAudioWaves(),
        5.emptyWidth,
        _buildPlayButton(),
      ],
    );
  }

  Widget _buildAudioTime() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(total.toMMSS()),
        Text('/${current.toMMSS()}'),
      ],
    );
  }

  Widget _buildAudioWaves() {
    return AudioFileWaveforms(
      size: Size(0.screenWidth * 0.4, 50.height),
      playerController: _playerController,
      waveformType: WaveformType.long,
      enableSeekGesture: true,
      playerWaveStyle: PlayerWaveStyle(
        fixedWaveColor: BrandColors.gray,
        liveWaveColor:
            widget.isSelf ? BrandColors.darkGreen : BrandColors.snowWhite,
        backgroundColor:
            !widget.isSelf ? BrandColors.darkGreen : BrandColors.snowWhite,
        showSeekLine: false,
      ),
      continuousWaveform: true,
    );
  }

  Widget _buildPlayButton() {
    return Container(
      decoration: BoxDecoration(
          color: !widget.isSelf ? BrandColors.snowWhite : BrandColors.darkGreen,
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      child: IconButton(
        onPressed: () async {
          if (playerState == PlayerState.initialized ||
              playerState == PlayerState.paused) {
            await _playerController.startPlayer(
                finishMode: FinishMode.pause, forceRefresh: true);
          } else {
            await _playerController.pausePlayer();
          }
        },
        icon: !_playerController.playerState.isPlaying
            ? const Icon(Icons.play_arrow)
            : const Icon(Icons.pause),
        color: widget.isSelf ? BrandColors.snowWhite : BrandColors.darkGreen,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.dispose();
    file?.delete();
  }
}
