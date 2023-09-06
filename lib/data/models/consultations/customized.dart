import 'package:file_picker/file_picker.dart';

import '../../../utilities/extensions.dart';
import '../../enums/consultant_response_type.dart';
import '../../enums/consultation_content_type.dart';

class CustomizedConsultation {
  final int majorId;
  final ConsultationContentType contentType;
  final String content;
  final ConsultantResponseType responseType;
  final bool isAcceptFromAll;
  final bool isHideName;
  final List<int>? consultantsIds;
  final List<PlatformFile>? files;
  final num maximumHoursToReceiveOffers;
  final bool isHelpRequested;
  final bool isMinimumByDefault;

  bool get isVoice => contentType == ConsultationContentType.voice;

  CustomizedConsultation({
    this.majorId = -1,
    this.content = '',
    this.contentType = ConsultationContentType.text,
    this.responseType = ConsultantResponseType.text,
    this.isAcceptFromAll = false,
    this.isHideName = false,
    this.consultantsIds,
    this.files,
    this.maximumHoursToReceiveOffers = 0,
    this.isHelpRequested = false,
    this.isMinimumByDefault = false,
  });

  CustomizedConsultation copyWith({
    int? majorId,
    ConsultationContentType? contentType,
    String? content,
    ConsultantResponseType? responseType,
    bool? isAcceptFromAll,
    bool? isHideName,
    List<int>? consultantsIds,
    List<PlatformFile>? files,
    num? maximumHoursToReceiveOffers,
    bool? isHelpRequested,
    bool? isMinimumByDefault,
  }) =>
      CustomizedConsultation(
        majorId: majorId ?? this.majorId,
        contentType: contentType ?? this.contentType,
        content: content ?? this.content,
        responseType: responseType ?? this.responseType,
        isAcceptFromAll: isAcceptFromAll ?? this.isAcceptFromAll,
        isHideName: isHideName ?? this.isHideName,
        consultantsIds: consultantsIds ?? this.consultantsIds,
        files: files ?? this.files,
        maximumHoursToReceiveOffers:
            maximumHoursToReceiveOffers ?? this.maximumHoursToReceiveOffers,
        isHelpRequested: isHelpRequested ?? this.isHelpRequested,
        isMinimumByDefault: isHelpRequested ?? this.isMinimumByDefault,
      );

  @override
  String toString() {
    return 'CustomizedConsultation(majorId: $majorId, contentType: $contentType, content: $content, responseType: $responseType, isAcceptFromAll: $isAcceptFromAll, isHideName: $isHideName, consultantsIds: $consultantsIds, files: $files, maximumHoursToReceiveOffers: $maximumHoursToReceiveOffers, isHelpRequested: $isHelpRequested, isMinimumByDefault: $isMinimumByDefault)';
  }

  Map<String, Object> toMap({required List<String> attachments}) {
    final map = {
      'major_id': majorId.toString(),
      'content_type': contentType.toMap(),
      'content': content,
      'consultant_response_type': responseType.toMap(),
      'attachments': attachments,
      'max_number_of_hours_to_receive_offers':
          maximumHoursToReceiveOffers.toString(),
      'is_accepting_offers_from_all': isAcceptFromAll.toInt,
      'hide_name_from_consultants': isHideName.toInt,
      'is_help_requested': isHelpRequested.toInt,
      'accept_minimum_offer_by_default': isMinimumByDefault.toInt,
    };
    if (!isAcceptFromAll) {
      map.putIfAbsent(
        'consultants',
        () => consultantsIds!.map((e) => e.toString()).toList(),
      );
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
