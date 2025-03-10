import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';

import '../constants/routes.dart';
import '../cubits/add_new_major/add_new_major_cubit.dart';
import '../cubits/appointment_filter/appointments_filter_cubit.dart';
import '../cubits/appointments/appointments_cubit.dart';
import '../cubits/cancel_consultation/cancel_consultation_cubit.dart';
import '../cubits/change_appointment_date/change_appointment_date_cubit.dart';
import '../cubits/chat_messages/chat_messages_cubit.dart';
import '../cubits/chat_recording/chat_recording_cubit.dart';
import '../cubits/chats/chats_cubit.dart';
import '../cubits/consultants/consultants_cubit.dart';
import '../cubits/consultants_available_times/consultants_available_times_cubit.dart';
import '../cubits/consultation_recording/consultation_recording_cubit.dart';
import '../cubits/accept_date_change/accept_date_change_cubit.dart';
import '../cubits/customized_consultation/customized_consultation_cubit.dart';
import '../cubits/fast_consultation/fast_consultation_cubit.dart';
import '../cubits/favorite_consultants/favorite_consultants_cubit.dart';
import '../cubits/favorite_consultations/favorite_consultations_cubit.dart';
import '../cubits/filter/filter_cubit.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/invoice/invoice_cubit.dart';
import '../cubits/majors/majors_cubit.dart';
import '../cubits/notifications/notifications_cubit.dart';
import '../cubits/profile/profile_cubit.dart';
import '../cubits/search/search_cubit.dart';
import '../cubits/send_comment/send_comment_cubit.dart';
import '../cubits/show_consultant/show_consultant_cubit.dart';
import '../cubits/show_consultation/show_consultation_cubit.dart';
import '../cubits/update_consultation/update_consultation_cubit.dart';
import '../data/models/authentication/user_data.dart';
import '../data/models/consultations/details.dart';
import '../data/models/user_notification/user_notification.dart';
import '../domain/entities/consultant_major_entity.dart';
import '../presentation/screens/add_major_screen.dart';
import '../presentation/screens/authentication/login/login_screen.dart';
import '../presentation/screens/authentication/otp_screen.dart';
import '../presentation/screens/authentication/register/privacy_policy_screen.dart';
import '../presentation/screens/authentication/register/register_screen.dart';
import '../presentation/screens/authentication/register/success_screen.dart';
import '../presentation/screens/authentication/register/terms_and_conditions_details_screen.dart';
import '../presentation/screens/authentication/register/terms_and_conditions_screen.dart';
import '../presentation/screens/authentication/reset_password/details_screen.dart';
import '../presentation/screens/authentication/reset_password/reset_screen.dart';
import '../presentation/screens/authentication/reset_password/success_screen.dart';
import '../presentation/screens/authentication/login/user_type_choose_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/appointments/appointments_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/appointments/filter_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/consultants_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/contact_us_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/favorites_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/review_app_screen.dart';
import '../presentation/screens/bottom_appbar_screens/chats/pages/chat_details_screen.dart';
import '../presentation/screens/complete_payment/pages/payment_getway_screen.dart';
import '../presentation/screens/complete_payment/pages/payment_result_screen.dart';
import '../presentation/screens/consultations/online_meeting/online_meeting_screen.dart';
import '../presentation/screens/payments/pages/add_balance_to_wallet_screen.dart';
import '../presentation/screens/consultants/details_screen.dart';
import '../presentation/screens/consultants/filter_screen.dart';
import '../presentation/screens/consultants/report/report_screen.dart';
import '../presentation/screens/consultants/report/success_screen.dart';
import '../presentation/screens/bottom_appbar_screens/home_screen.dart';
import '../presentation/screens/consultations/change_time/choose_time_screen.dart';
import '../presentation/screens/consultations/change_time/success_screen.dart';
import '../presentation/screens/consultations/details_screen.dart';
import '../presentation/screens/consultations/filter_screen.dart';
import '../presentation/screens/edit_consultation/pages/edit_content.dart';
import '../presentation/screens/edit_consultation/edit_response_type.dart';
import '../presentation/screens/majors_and_experiences/major_and_experience.dart';
import '../presentation/screens/majors_and_experiences/verify_major_screen.dart';
import '../presentation/screens/my_orders/pages/my_orders_screen.dart';
import '../presentation/screens/notifications/details_screen.dart';
import '../presentation/screens/notifications/notifications_screen.dart';
import '../presentation/screens/payments/pages/filter_screen.dart';
import '../presentation/screens/payments/pages/payments_screen.dart';
import '../presentation/screens/permissions/location_permission_screen.dart';
import '../presentation/screens/permissions/notifications_permission_screen.dart';
import '../presentation/screens/bottom_appbar_screens/profile/about_screen.dart';
import '../presentation/screens/profile/profile_details_screen.dart';
import '../presentation/screens/search/results_screen.dart';
import '../presentation/screens/search/search_screen.dart';
import '../presentation/screens/send_consultations/customized/choose_consultant_screen.dart';
import '../presentation/screens/send_consultations/customized/choose_major_screen.dart';
import '../presentation/screens/send_consultations/customized/choose_price_screen.dart';
import '../presentation/screens/send_consultations/customized/choose_time_screen.dart';
import '../presentation/screens/send_consultations/customized/consultant_answer_screen.dart';
import '../presentation/screens/send_consultations/customized/content_screen.dart';
import '../presentation/screens/send_consultations/customized/filter_screen.dart';
import '../presentation/screens/send_consultations/fast/pages/choose_consultant_screen.dart';
import '../presentation/screens/send_consultations/fast/pages/consultant_answer_screen.dart';
import '../presentation/screens/send_consultations/fast/pages/content_screen.dart';
import '../presentation/screens/send_consultations/fast/pages/filter_screen.dart';
import '../presentation/screens/send_consultations/fast/pages/invoice_screen.dart';
import '../presentation/screens/send_consultations/fast/pages/sent_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.notificationsPermission:
        return MaterialPageRoute(
          builder: (context) => const NotificationsPermissionScreen(),
        );

      case Routes.locationPermission:
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
            username: arguments['username'].toString(),
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
      case null:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => HomeCubit()),
              BlocProvider(create: (context) => ConsultantsCubit()),
              BlocProvider(create: (context) => ChatsCubit()),
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
        final username = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ShowConsultantCubit(),
            child: ConsultantDetailsScreen(username: username),
          ),
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
          builder: (context) => BlocProvider(
            create: (context) => NotificationsCubit(),
            child: const NotificationsScreen(),
          ),
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

      case Routes.chooseFastConsultant:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ConsultantsCubit()),
              BlocProvider(create: (context) => FastConsultationCubit()),
            ],
            child: const ChooseFastConsultantScreen(),
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
            child: SendFastConsultantionFilterScreen(
                maxPrice: arguments['maxPrice'] as num),
          ),
        );

      case Routes.fastConsultationContent:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ConsultationRecordingCubit()),
            ],
            child: const FastConsultationContentScreen(),
          ),
        );

      case Routes.fastConsultantAnswer:
        return MaterialPageRoute(
          builder: (context) => const FastConsultantAnswerScreen(),
        );

      case Routes.consultationSent:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const FastConsultationSentScreen(),
        );

      case Routes.consultationsFilter:
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const ConsultationsFilterScreen(),
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
          builder: (context) => const ConsultationsResultsScreen(),
        );

      case Routes.consultationDetails:
        final arguments = settings.arguments as Map;
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.consultationDetails),
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ShowConsultationCubit()),
              BlocProvider(create: (context) => CancelConsultationCubit()),
              BlocProvider(create: (context) => DateChangeCubit()),
              BlocProvider(create: (context) => SendCommentCubit()),
            ],
            child: ConsultationDetailsScreen(
              id: arguments['id'] as int,
              player: arguments['player'] as AudioPlayer?,
            ),
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
        final notification = settings.arguments as UserNotification;
        return MaterialPageRoute(
          builder: (context) => NotificationDetailsScreen(
            notification: notification,
          ),
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

      case Routes.chooseMajor:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => MajorsCubit()),
              BlocProvider(create: (context) => CustomizedConsultationCubit()),
            ],
            child: const ChooseCustomizedMajorScreen(),
          ),
        );

      case Routes.chooseCustomizedConsultant:
        final arguments = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ConsultantsCubit()),
              BlocProvider.value(
                  value: arguments['cubit'] as CustomizedConsultationCubit),
            ],
            child: ChooseCustomizedConsultantScreen(
              mainMajorId: arguments['mainMajorId'] as int,
              subMajorId: arguments['subMajorId'] as int?,
            ),
          ),
        );

      case Routes.customizedConsultationContent:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ConsultationRecordingCubit()),
              BlocProvider.value(
                value: settings.arguments as CustomizedConsultationCubit,
              ),
            ],
            child: const CustomizedConsultationContentScreen(),
          ),
        );

      case Routes.customizedConsultantAnswer:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: settings.arguments as CustomizedConsultationCubit,
            child: const CustomizedConsultantAnswerScreen(),
          ),
        );

      case Routes.customizedChooseTime:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: settings.arguments as CustomizedConsultationCubit,
              ),
              BlocProvider(
                create: (context) => ConsultantsAvailableTimesCubit(),
              ),
            ],
            child: const ChooseCustomizedTimeScreen(),
          ),
        );

      case Routes.customizedChoosePrice:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: settings.arguments as CustomizedConsultationCubit,
            child: const CustomizedChoosePriceScreen(),
          ),
        );

      case Routes.customizedConsultantFilter:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: arguments['cubit'] as ConsultantsCubit),
              BlocProvider(create: (context) => ConsultantsFilterCubit()),
            ],
            child: CustomizedConsultantsFilterScreen(
              maxPrice: arguments['maxPrice'] as num,
              majorId: arguments['majorId'] as int,
            ),
          ),
        );

      case Routes.chatDetails:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ChatMessagesCubit()),
              BlocProvider(create: (context) => ChatRecordingCubit()),
            ],
            child: ChatDetailsScreen(
              id: arguments['id'],
              // type: arguments['type'],
              // account: arguments['account'],
              // chat: arguments['chat'],
            ),
          ),
        );

      case Routes.profile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProfileCubit(),
            child: ProfileDetailsScreen(
              userNotifier: settings.arguments as ValueNotifier<UserData?>,
            ),
          ),
        );

      case Routes.consultantsProfile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ConsultantsCubit(),
            child: const ConsultantsProfileScreen(),
          ),
        );

      case Routes.favorites:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => FavoriteConsultationsCubit()),
              BlocProvider(create: (context) => FavoriteConsultantsCubit()),
            ],
            child: const FavoritesScreen(),
          ),
        );

      case Routes.appointments:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AppointmentsCubit(),
            child: const AppointmentsScreen(),
          ),
        );

      case Routes.appointmentsFilter:
        final arguments = settings.arguments as AppointmentsCubit;
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: arguments),
              BlocProvider(create: (context) => AppointmentsFilterCubit()),
            ],
            child: const AppointmentsFilterScreen(),
          ),
        );

      case Routes.editConsultationContent:
        final args = settings.arguments as ConsultationDetails;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ConsultationRecordingCubit()),
            ],
            child: EditConsultationContent(
              consultation: args,
            ),
          ),
        );

      case Routes.editConsultantResponse:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => UpdateConsultationCubit(),
            child: const EditConsultantResponseType(),
          ),
        );

      case Routes.addMajor:
        return MaterialPageRoute<bool>(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => MajorsCubit()),
              BlocProvider(create: (context) => AddNewMajorCubit()),
            ],
            child: AddMajorScreen(
              major: settings.arguments as ConsultantMajorEntity?,
            ),
          ),
        );

      case Routes.userTypeChoose:
        return MaterialPageRoute(
          builder: (context) => const UserTypeChooseScreen(),
        );

      case Routes.majorAndExperience:
        return MaterialPageRoute(
          builder: (context) => const MajorAndExperienceScreen(),
        );
      case Routes.addBalanceToWalletScreen:
        return MaterialPageRoute(
            builder: (context) => const AddBalanceToWalletScreen());

      case Routes.verifyMajor:
        return MaterialPageRoute<bool>(
          builder: (context) => VerifyMajorScreen(
            majorId: settings.arguments as int,
          ),
        );
      case Routes.paymentGetway:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => PaymentGetWayScreen(
                  ndc: args['ndc'].toString(),
                  invoiceId: args['id'],
                ));

      case Routes.myOrders:
        return MaterialPageRoute(builder: (context) => const MyOrdersScreen());

      case Routes.invoiceScreen:
        final invoiceId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => InvoiceScreen(
            invoiceId: invoiceId,
          ),
        );
      case Routes.paymentResult:
        final invoiceId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => PaymentResultScreen(
            invoiceId: invoiceId,
          ),
        );

      case Routes.onlineMeeting:
        return MaterialPageRoute(
          builder: (context) => const OnlineMeetingScreen(),
        );

      default:
        Logger().d(settings.name);
        return null;
    }
  }
}
