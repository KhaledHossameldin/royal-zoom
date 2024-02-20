import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_states.dart';

class MyOrdersState {
  BaseState showNewMajorsState;
  BaseState showMajorVerificationState;
  BaseState showWithdrawRequestsState;
  MyOrdersState({
    required this.showNewMajorsState,
    required this.showMajorVerificationState,
    required this.showWithdrawRequestsState,
  });
  factory MyOrdersState.initState() => MyOrdersState(
        showNewMajorsState: BaseInitState(),
        showMajorVerificationState: BaseInitState(),
        showWithdrawRequestsState: BaseInitState(),
      );
  MyOrdersState copyWith({
    BaseState? showNewMajorsState,
    BaseState? showMajorVerificationState,
    BaseState? showWithdrawRequestsState,
  }) {
    return MyOrdersState(
      showNewMajorsState: showNewMajorsState ?? this.showNewMajorsState,
      showMajorVerificationState:
          showMajorVerificationState ?? this.showMajorVerificationState,
      showWithdrawRequestsState:
          showWithdrawRequestsState ?? this.showWithdrawRequestsState,
    );
  }
}
