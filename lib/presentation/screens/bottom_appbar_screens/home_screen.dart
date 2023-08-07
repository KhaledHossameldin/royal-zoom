import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../blocs/authentication/authentication_bloc.dart';
import '../../../constants/routes.dart';
import '../../../data/models/consultants/consultant.dart';
import '../consultations/consultations_screen.dart';
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
            return const ConsultationsScreen();
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
                log(Consultant.fromMap({
                  'id': 1,
                  'uuid': '9931c9b6-a669-4380-be98-2dab243443ce',
                  'country_id': null,
                  'nationality_id': null,
                  'city_id': null,
                  'country_time_zone_id': null,
                  'language_id': null,
                  'currency_id': null,
                  'first_name': null,
                  'middle_name': null,
                  'last_name': null,
                  'preview_name': 'اختبار 2',
                  'image': '',
                  'email': 'hossam@gmail.com',
                  'phone': '+201010101011',
                  'wallet_balance': '0.00',
                  'gender': 1,
                  'color': '#ffffff',
                  'preview_status': 1,
                  'last_login_at': null,
                  'email_verified_at': '2023-06-06 14:00:28',
                  'phone_verified_at': '2023-06-06 14:12:52',
                  'status': 2,
                  'is_favourite': false,
                  'user_type': 2,
                  'created_at': '2023-05-18T06:26:06.000000Z',
                  'default_major': {
                    'id': 2,
                    'uuid': '993274c2-690f-4da5-80a4-6a17d99c67f1',
                    'user_id': 1,
                    'major_id': 3,
                    'is_verified': 0,
                    'is_active': 1,
                    'is_free': 0,
                    'years_of_experience': 2,
                    'price_per_hour': '2.00',
                    'terms': '2',
                    'is_notifications_enabled': 0,
                    'is_default': 1
                  },
                  'settings': null
                }).toString());
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
