import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_states.dart';

class MajorAndExperienceState {
  BaseState majorAndExperiencesState;
  BaseState verifyMajorState;
  BaseState changeStatusState;
  BaseState updateState;
  BaseState deleteState;
  MajorAndExperienceState({
    required this.majorAndExperiencesState,
    required this.verifyMajorState,
    required this.changeStatusState,
    required this.updateState,
    required this.deleteState,
  });

  factory MajorAndExperienceState.initState() => MajorAndExperienceState(
        majorAndExperiencesState: BaseInitState(),
        verifyMajorState: BaseInitState(),
        changeStatusState: BaseInitState(),
        updateState: BaseInitState(),
        deleteState: BaseInitState(),
      );

  MajorAndExperienceState copyWith({
    BaseState? majorAndExperiencesState,
    BaseState? verifyMajorState,
    BaseState? changeStatusState,
    BaseState? updateState,
    BaseState? deleteState,
  }) {
    return MajorAndExperienceState(
      majorAndExperiencesState:
          majorAndExperiencesState ?? this.majorAndExperiencesState,
      verifyMajorState: verifyMajorState ?? this.verifyMajorState,
      changeStatusState: changeStatusState ?? this.changeStatusState,
      updateState: updateState ?? this.updateState,
      deleteState: deleteState ?? this.deleteState,
    );
  }
}
