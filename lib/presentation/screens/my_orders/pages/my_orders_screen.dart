import 'package:flutter/material.dart';

import '../../../../constants/fonts.dart';
import '../../../../localization/localizor.dart';
import '../../../../utilities/extensions.dart';
import 'major_verifcation_tab_screen.dart';
import 'majors_tab_screen.dart';
import 'withdraw_requests_tab_screen.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  final _majorTabScreen = const MajorTabScreen();

  final _majorVerificationTabScreen = const MajorVerificationTabScreen();

  final _withdrawRequestsTabScreen = const WithdrawRequestsTabScreen();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Localizor.translator.myOrders),
        ),
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
                  Tab(
                    text: Localizor.translator.getMajor(false),
                  ),
                  Tab(
                    text: Localizor.translator.verification,
                  ),
                  Tab(
                    text: Localizor.translator.withdraw,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                _majorTabScreen,
                _majorVerificationTabScreen,
                _withdrawRequestsTabScreen
              ]),
            )
          ],
        ),
      ),
    );
  }
}
