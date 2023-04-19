import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/routes.dart';
import '../cubits/consultants/consultants_cubit.dart';
import '../cubits/filter/filter_cubit.dart';
import '../data/models/consultant.dart';
import '../presentation/screens/authentication/login_screen.dart';
import '../presentation/screens/authentication/otp_screen.dart';
import '../presentation/screens/authentication/register/privacy_policy_screen.dart';
import '../presentation/screens/authentication/register/register_screen.dart';
import '../presentation/screens/authentication/register/success_screen.dart';
import '../presentation/screens/authentication/register/terms_and_conditions_screen.dart';
import '../presentation/screens/authentication/reset_password/details_screen.dart';
import '../presentation/screens/authentication/reset_password/reset_screen.dart';
import '../presentation/screens/authentication/reset_password/success_screen.dart';
import '../presentation/screens/guest/consultants/details_screen.dart';
import '../presentation/screens/guest/consultants/filter_screen.dart';
import '../presentation/screens/guest/consultants/report/report_screen.dart';
import '../presentation/screens/guest/consultants/report/success_screen.dart';
import '../presentation/screens/guest/guest_screen.dart';
import '../presentation/screens/guest/notifications_screen.dart';
import '../presentation/screens/home_screen.dart';
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
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case Routes.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());

      case Routes.resetPasswordDetails:
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordDetailsScreen(),
        );

      case Routes.otp:
        final arguments = settings.arguments as Map<String, Object>;
        return MaterialPageRoute(
          builder: (context) => OTPScreen(
            username: arguments['username'] as String,
            isRegister: arguments['isRegister'] as bool,
          ),
          settings: settings,
        );

      case Routes.resetPassword:
        final arguments = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (context) => ResetScreen(
            username: arguments[0],
            code: arguments[1],
          ),
          settings: settings,
        );

      case Routes.resetPasswordSuccess:
        return MaterialPageRoute(
          builder: (context) => const ResetSuccessScreen(),
        );

      case Routes.registerSuccess:
        return MaterialPageRoute(
          builder: (context) => const RegisterSuccessScreen(),
        );

      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case Routes.termsAndConditions:
        return MaterialPageRoute(
          builder: (context) => const TermsAndConditions(),
        );

      case Routes.privacyPolicy:
        return MaterialPageRoute(
          builder: (context) => const PrivacyPolicyScreen(),
        );

      case Routes.guestHome:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ConsultantsCubit(),
            child: const GuestScreen(),
          ),
        );

      case Routes.filter:
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => BlocProvider(
            create: (context) => FilterCubit(),
            child: const FilterScreen(),
          ),
        );

      case Routes.consultantDetails:
        final consultant = settings.arguments as Consultant;
        return MaterialPageRoute(
          builder: (context) => ConsultantDetailsScreen(consultant: consultant),
        );

      case Routes.consultantReport:
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const ConsultantReportScreen(),
        );

      case Routes.consultantReportSuccess:
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const ReportConsultantSuccessScreen(),
        );

      case Routes.notifications:
        return MaterialPageRoute(
          builder: (context) => const NotificationsScreen(),
        );

      default:
        return null;
    }
  }
}
