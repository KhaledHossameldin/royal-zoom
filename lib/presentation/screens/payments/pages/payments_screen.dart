import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/fonts.dart';
import '../../../../cubits/invoice/invoice_cubit.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import 'consultation_tab.dart';
import 'payments_tab.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text(appLocalizations.payments)),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 13.height,
                horizontal: 35.width,
              ),
              child: TabBar(
                labelStyle: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: Fonts.main,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(text: appLocalizations.payments),
                  Tab(text: appLocalizations.consultationPayments),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(children: [
              BlocProvider(
                create: (context) => InvoiceCubit(),
                child: const PaymentsTab(),
              ),
              BlocProvider(
                create: (context) => InvoiceCubit(),
                child: const ConsultationTab(),
              ),
            ])),
          ],
        ),
      ),
    );
  }
}
