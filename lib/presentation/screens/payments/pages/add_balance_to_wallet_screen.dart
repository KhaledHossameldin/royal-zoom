import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../constants/routes.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../data/enums/payment_method.dart';
import '../../../../utilities/extensions.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';
import '../widgets/amount_to_pay_widget.dart';
import '../widgets/payment_methods_widget.dart';

class AddBalanceToWalletScreen extends StatefulWidget {
  const AddBalanceToWalletScreen({super.key});

  @override
  State<AddBalanceToWalletScreen> createState() =>
      _AddBalanceToWalletScreenState();
}

class _AddBalanceToWalletScreenState extends State<AddBalanceToWalletScreen> {
  num amount = -1;
  num paymentMethod = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اضافة رصيد الى المحفظة'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 34.width),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.emptyHeight,
                  Text(
                    'اضافة رصيد الى المحفظة',
                    style: AppStyle.titleStyle,
                  ),
                  const Text(
                    'يجب اسخدام مبالغ المحفظة خلال 365 يوم بحد اقصى',
                  ),
                  AmountToPayWidget(
                    onChooseAmount: (amount) {
                      this.amount = amount;
                    },
                  ),
                  12.emptyHeight,
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'الحد الادني لاضافة مبلغ في المحفظة 10 ر.س',
                    ),
                  ),
                  PaymentMethodsWidget(onSelectedPayment: (paymentMethod) {
                    this.paymentMethod = paymentMethod;
                  })
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.height),
                  child: BlocConsumer<PaymentCubit, PaymentState>(
                    bloc: DIManager.findDep<PaymentCubit>(),
                    listener: (context, state) {
                      final paymentState = state.createWalletChargeState;
                      if (paymentState is BaseSuccessState) {
                        Navigator.of(context).pushNamed(
                          Routes.paymentGetway,
                          arguments: paymentState.data,
                        );
                      }
                    },
                    builder: (context, state) {
                      final paymentState = state.createWalletChargeState;

                      return IgnorePointer(
                        ignoring: paymentState is BaseLoadingState,
                        child: ElevatedButton(
                          onPressed: () {
                            Logger()
                                .d({'method': paymentMethod, 'amount': amount});
                            if (paymentMethod != -1 && amount != -1) {
                              DIManager.findDep<PaymentCubit>()
                                  .createWalletChargeRequest(
                                      amount: amount,
                                      paymentMethod: paymentMethod
                                          .toInt()
                                          .paymentMethodFromMap());
                            }
                          },
                          child: paymentState is BaseLoadingState
                              ? const CircularProgressIndicator()
                              : const Text('اضافة'),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
