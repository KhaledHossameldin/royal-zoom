import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_states.dart';

class MajorAndExperienceState {
  BaseState majorAndExperiencesState;
  BaseState verifyMajorState;
  MajorAndExperienceState({
    required this.majorAndExperiencesState,
    required this.verifyMajorState,
  });

  factory MajorAndExperienceState.initState() => MajorAndExperienceState(
        majorAndExperiencesState: BaseInitState(),
        verifyMajorState: BaseInitState(),
      );

  MajorAndExperienceState copyWith({
    BaseState? majorAndExperiencesState,
    BaseState? verifyMajorState,
  }) {
    return MajorAndExperienceState(
      majorAndExperiencesState:
          majorAndExperiencesState ?? this.majorAndExperiencesState,
      verifyMajorState: verifyMajorState ?? this.verifyMajorState,
    );
  }
}
