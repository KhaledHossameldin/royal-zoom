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
