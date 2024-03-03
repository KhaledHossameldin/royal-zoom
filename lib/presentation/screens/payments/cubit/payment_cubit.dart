import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../data/enums/payment_method.dart';
import '../../../../domain/usecases/create_wallet_charge_request_usecase.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._walletCharge) : super(PaymentState.initState());

  final ICreateWalletChargeRequestUseCase _walletCharge;
  void createWalletChargeRequest(
      {required num amount, required PaymentMethod paymentMethod}) {
    emit(state.copyWith(createWalletChargeState: const BaseLoadingState()));

    _walletCharge(amount: amount, method: paymentMethod).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(
            createWalletChargeState: BaseSuccessState(result.data?.ndc)));
      } else {
        Logger().d(result.error?.message);
        emit(state.copyWith(
            createWalletChargeState: BaseFailState(result.error)));
      }
    });
  }
}
