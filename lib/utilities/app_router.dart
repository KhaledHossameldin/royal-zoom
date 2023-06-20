import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/routes.dart';
import '../cubits/consultants/consultants_cubit.dart';
import '../cubits/filter/filter_cubit.dart';
import '../data/models/consultants/consultant.dart';
import '../presentation/screens/authentication/login_screen.dart';
import '../presentation/screens/authentication/otp_screen.dart';
import '../presentation/screens/authentication/register/privacy_policy_screen.dart';
import '../presentation/screens/authentication/register/register_screen.dart';
import '../presentation/screens/authentication/register/success_screen.dart';
import '../presentation/screens/authentication/register/terms_and_conditions_details_screen.dart';
import '../presentation/screens/authentication/register/terms_and_conditions_screen.dart';
import '../presentation/screens/authentication/reset_password/details_screen.dart';
import '../presentation/screens/authentication/reset_password/reset_screen.dart';
import '../presentation/screens/authentication/reset_password/success_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/contact_us_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/review_app_screen.dart';
import '../presentation/screens/consultants/details_screen.dart';
import '../presentation/screens/consultants/filter_screen.dart';
import '../presentation/screens/consultants/report/report_screen.dart';
import '../presentation/screens/consultants/report/success_screen.dart';
import '../presentation/screens/bottom_appbar_screens/home_screen.dart';
import '../presentation/screens/notifications_screen.dart';
import '../presentation/screens/permissions/location_permission_screen.dart';
import '../presentation/screens/permissions/notifications_permission_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/about_screen.dart';
import '../presentation/screens/send_consultations/normal/choose_consultant_screen.dart';
import '../presentation/screens/send_consultations/normal/content_screen.dart';
import '../presentation/screens/send_consultations/normal/filter_screen.dart';

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
          builder: (context) => LocationPermissionScreen(),
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
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ConsultantsCubit(),
            child: const HomeScreen(),
          ),
        );

      case Routes.termsAndConditions:
        final arguments = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (context) => TermsAndConditions(isGuest: arguments),
        );

      case Routes.privacyPolicy:
        final arguments = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (context) => PrivacyPolicyScreen(isGuest: arguments),
        );

      case Routes.consultantFilter:
        final arguments = settings.arguments as ConsultantsCubit;
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => FilterCubit()),
              BlocProvider<ConsultantsCubit>.value(value: arguments),
            ],
            child: const ConsultantsFilterScreen(),
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

      case Routes.about:
        return MaterialPageRoute(builder: (context) => const AboutScreen());

      case Routes.contactUs:
        final arguments = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (context) => ContactUsScreen(isGuest: arguments),
        );

      case Routes.termsAndConditionsDetails:
        final isGuest = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (context) => TermsAndConditionsDetailsScreen(
            isGuest: isGuest,
          ),
        );

      case Routes.reviewApp:
        return MaterialPageRoute(builder: (context) => const ReviewAppScreen());

      case Routes.chooseConsultant:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ConsultantsCubit(),
            child: const ChooseConsultantScreen(),
          ),
        );

      case Routes.sendConsultationFilter:
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const SendConsultantionFilterScreen(),
        );

      case Routes.consultationContent:
        return MaterialPageRoute(
          builder: (context) => const ConsultationContentScreen(),
        );

      default:
        return null;
    }
  }
}
