import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../localization/localizor.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/reload_widget.dart';
import '../cubit/payment_result_cubit.dart';
import '../cubit/payment_result_state.dart';

class PaymentResultScreen extends StatefulWidget {
  const PaymentResultScreen({super.key, required this.invoiceId});
  final num invoiceId;

  @override
  State<PaymentResultScreen> createState() => _PaymentResultScreenState();
}

class _PaymentResultScreenState extends State<PaymentResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 0.screenWidth,
        child: BlocConsumer<PaymentResultCubit, PaymentResultState>(
          bloc: DIManager.findDep<PaymentResultCubit>(),
          listener: (context, state) {
            final checkStatus = state.checkStatus;
            if (checkStatus is BaseSuccessState) {
              Timer(const Duration(seconds: 3), () {
                DIManager.findNavigator().offAll(Routes.home);
              });
            }
          },
          builder: (context, state) {
            final checkStatus = state.checkStatus;
            if (checkStatus is BaseLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (checkStatus is BaseSuccessState) {
              final isSuccess = checkStatus.data as bool;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isSuccess
                      ? 'transaction_success'.toLottie((p0) => null)
                      : 'transaction_fail'.toLottie((p0) => null),
                  isSuccess
                      ? Text(
                          'تم الدفع بنجاح',
                          style: AppStyle.bigTitleStyle
                              .copyWith(color: BrandColors.orange),
                        )
                      : Text(
                          'عملية غير ناجحة الرجاء المحاولة مرة اخرى',
                          style: AppStyle.bigTitleStyle
                              .copyWith(color: BrandColors.red),
                        )
                ],
              );
            }

            return ReloadWidget(
                title: (checkStatus as BaseFailState).error?.message ?? '',
                buttonText: Localizor.translator.getReload(''),
                onPressed: () {});
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    DIManager.findDep<PaymentResultCubit>().checkStatus(widget.invoiceId);
  }
}
