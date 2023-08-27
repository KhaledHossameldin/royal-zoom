import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/routes.dart';
import '../cubits/change_appointment_date/change_appointment_date_cubit.dart';
import '../cubits/consultants/consultants_cubit.dart';
import '../cubits/consultants_available_times/consultants_available_times_cubit.dart';
import '../cubits/consultation_recording/consultation_recording_cubit.dart';
import '../cubits/consultations/consultations_cubit.dart';
import '../cubits/fast_consultation/fast_consultation_cubit.dart';
import '../cubits/filter/filter_cubit.dart';
import '../cubits/invoice/invoice_cubit.dart';
import '../cubits/search/search_cubit.dart';
import '../cubits/show_consultation/show_consultation_cubit.dart';
import '../data/models/consultants/consultant.dart';
import '../data/models/consultations/details.dart';
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
import '../presentation/screens/consultations/change_time/choose_time_screen.dart';
import '../presentation/screens/consultations/change_time/success_screen.dart';
import '../presentation/screens/consultations/details_screen.dart';
import '../presentation/screens/consultations/filter_screen.dart';
import '../presentation/screens/notifications/details_screen.dart';
import '../presentation/screens/notifications/notifications_screen.dart';
import '../presentation/screens/payments/filter_screen.dart';
import '../presentation/screens/payments/payments_screen.dart';
import '../presentation/screens/permissions/location_permission_screen.dart';
import '../presentation/screens/permissions/notifications_permission_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/about_screen.dart';
import '../presentation/screens/search/results_screen.dart';
import '../presentation/screens/search/search_screen.dart';
import '../presentation/screens/send_consultations/fast/choose_consultant_screen.dart';
import '../presentation/screens/send_consultations/fast/consultant_answer_screen.dart';
import '../presentation/screens/send_consultations/fast/content_screen.dart';
import '../presentation/screens/send_consultations/fast/filter_screen.dart';
import '../presentation/screens/send_consultations/fast/sent_screen.dart';

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
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ConsultantsCubit()),
              BlocProvider(create: (context) => ConsultationsCubit()),
            ],
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
              BlocProvider(create: (context) => ConsultantsFilterCubit()),
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
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ConsultantsCubit()),
              BlocProvider(create: (context) => FastConsultationCubit()),
            ],
            child: const ChooseConsultantScreen(),
          ),
        );

      case Routes.sendConsultationFilter:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute<int>(
          fullscreenDialog: true,
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ConsultantsFilterCubit()),
              BlocProvider<ConsultantsCubit>.value(
                  value: arguments['cubit'] as ConsultantsCubit),
            ],
            child: SendConsultantionFilterScreen(
                maxPrice: arguments['maxPrice'] as num),
          ),
        );

      case Routes.consultationContent:
        final cubit = settings.arguments as FastConsultationCubit;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ConsultationRecordingCubit()),
              BlocProvider.value(value: cubit),
            ],
            child: const ConsultationContentScreen(),
          ),
        );

      case Routes.consultantAnswer:
        final cubit = settings.arguments as FastConsultationCubit;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: const ConsultantAnswerScreen(),
          ),
        );

      case Routes.consultationSent:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ConsultationSentScreen(),
        );

      case Routes.consultationsFilter:
        final cubit = settings.arguments as ConsultationsCubit;
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: const ConsultationsFilterScreen(),
          ),
        );

      case Routes.search:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SearchCubit(),
            child: const SearchScreen(),
          ),
        );

      case Routes.consultationsResults:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => ConsultationsCubit(),
            child: const ConsultationsResultsScreen(),
          ),
        );

      case Routes.consultationDetails:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.consultationDetails),
          builder: (context) => BlocProvider(
            create: (context) => ShowConsultationCubit(),
            child: ConsultationDetailsScreen(id: id),
          ),
        );

      case Routes.editTimeChoose:
        final consultation = settings.arguments as ConsultationDetails;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ChangeAppointmentDateCubit()),
              BlocProvider(
                create: (context) => ConsultantsAvailableTimesCubit(),
              ),
            ],
            child: EditTimeChooseScreen(consultation: consultation),
          ),
        );

      case Routes.editTimeChooseSuccess:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => ChangeConsultationTimeSuccess(id: id),
        );

      case Routes.notificationDetails:
        return MaterialPageRoute(
          builder: (context) => const NotificationDetailsScreen(),
        );

      case Routes.payments:
        return MaterialPageRoute(builder: (context) => const PaymentsScreen());

      case Routes.paymentsFilter:
        final arguments = settings.arguments as Map;
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => BlocProvider<InvoiceCubit>.value(
            value: arguments['cubit'],
            child: PaymentsFilterScreen(maxPrice: arguments['price']),
          ),
        );

      default:
        return null;
    }
  }
}
