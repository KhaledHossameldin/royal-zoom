import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../constants/routes.dart';
import '../../../core/di/di_manager.dart';
import '../../../data/models/authentication/user_data.dart';
import '../../../data/sources/local/shared_prefs.dart';
import '../consultations/consultations_screen.dart';
import 'chats/pages/chat_screen.dart';
import '../consultants/guest_screen.dart';
import 'main/main_screen.dart';
import 'profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _index = ValueNotifier(0);
  UserData? user = DIManager.findDep<SharedPrefs>().getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, value, child) {
          if (_index.value == 0) {
            if (user == null) {
              return const GuestScreen();
            }
            return MainScreen(index: _index);
          } else if (_index.value == 1) {
            return const ConsultationsScreen();
          } else if (_index.value == 3) {
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

    final appLocalizations = AppLocalizations.of(context);

    return Theme(
      data: theme.copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, value, child) => BottomNavigationBar(
          currentIndex: value,
          onTap: (value) {
            if (value == 2) {
              return;
            }
            _index.value = value;
          },
          items: [
            'home'.buildBottomAppBarIcon(
              user != null
                  ? appLocalizations.main
                  : appLocalizations.consultants,
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
                  route: Routes.chooseFastConsultant,
                ),
                13.emptyHeight,
                _buildItem(
                  context,
                  appLocalizations,
                  icon: 'customized_consultation',
                  title: appLocalizations.customizedConsultation,
                  route: Routes.chooseMajor,
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
