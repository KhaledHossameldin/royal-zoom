import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/brand_colors.dart';
import '../../../constants/hero_tags.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import 'chat_screen.dart';
import 'consultants/consultants_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _screens = const <Widget?>[
    ConsultantsScreen(),
    Center(child: Text('Consultations')),
    null,
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _screens[_index],
        bottomNavigationBar: _buildBottomNavigationBar(),
      );

  Theme _buildBottomNavigationBar() {
    final user = context.read<AuthenticationBloc>().user;
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return Theme(
      data: theme.copyWith(
        useMaterial3: true,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          if (value == 2) {
            return;
          }
          setState(() => _index = value);
        },
        items: [
          'home'.buildBottomAppBarIcon(
            user != null ? appLocalizations.main : appLocalizations.consultants,
          ),
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
    );
  }
}
