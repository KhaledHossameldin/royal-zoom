import 'package:flutter/material.dart';

import '../../../constants/brand_colors.dart';
import '../../../constants/hero_tags.dart';
import '../../../constants/routes.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../../widgets/app_bar_logo.dart';
import 'chat_screen.dart';
import 'consultants/consultants_screen.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  final _index = ValueNotifier(0);
  final _screens = const <Widget?>[
    ConsultantsScreen(),
    Center(child: Text('Consultations')),
    null,
    ChatScreen(),
    Center(child: Text('Profile')),
  ];

  @override
  void dispose() {
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100.0,
        leading: const AppBarLogo(),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.notifications),
            tooltip: appLocalizations.notifications,
            icon: Badge(isLabelVisible: false, child: 'notifications'.svg),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, value, child) => _screens[value]!,
      ),
      bottomNavigationBar: _BottomNavigationBar(index: _index),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({required ValueNotifier<int> index})
      : _index = index;

  final ValueNotifier<int> _index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return ValueListenableBuilder(
      valueListenable: _index,
      builder: (context, value, child) => Theme(
        data: theme.copyWith(
          useMaterial3: true,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: value,
          onTap: (value) {
            if (value == 2) {
              return;
            }
            _index.value = value;
          },
          items: [
            'consultants'.buildBottomAppBarIcon(appLocalizations.consultants),
            'consultations'.buildBottomAppBarIcon(
              appLocalizations.consultations,
            ),
            BottomNavigationBarItem(
              icon: FloatingActionButton(
                onPressed: () {},
                elevation: 0,
                heroTag: HeroTags.elevatedButton,
                backgroundColor: BrandColors.orange,
                child: 'send_consultation'.svg,
              ),
              label: appLocalizations.consult,
            ),
            'chat'.buildBottomAppBarIcon(appLocalizations.chat),
            'profile'.buildBottomAppBarIcon(appLocalizations.profile),
          ],
        ),
      ),
    );
  }
}
