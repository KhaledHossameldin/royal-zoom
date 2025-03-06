import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_states.dart';

class PaymentState {
  BaseState createWalletChargeState;
  PaymentState({
    required this.createWalletChargeState,
  });

  factory PaymentState.initState() =>
      PaymentState(createWalletChargeState: BaseInitState());
  PaymentState copyWith({
    BaseState? createWalletChargeState,
  }) {
    return PaymentState(
      createWalletChargeState:
          createWalletChargeState ?? this.createWalletChargeState,
    );
  }
}
