import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/consultant_response_type.dart';
import '../../data/enums/consultation_content_type.dart';
import '../../data/models/consultations/fast.dart';
import '../../data/services/repository.dart';

part 'fast_consultation_state.dart';

class FastConsultationCubit extends Cubit<FastConsultationState> {
  FastConsultationCubit() : super(const FastConsultationInitial());

  final repository = Repository.instance;

  FastConsultation _consultation = FastConsultation();

  void chooseConsultant(int id, {bool? isHideName, int? majorId}) =>
      _consultation = _consultation.copyWith(
        consultantId: id,
        isHideName: isHideName,
        majorId: majorId,
      );

  void setContent({
    required ConsultationContentType type,
    String? content,
    List<PlatformFile>? files,
  }) {
    _consultation = _consultation.copyWith(
      contentType: type,
      content: content,
      files: files,
    );
  }

  Future<void> send(
    BuildContext context, {
    required ConsultantResponseType type,
  }) async {
    _consultation = _consultation.copyWith(responseType: type);
    try {
      emit(const FastConsultationSending());
      final id = await repository.fastConsultation(context,
          consultation: _consultation);
      emit(FastConsultationSent(id));
    } catch (e) {
      emit(FastConsultationError('$e'));
    }
  }
}
