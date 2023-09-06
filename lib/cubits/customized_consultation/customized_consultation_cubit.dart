import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/consultant_response_type.dart';
import '../../data/enums/consultation_content_type.dart';
import '../../data/models/consultations/customized.dart';
import '../../data/services/repository.dart';

part 'customized_consultation_state.dart';

class CustomizedConsultationCubit extends Cubit<CustomizedConsultationState> {
  CustomizedConsultationCubit() : super(const CustomizedConsultationInitial());

  final repository = Repository.instance;

  CustomizedConsultation _consultation = CustomizedConsultation();

  int get consultantId => _consultation.consultantsIds?[0] ?? 0;

  bool get isOneConsultantChosen =>
      (_consultation.consultantsIds?.length ?? 0) == 1;

  void chooseMajor(
    int majorId,
    bool isHelpRequested,
  ) =>
      _consultation = _consultation.copyWith(
        majorId: majorId,
        isHelpRequested: isHelpRequested,
      );

  void chooseConsultants(
    List<int> ids, {
    bool? isHideName,
    bool? isAcceptFromAll,
  }) =>
      _consultation = _consultation.copyWith(
        consultantsIds: ids,
        isHideName: isHideName,
        isAcceptFromAll: isAcceptFromAll,
      );

  void setContent({
    required ConsultationContentType type,
    String? content,
    List<PlatformFile>? files,
  }) =>
      _consultation = _consultation.copyWith(
        contentType: type,
        content: content,
        files: files,
      );

  void setResponseType({
    required ConsultantResponseType type,
  }) =>
      _consultation = _consultation.copyWith(responseType: type);

  void setPrice({
    required num maximumHoursToReceiveOffers,
  }) =>
      _consultation = _consultation.copyWith(
        maximumHoursToReceiveOffers: maximumHoursToReceiveOffers,
      );

  Future<void> send(BuildContext context) async {
    try {
      emit(const CustomizedConsultationSending());
      final id = await repository.customizedConsultation(context,
          consultation: _consultation);
      emit(CustomizedConsultationSent(id));
    } catch (e) {
      emit(CustomizedConsultationError('$e'));
    }
  }
}
