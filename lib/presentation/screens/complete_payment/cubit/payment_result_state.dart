import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_states.dart';

class PaymentResultState {
  BaseState checkStatus;
  PaymentResultState({required this.checkStatus});

  factory PaymentResultState.initState() =>
      PaymentResultState(checkStatus: BaseInitState());
  PaymentResultState copyWith({BaseState? checkStatus}) {
    return PaymentResultState(checkStatus: checkStatus ?? this.checkStatus);
  }
}
