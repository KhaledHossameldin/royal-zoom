import 'package:flutter/material.dart';

import '../../../../../utilities/extensions.dart';
import '../../../../widgets/voice_record_widget.dart';

class VoiceMessageWidget extends StatelessWidget {
  const VoiceMessageWidget({
    super.key,
    required this.audioUri,
    required this.isSelf,
  });
  final String audioUri;
  final bool isSelf;

  @override
  Widget build(BuildContext context) {
    return VoiceRecordWidget(
      audioUri: audioUri,
      height: 50.height,
      width: 0.screenWidth * 0.4,
      isSelf: isSelf,
    );
  }
}
