import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../constants/routes.dart';
import '../../../../../core/constants/app_style.dart';
import '../../../../../core/di/di_manager.dart';
import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../data/models/invoices/invoice.dart';
import '../../../../../localization/localizor.dart';
import '../../../../../utilities/extensions.dart';
import '../../../../widgets/reload_widget.dart';
import '../cubit/fast_consultation_cubit.dart';
import '../cubit/fast_consultation_state.dart';
import '../widget/discount_widget.dart';
import '../widget/invoice_details_widget.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key, required this.invoiceId});
  final int invoiceId;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localizor.translator.continuePayment),
      ),
      body: BlocBuilder<FastConsultationCubit, FastConsultationState>(
        bloc: DIManager.findDep<FastConsultationCubit>(),
        builder: (context, state) {
          final invoiceState = state.showInvoiceData;

          if (invoiceState is BaseSuccessState) {
            final data = invoiceState.data as Invoice;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 34.width),
              width: 0.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 161.width,
                      height: 161.height,
                      child: 'continue_payment'.toLottie((p0) => null)),
                  Text(
                    'تاكيد دفع مبلغ',
                    style: AppStyle.titleStyle,
                  ),
                  Text(
                    '${data.amount} ر.س',
                    style: AppStyle.bigTitleStyle
                        .copyWith(color: BrandColors.orange),
                  ),
                  InvoiceDetailsWidget(
                      'المبلغ', data.amount, BrandColors.black),
                  InvoiceDetailsWidget(
                      'مبلغ الخصم', data.discount, BrandColors.red),
                  InvoiceDetailsWidget(
                      'مبلغ الضريبة', data.tax, BrandColors.black),
                  InvoiceDetailsWidget('المجموع', data.total, BrandColors.black,
                      isBold: true),
                  85.emptyHeight,
                  const DiscountWidget(),
                  60.emptyHeight,
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.paymentGetway,
                          arguments: {'ndc': data.ndc, 'id': widget.invoiceId});
                    },
                    child: Text(Localizor.translator.continuePayment),
                  ),
                  20.emptyHeight,
                ],
              ),
            );
          }

          if (invoiceState is BaseFailState) {
            return ReloadWidget(
              title: invoiceState.error!.message!,
              buttonText: Localizor.translator.getReload(''),
              onPressed: () => DIManager.findDep<FastConsultationCubit>()
                  .showInvoice(widget.invoiceId),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Logger().d('called');
    DIManager.findDep<FastConsultationCubit>().showInvoice(widget.invoiceId);
  }
}
