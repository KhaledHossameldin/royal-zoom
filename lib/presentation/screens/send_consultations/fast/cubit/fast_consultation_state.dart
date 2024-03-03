import '../../../../../core/states/base_init_state.dart';
import '../../../../../core/states/base_states.dart';

class FastConsultationState {
  BaseState sendConsultation;
  BaseState showInvoiceData;

  FastConsultationState({
    required this.sendConsultation,
    required this.showInvoiceData,
  });
  factory FastConsultationState.initState() => FastConsultationState(
        sendConsultation: BaseInitState(),
        showInvoiceData: BaseInitState(),
      );
  FastConsultationState copyWith({
    BaseState? sendConsultation,
    BaseState? showInvoiceData,
  }) {
    return FastConsultationState(
      sendConsultation: sendConsultation ?? this.sendConsultation,
      showInvoiceData: showInvoiceData ?? this.showInvoiceData,
    );
  }
}
