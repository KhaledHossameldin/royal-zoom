import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/routes.dart';
import '../../../data/services/repository.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

// ignore: must_be_immutable
class LocationPermissionScreen extends StatelessWidget {
  LocationPermissionScreen({super.key});

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final padding = EdgeInsets.symmetric(horizontal: 34.width);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Material(),
          'location'.permissionImage,
          Padding(
            padding: padding,
            child: Column(
              children: [
                Text(
                  appLocalizations.locationTitle,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineLarge,
                ),
                30.emptyHeight,
                Text(
                  appLocalizations.locationSubtitle,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),
              ],
            ),
          ),
          _buildButtons(context, padding),
        ],
      ),
    );
  }

  Padding _buildButtons(BuildContext context, EdgeInsets padding) {
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
      padding: padding,
      child: Column(
        children: [
          StatefulBuilder(
            builder: (context, setState) => ElevatedButton(
              onPressed: () async {
                setState(() => _isLoading = true);
                await Permission.location.request();
                await Repository.instance.setCurrentLocation();
                if (context.mounted) {
                  _goToLogin(context);
                  setState(() => _isLoading = true);
                }
              },
              child: Builder(builder: (context) {
                if (_isLoading) {
                  return const CircularProgressIndicator(color: Colors.white);
                }
                return Text(appLocalizations.permit);
              }),
            ),
          ),
          6.emptyHeight,
          TextButton(
            onPressed: () => _goToLogin(context),
            child: Text(appLocalizations.skipStep),
          ),
        ],
      ),
    );
  }

  void _goToLogin(BuildContext context) {
    Repository.instance.setLocationPreferences();
    Navigator.pushReplacementNamed(
      context,
      Routes.login,
    );
  }
}
