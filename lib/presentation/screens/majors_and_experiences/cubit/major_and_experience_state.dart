import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_states.dart';

class MajorAndExperienceState {
  BaseState majorAndExperiencesState;
  BaseState verifyMajorState;
  BaseState changeStatusState;
  BaseState updateState;
  MajorAndExperienceState({
    required this.majorAndExperiencesState,
    required this.verifyMajorState,
    required this.changeStatusState,
    required this.updateState,
  });

  factory MajorAndExperienceState.initState() => MajorAndExperienceState(
        majorAndExperiencesState: BaseInitState(),
        verifyMajorState: BaseInitState(),
        changeStatusState: BaseInitState(),
        updateState: BaseInitState(),
      );

  MajorAndExperienceState copyWith({
    BaseState? majorAndExperiencesState,
    BaseState? verifyMajorState,
    BaseState? changeStatusState,
    BaseState? updateState,
  }) {
    return MajorAndExperienceState(
      majorAndExperiencesState:
          majorAndExperiencesState ?? this.majorAndExperiencesState,
      verifyMajorState: verifyMajorState ?? this.verifyMajorState,
      changeStatusState: changeStatusState ?? this.changeStatusState,
      updateState: updateState ?? this.updateState,
    );
  }
}
