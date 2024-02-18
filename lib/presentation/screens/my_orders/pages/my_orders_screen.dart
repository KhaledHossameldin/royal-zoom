import 'package:flutter/material.dart';

import '../../../../constants/fonts.dart';
import '../../../../utilities/extensions.dart';
import 'majors_tab_screen.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 13.height,
                horizontal: 35.width,
              ),
              child: const TabBar(
                labelStyle: TextStyle(
                  fontSize: 12.0,
                  fontFamily: Fonts.main,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(
                    text: 'التخصصات',
                  ),
                  Tab(
                    text: 'التوثيق',
                  ),
                  Tab(
                    text: 'سحب ارصدة',
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(children: [
                MajorTabScreen(),
                Placeholder(),
                Placeholder(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
