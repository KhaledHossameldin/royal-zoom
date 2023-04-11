import 'package:flutter/material.dart';

import '../../../constants/hero_tags.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../../widgets/app_bar_logo.dart';
import 'consultants/consultants_screen.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  final _index = ValueNotifier(0);
  final _screens = const [
    ConsultantsScreen(),
    Center(child: Text('Consultations')),
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
            onPressed: () {},
            icon: 'chat'.imageIcon,
            tooltip: appLocalizations.chat,
          ),
          IconButton(
            onPressed: () {},
            tooltip: appLocalizations.notifications,
            icon: Badge(isLabelVisible: false, child: 'notifications'.svg),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, value, child) => _screens[value],
      ),
      bottomNavigationBar: _BottomAppBar(index: _index),
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  const _BottomAppBar({required ValueNotifier<int> index}) : _index = index;

  final ValueNotifier<int> _index;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return ValueListenableBuilder<int>(
      valueListenable: _index,
      builder: (context, value, child) => BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
              onPressed: () {},
              elevation: 0.0,
              heroTag: HeroTags.elevatedButton,
              extendedPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              icon: 'send_consultation'.svg,
              label: Text(
                appLocalizations.sendConsultation,
                style: textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            _buildItem(appLocalizations.consultants, 'home', 0),
            _buildItem(appLocalizations.consultations, 'document', 1),
            _buildItem(appLocalizations.profile, 'profile', 2),
          ],
        ),
      ),
    );
  }

  OutlinedButton _buildItem(String title, String icon, int index) =>
      OutlinedButton(
        onPressed: () => _index.value = index,
        style: OutlinedButton.styleFrom(
          foregroundColor: _index.value != index ? Colors.grey : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon.imageIcon,
            5.emptyHeight,
            Text(title),
          ],
        ),
      );
}
