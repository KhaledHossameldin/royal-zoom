import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../domain/usecases/check_invoice_status_usecase.dart';
import 'payment_result_state.dart';

class PaymentResultCubit extends Cubit<PaymentResultState> {
  PaymentResultCubit(this._checkStatus) : super(PaymentResultState.initState());

  final ICheckInvoiceStatusUseCase _checkStatus;
  void checkStatus(num invoiceId) {
    emit(state.copyWith(checkStatus: const BaseLoadingState()));
    _checkStatus(invoiceId: invoiceId).then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(checkStatus: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(checkStatus: BaseFailState(result.error)));
      }
    });
  }
}
