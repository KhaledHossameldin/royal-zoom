import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_states.dart';

class MajorAndExperienceState {
  BaseState majorAndExperiencesState;
  BaseState verifyMajorState;
  BaseState changeStatusState;
  MajorAndExperienceState({
    required this.majorAndExperiencesState,
    required this.verifyMajorState,
    required this.changeStatusState,
  });

  factory MajorAndExperienceState.initState() => MajorAndExperienceState(
        majorAndExperiencesState: BaseInitState(),
        verifyMajorState: BaseInitState(),
        changeStatusState: BaseInitState(),
      );

  MajorAndExperienceState copyWith({
    BaseState? majorAndExperiencesState,
    BaseState? verifyMajorState,
    BaseState? changeStatusState,
  }) {
    return MajorAndExperienceState(
      majorAndExperiencesState:
          majorAndExperiencesState ?? this.majorAndExperiencesState,
      verifyMajorState: verifyMajorState ?? this.verifyMajorState,
      changeStatusState: changeStatusState ?? this.changeStatusState,
    );
  }
}
