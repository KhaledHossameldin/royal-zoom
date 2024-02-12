import 'dart:io';

import 'package:just_audio/just_audio.dart';

import '../../data/enums/consultation_content_type.dart';
import '../../domain/entities/consultation_entity.dart';

class FormatConsultationUsecase implements IFormatConsultationUsecase {
  @override
  Future<ConsultationEntity> call(ConsultationEntity consultation) async {
    if (consultation.contentType == ConsultationContentType.voice) {
      if (Platform.isIOS &&
          !consultation.content.toLowerCase().endsWith('.aac') &&
          !consultation.content.toLowerCase().endsWith('.aiff') &&
          !consultation.content.toLowerCase().endsWith('.caf') &&
          !consultation.content.toLowerCase().endsWith('.mp3') &&
          !consultation.content.toLowerCase().endsWith('.mp4') &&
          !consultation.content.toLowerCase().endsWith('.m4p') &&
          !consultation.content.toLowerCase().endsWith('.wav')) {
        return consultation;
      }
      final player = AudioPlayer();
      await player.setUrl(consultation.content);
      await player.pause();
      return consultation.copyWith(audioPlayer: player);
    }
    return consultation;
  }
}

abstract class IFormatConsultationUsecase {
  Future<ConsultationEntity> call(ConsultationEntity constlustaion);
}
