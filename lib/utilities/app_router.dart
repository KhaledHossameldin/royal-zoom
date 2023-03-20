import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../presentation/screens/authentication/login_screen.dart';
import '../presentation/screens/permissions/location_permission_screen.dart';
import '../presentation/screens/permissions/notifications_permission_screen.dart';

class AppRouter {
  static AppRouter instance = AppRouter._();

  AppRouter._();

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.notificationsPermssion:
        return MaterialPageRoute(
          builder: (context) => const NotificationsPermissionScreen(),
        );

      case Routes.locationPermssion:
        return MaterialPageRoute(
          builder: (context) => const LocationPermissionScreen(),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      default:
        return null;
    }
  }
}
