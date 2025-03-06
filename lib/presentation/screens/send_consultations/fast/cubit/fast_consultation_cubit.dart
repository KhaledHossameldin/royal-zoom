import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../core/states/base_wait_state.dart';
import '../../../../../data/enums/consultant_response_type.dart';
import '../../../../../data/enums/consultation_content_type.dart';
import '../../../../../data/models/consultations/fast.dart';
import '../../../../../domain/usecases/consultation_invoice_usecase.dart';
import '../../../../../domain/usecases/fast_consultation_usecase.dart';
import 'fast_consultation_state.dart';

class FastConsultationCubit extends Cubit<FastConsultationState> {
  FastConsultationCubit(this._fast, this._invoice)
      : super(FastConsultationState.initState());

  final IFastConsultationUseCase _fast;
  void sendConsultation(
    ConsultantResponseType type,
  ) {
    emit(state.copyWith(sendConsultation: const BaseLoadingState()));
    _fast(_consultation).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(sendConsultation: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(sendConsultation: BaseFailState(result.error)));
      }
    });
  }

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

  final IConsultationInvoiceUseCase _invoice;
  void showInvoice(int id) {
    emit(state.copyWith(showInvoiceData: const BaseLoadingState()));
    _invoice(id: id).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(showInvoiceData: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(showInvoiceData: BaseFailState(result.error)));
      }
    });
  }
}
