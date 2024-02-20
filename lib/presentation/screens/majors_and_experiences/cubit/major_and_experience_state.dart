import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_states.dart';

class MajorAndExperienceState {
  BaseState majorAndExperiencesState;
  MajorAndExperienceState({required this.majorAndExperiencesState});

  factory MajorAndExperienceState.initState() =>
      MajorAndExperienceState(majorAndExperiencesState: BaseInitState());

  MajorAndExperienceState copyWith({
    BaseState? majorAndExperiencesState,
  }) {
    return MajorAndExperienceState(
      majorAndExperiencesState:
          majorAndExperiencesState ?? this.majorAndExperiencesState,
    );
  }
}
