import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/reset_password/reset_password_bloc.dart';
import 'constants/brand_colors.dart';
import 'constants/fonts.dart';
import 'constants/routes.dart';
import 'cubits/locale_cubit.dart';
import 'data/models/authentication/user.dart';
import 'data/services/repository.dart';
import 'localization/app_localizations_setup.dart';
import 'utilities/app_router.dart';

Future<List<dynamic>> _getStartValues() async {
  final repository = Repository.instance;
  final values = await Future.wait([
    repository.getLocalePreferences(),
    repository.getNotificationsPreferences(),
    repository.getLocationPreferences(),
    repository.setCurrentLocation(isFromMain: true),
  ]);
  String initialRoute = Routes.notificationsPermssion;
  final savedLocale = values[0] as String;
  final isNotification = (values[1] as bool);
  final isLocation = (values[2] as bool);
  final user = await Repository.instance.getUser();
  if (isNotification && isLocation) {
    if (user != null) {
      initialRoute = Routes.home;
    } else {
      initialRoute = Routes.login;
    }
  } else if (isNotification) {
    initialRoute = Routes.locationPermssion;
  }
  return [initialRoute, savedLocale, user];
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Repository.instance.initializePusher();
  final values = await _getStartValues();
  runApp(MyApp(
    initialRoute: values[0],
    savedLocale: values[1],
    user: values[2],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.initialRoute,
    required this.savedLocale,
    required this.user,
    super.key,
  });

  final String initialRoute;
  final String savedLocale;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit(Locale(savedLocale))),
        BlocProvider(create: (context) => AuthenticationBloc(user)),
        BlocProvider(create: (context) => ResetPasswordBloc()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, locale) => MaterialApp(
          title: 'Royake',
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          onGenerateRoute: AppRouter.instance.onGenerateRoute,
          supportedLocales: AppLocalizationsSetup.supportedLocales,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
          locale: locale,
          theme: _setTheme,
        ),
      ),
    );
  }

  ThemeData get _setTheme => ThemeData(
        fontFamily: Fonts.main,
        shadowColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: BrandColors.orange,
          secondary: BrandColors.orange,
        ),
        datePickerTheme: const DatePickerThemeData(
          rangePickerHeaderForegroundColor: BrandColors.darkBlackGreen,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          color: Colors.white,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            fontSize: 16.0,
            color: BrandColors.darkBlue,
            fontFamily: Fonts.main,
          ),
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: BrandColors.snowWhite,
          selectedColor: BrandColors.orange,
          secondaryLabelStyle: TextStyle(
            fontSize: 12.0,
            fontFamily: Fonts.main,
            color: Colors.white,
          ),
          labelStyle: TextStyle(
            fontSize: 12.0,
            fontFamily: Fonts.main,
            color: BrandColors.black,
          ),
        ),
        dividerTheme: const DividerThemeData(thickness: 2.0),
        cardTheme: CardTheme(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 11.0),
          unselectedLabelStyle: TextStyle(fontSize: 11.0),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
              transitionType: SharedAxisTransitionType.horizontal,
            ),
            TargetPlatform.android: SharedAxisPageTransitionsBuilder(
              transitionType: SharedAxisTransitionType.horizontal,
            ),
          },
        ),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          side: const BorderSide(
            width: 1.0,
            color: BrandColors.mediumGray,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: BrandColors.snowWhite,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(29.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(29.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        tabBarTheme: TabBarTheme(
          splashFactory: NoSplash.splashFactory,
          unselectedLabelColor: Colors.grey.shade800,
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.transparent,
          ),
          indicator: BoxDecoration(
            color: BrandColors.orange,
            borderRadius: BorderRadius.circular(26.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: const StadiumBorder(),
            minimumSize: const Size(double.infinity, 63.0),
            textStyle: const TextStyle(
              fontSize: 20.0,
              fontFamily: Fonts.main,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: const StadiumBorder(),
            minimumSize: const Size(double.infinity, 63.0),
            side: const BorderSide(color: BrandColors.orange),
            textStyle: const TextStyle(
              fontSize: 20.0,
              fontFamily: Fonts.main,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: BrandColors.darkGray,
            textStyle: const TextStyle(
              fontSize: 15.0,
              fontFamily: Fonts.main,
            ),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 33.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 30.0,
            color: BrandColors.black,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: TextStyle(
            fontSize: 27.0,
            color: BrandColors.darkGreen,
          ),
          headlineMedium: TextStyle(
            fontSize: 25.0,
            color: BrandColors.darkGreen,
          ),
          headlineSmall: TextStyle(
            fontSize: 20.0,
            color: BrandColors.darkGreen,
          ),
          titleLarge: TextStyle(
            fontSize: 18.0,
            color: BrandColors.mediumGreen,
          ),
          bodyLarge: TextStyle(
            fontSize: 16.0,
            color: BrandColors.orange,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
            color: BrandColors.gray,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: BrandColors.darkGray,
          ),
          labelSmall: TextStyle(
            fontSize: 10.0,
            color: BrandColors.darkGray,
          ),
          titleSmall: TextStyle(
            fontSize: 8.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
