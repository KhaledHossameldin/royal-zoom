import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../blocs/authentication/authentication_bloc.dart';
import 'chat_screen.dart';
import '../consultants/consultants_screen.dart';
import 'profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().user;

    return Scaffold(
      body: Builder(
        builder: (context) {
          if (_index == 0) {
            if (user == null) {
              return const ConsultantsScreen();
            }
            return const Center(child: Text('Home'));
          } else if (_index == 1) {
            return const Center(child: Text('Consultations'));
          } else if (_index == 3) {
            return const ChatScreen();
          } else {
            return const ProfileScreen();
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Theme _buildBottomNavigationBar() {
    final theme = Theme.of(context);
    final user = context.read<AuthenticationBloc>().user;
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
