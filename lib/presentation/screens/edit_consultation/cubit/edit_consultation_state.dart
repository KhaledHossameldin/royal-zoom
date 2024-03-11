import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_states.dart';

class EditConsultationState {
  BaseState sendUpdatedConsultation;
  EditConsultationState({required this.sendUpdatedConsultation});

  factory EditConsultationState.initState() =>
      EditConsultationState(sendUpdatedConsultation: BaseInitState());
  EditConsultationState copyWith({
    BaseState? sendUpdatedConsultation,
  }) {
    return EditConsultationState(
      sendUpdatedConsultation:
          sendUpdatedConsultation ?? this.sendUpdatedConsultation,
    );
  }
}
