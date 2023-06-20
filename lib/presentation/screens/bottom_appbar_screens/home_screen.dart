import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../blocs/authentication/authentication_bloc.dart';
import '../../../constants/routes.dart';
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
              onPressed: () {
                if (user == null) {
                  Navigator.pushReplacementNamed(context, Routes.login);
                  return;
                }
                showModal(
                  context: context,
                  builder: (context) => const _ConsultationDialog(),
                );
              },
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

class _ConsultationDialog extends StatelessWidget {
  const _ConsultationDialog();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              24.width,
              22.height,
              24.width,
              18.height,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  appLocalizations.chooseConsultationType,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: BrandColors.orange,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                20.emptyHeight,
                _buildItem(
                  context,
                  appLocalizations,
                  icon: 'normal_consultation',
                  title: appLocalizations.normalConsultation,
                  route: Routes.chooseConsultant,
                ),
                13.emptyHeight,
                _buildItem(
                  context,
                  appLocalizations,
                  icon: 'customized_consultation',
                  title: appLocalizations.customizedConsultation,
                  route: '',
                ),
              ],
            ),
          ),
          Positioned.directional(
            top: -25.height,
            start: 10.width,
            textDirection: TextDirection.rtl,
            child: FloatingActionButton.small(
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.close,
                color: BrandColors.gray,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildItem(
    BuildContext context,
    AppLocalizations appLocalizations, {
    required String icon,
    required String title,
    required String route,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: BrandColors.gray),
      ),
      leading: icon.buidImageIcon(color: BrandColors.orange),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
      onTap: () => Navigator.popAndPushNamed(context, route),
    );
  }
}
