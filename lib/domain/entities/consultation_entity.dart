import 'package:just_audio/just_audio.dart';

import '../../core/models/base_entity.dart';
import '../../data/enums/consultant_response_type.dart';
import '../../data/enums/consultation_content_type.dart';
import '../../data/enums/consultation_status.dart';
import '../../data/enums/consultation_visibility_status.dart';
import '../../data/models/consultants/consultant.dart';
import '../../data/models/major.dart';

class ConsultationEntity extends BaseEntity {
  final int id;
  final String uuid;
  final int majorId;
  final int userId;
  final ConsultationContentType contentType;
  final String content;
  final ConsultantResponseType responseType;
  final bool isAcceptingOffersFromAll;
  final bool isHelpRequested;
  final bool isHideNameFromConsultants;
  final bool isAcceptMinimumOfferByDefault;
  final int attendeeNumber;
  final ConsultationStatus status;
  final bool isPaid;
  final bool isUnscheduled;
  final ConsultationVisibilityStatus visibilityStatus;
  final DateTime publishedAt;
  final DateTime createdAt;
  final bool isFavourite;
  final bool isFastConsultation;
  final Major major;
  final num? maximumPrice;
  final int? consultantId;
  final DateTime? appointmentDate;
  final DateTime? maxTimeToReceiveOffers;
  final String? address;
  final Consultant? consultant;
  final AudioPlayer? audioPlayer;

  ConsultationEntity({
    required this.id,
    required this.uuid,
    required this.majorId,
    required this.userId,
    required this.contentType,
    required this.content,
    required this.responseType,
    required this.maximumPrice,
    required this.isAcceptingOffersFromAll,
    required this.isHelpRequested,
    required this.isHideNameFromConsultants,
    required this.isAcceptMinimumOfferByDefault,
    required this.attendeeNumber,
    required this.status,
    required this.isPaid,
    required this.isUnscheduled,
    required this.visibilityStatus,
    required this.publishedAt,
    required this.createdAt,
    required this.isFavourite,
    required this.isFastConsultation,
    required this.major,
    this.consultantId,
    this.appointmentDate,
    this.maxTimeToReceiveOffers,
    this.address,
    this.consultant,
    this.audioPlayer,
  });
  ConsultationEntity copyWith({
    int? id,
    String? uuid,
    int? majorId,
    int? userId,
    ConsultationContentType? contentType,
    String? content,
    ConsultantResponseType? responseType,
    num? maximumPrice,
    bool? isAcceptingOffersFromAll,
    bool? isHelpRequested,
    bool? isHideNameFromConsultants,
    bool? isAcceptMinimumOfferByDefault,
    int? attendeeNumber,
    ConsultationStatus? status,
    bool? isPaid,
    bool? isUnscheduled,
    ConsultationVisibilityStatus? visibilityStatus,
    DateTime? publishedAt,
    DateTime? createdAt,
    bool? isFavourite,
    bool? isFastConsultation,
    Major? major,
    int? consultantId,
    DateTime? appointmentDate,
    DateTime? maxTimeToReceiveOffers,
    String? address,
    Consultant? consultant,
    AudioPlayer? audioPlayer,
  }) {
    return ConsultationEntity(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      majorId: majorId ?? this.majorId,
      userId: userId ?? this.userId,
      contentType: contentType ?? this.contentType,
      content: content ?? this.content,
      responseType: responseType ?? this.responseType,
      maximumPrice: maximumPrice ?? this.maximumPrice,
      isAcceptingOffersFromAll:
          isAcceptingOffersFromAll ?? this.isAcceptingOffersFromAll,
      isHelpRequested: isHelpRequested ?? this.isHelpRequested,
      isHideNameFromConsultants:
          isHideNameFromConsultants ?? this.isHideNameFromConsultants,
      isAcceptMinimumOfferByDefault:
          isAcceptMinimumOfferByDefault ?? this.isAcceptMinimumOfferByDefault,
      attendeeNumber: attendeeNumber ?? this.attendeeNumber,
      status: status ?? this.status,
      isPaid: isPaid ?? this.isPaid,
      isUnscheduled: isUnscheduled ?? this.isUnscheduled,
      visibilityStatus: visibilityStatus ?? this.visibilityStatus,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      isFavourite: isFavourite ?? this.isFavourite,
      isFastConsultation: isFastConsultation ?? this.isFastConsultation,
      major: major ?? this.major,
      consultantId: consultantId ?? this.consultantId,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      maxTimeToReceiveOffers:
          maxTimeToReceiveOffers ?? this.maxTimeToReceiveOffers,
      address: address ?? this.address,
      consultant: consultant ?? this.consultant,
      audioPlayer: audioPlayer ?? this.audioPlayer,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uuid,
        majorId,
        userId,
        contentType,
        content,
        responseType,
        maximumPrice,
        isAcceptingOffersFromAll,
        isHelpRequested,
        isHideNameFromConsultants,
        isAcceptMinimumOfferByDefault,
        attendeeNumber,
        status,
        isPaid,
        isUnscheduled,
        visibilityStatus,
        publishedAt,
        createdAt,
        isFavourite,
        isFastConsultation,
        major,
        consultantId,
        appointmentDate,
        maxTimeToReceiveOffers,
        address,
        consultant,
        audioPlayer
      ];
}
