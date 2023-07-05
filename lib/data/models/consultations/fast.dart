import 'package:file_picker/file_picker.dart';

import '../../../utilities/extensions.dart';
import '../../enums/consultant_response_type.dart';
import '../../enums/consultation_content_type.dart';

class FastConsultation {
  final int consultantId;
  final bool isHideName;
  final ConsultationContentType contentType;
  final ConsultantResponseType responseType;
  final String content;
  final List<PlatformFile>? files;
  final int attendees;
  final int? majorId;

  bool get isVoice => contentType == ConsultationContentType.voice;

  FastConsultation({
    this.consultantId = -1,
    this.isHideName = false,
    this.contentType = ConsultationContentType.text,
    this.responseType = ConsultantResponseType.text,
    this.content = '',
    this.files,
    this.attendees = 1,
    this.majorId,
  });

  FastConsultation copyWith({
    int? consultantId,
    bool? isHideName,
    ConsultationContentType? contentType,
    ConsultantResponseType? responseType,
    String? content,
    List<PlatformFile>? files,
    int? attendees,
    int? majorId,
  }) =>
      FastConsultation(
        consultantId: consultantId ?? this.consultantId,
        isHideName: isHideName ?? this.isHideName,
        contentType: contentType ?? this.contentType,
        responseType: responseType ?? this.responseType,
        content: content ?? this.content,
        files: files ?? this.files,
        attendees: attendees ?? this.attendees,
        majorId: majorId ?? this.majorId,
      );

  @override
  String toString() =>
      'FastConsultation(consultantId: $consultantId, isHideName: $isHideName, contentType: $contentType, responseType: $responseType, content: $content, files: $files, attendees: $attendees, majorId: $majorId)';

  Map<String, dynamic> toMap({required List<String> attachments}) {
    final map = {
      'content_type': contentType.toMap(),
      'consultant_response_type': responseType.toMap,
      'hide_name_from_consultants': isHideName.toInt,
      'attendee_number': attendees.toString(),
      'consultant_id': consultantId.toString(),
      'content': content,
      'attachments': attachments,
    };
    if (majorId != null) {
      map.putIfAbsent('major_id', () => majorId.toString());
    }
    return map;
  }

  List<String> get paths {
    final paths = <String>[];
    if (isVoice) {
      paths.add(content);
    }
    if (files != null) {
      paths.addAll(files!.map((e) => e.path!).toList());
    }
    return paths;
  }
}
