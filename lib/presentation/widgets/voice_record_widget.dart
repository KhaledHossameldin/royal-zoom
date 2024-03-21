import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:logger/logger.dart';
import '../../constants/brand_colors.dart';
import '../../utilities/extensions.dart';

class VoiceRecordWidget extends StatefulWidget {
  const VoiceRecordWidget({
    super.key,
    required this.audioUri,
    this.isSelf = true,
    required this.height,
    required this.width,
  });
  final String audioUri;
  final bool isSelf;
  final double width;
  final double height;
  @override
  State<VoiceRecordWidget> createState() => _VoiceRecordWidgetState();
}

class _VoiceRecordWidgetState extends State<VoiceRecordWidget> {
  Duration total = Duration.zero;
  Duration current = Duration.zero;
  final PlayerController _playerController = PlayerController();
  File? file;
  bool isLoading = true;
  Future init() async {
    file ??= await FileDownloader.downloadFile(url: widget.audioUri);
    await _playerController.preparePlayer(path: file!.path, noOfSamples: 80);
    _playerController.getDuration().then((value) {
      setState(() {
        isLoading = false;
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.width,
        vertical: 4.height,
      ),
      decoration: BoxDecoration(
        color: widget.isSelf ? BrandColors.snowWhite : BrandColors.darkGreen,
        borderRadius: BorderRadius.circular(29.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAudioTime(),
          5.emptyWidth,
          _buildAudioWaves(),
          5.emptyWidth,
          _buildPlayButton(),
        ],
      ),
    );
  }

  Widget _buildAudioTime() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          total.toMMSS(),
          style: TextStyle(
            color:
                widget.isSelf ? BrandColors.darkGreen : BrandColors.snowWhite,
          ),
        ),
        Text(
          '/${current.toMMSS()}',
          style: TextStyle(
            color:
                widget.isSelf ? BrandColors.darkGreen : BrandColors.snowWhite,
          ),
        ),
      ],
    );
  }

  Widget _buildAudioWaves() {
    return Expanded(
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: AudioFileWaveforms(
          size: Size(widget.width, widget.height),
          playerController: _playerController,
          waveformType: WaveformType.fitWidth,
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
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return Container(
      decoration: BoxDecoration(
          color: !widget.isSelf ? BrandColors.snowWhite : BrandColors.darkGreen,
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      child: isLoading
          ? const CircularProgressIndicator()
          : IconButton(
              onPressed: () async {
                if (!_playerController.playerState.isPlaying) {
                  // _playerController.stopAllPlayers();
                  await _playerController.startPlayer(
                      finishMode: FinishMode.pause, forceRefresh: true);
                } else {
                  await _playerController.pausePlayer();
                }
              },
              icon: !_playerController.playerState.isPlaying
                  ? const Icon(Icons.play_arrow)
                  : const Icon(Icons.pause),
              color:
                  widget.isSelf ? BrandColors.snowWhite : BrandColors.darkGreen,
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.dispose();
    file?.delete();
  }
}
