import 'package:file_picker/file_picker.dart';

import '../../../utilities/extensions.dart';
import '../../enums/consultant_response_type.dart';
import '../../enums/consultation_content_type.dart';

class FastConsultation {
  final int consultantId;
  final bool isHideName;
  final ConsultationContentType contentType;
  final ConsultantResponseType responseType;
  final String? content;
  final List<PlatformFile>? files;
  final int attendees;
  final int? majorId;
  final String? recordPath;

  FastConsultation({
    this.consultantId = -1,
    this.isHideName = false,
    this.contentType = ConsultationContentType.text,
    this.responseType = ConsultantResponseType.text,
    this.content,
    this.files,
    this.attendees = 1,
    this.majorId,
    this.recordPath,
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
    String? recordPath,
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
        recordPath: recordPath ?? this.recordPath,
      );

  @override
  String toString() =>
      'FastConsultation(consultantId: $consultantId, isHideName: $isHideName, contentType: $contentType, responseType: $responseType, content: $content, files: $files, attendees: $attendees, majorId: $majorId, recordPath: $recordPath)';

  Map<String, dynamic> toMap({List<String>? attachments}) {
    final map = {
      'content_type': contentType.toMap(),
      'consultant_response_type': responseType.toMap,
      'hide_name_from_consultants': isHideName.toInt,
      'attendee_number': attendees.toString(),
      'consultant_id': consultantId.toString(),
    };
    if (attachments != null) {
      map.putIfAbsent('attachments', () => attachments);
    }
    if (contentType == ConsultationContentType.text) {
      map.putIfAbsent('content', () => content!);
    }
    if (majorId != null) {
      map.putIfAbsent('major_id', () => majorId.toString());
    }
    return map;
  }

  List<String> get paths {
    final paths = <String>[];
    if (contentType == ConsultationContentType.voice) {
      paths.add(recordPath!);
    }
    if (files != null) {
      paths.addAll(files!.map((e) => e.path!).toList());
    }
    return paths;
  }
}
