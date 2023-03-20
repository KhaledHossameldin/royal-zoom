import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'constants/brand_colors.dart';
import 'constants/routes.dart';
import 'cubits/locale_cubit.dart';
import 'data/services/repository.dart';
import 'localization/app_localizations_setup.dart';
import 'utilities/app_router.dart';

Future<List<String>> _getStartValues() async {
  final values = await Future.wait([
    Repositroy.instance.getLocalePreferences(),
    Permission.notification.status,
    Permission.location.status,
  ]);
  String initialRoute = Routes.notificationsPermssion;
  final savedLocale = values[0] as String;
  final isNotification =
      (values[1] as PermissionStatus) != PermissionStatus.denied;
  final isLocation = (values[2] as PermissionStatus) != PermissionStatus.denied;
  if (isNotification && isLocation) {
    initialRoute = Routes.login;
  } else if (isNotification) {
    initialRoute = Routes.locationPermssion;
  }
  return [initialRoute, savedLocale];
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final values = await _getStartValues();
  runApp(MyApp(initialRoute: values[0], savedLocale: values[1]));
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.initialRoute,
    required this.savedLocale,
    super.key,
  });

  final String initialRoute;
  final String savedLocale;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleCubit(Locale(savedLocale)),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, locale) {
          return MaterialApp(
            title: 'Royake',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Droid Arabic Kufi',
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: BrandColors.orange,
                secondary: BrandColors.orange,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(double.infinity, 63.0),
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Droid Arabic Kufi',
                  ),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  shape: const StadiumBorder(),
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Droid Arabic Kufi',
                  ),
                ),
              ),
              textTheme: const TextTheme(
                headlineSmall: TextStyle(
                  fontSize: 27.0,
                  color: BrandColors.darkGreen,
                ),
                titleLarge: TextStyle(
                  fontSize: 18.0,
                  color: BrandColors.gray,
                ),
              ),
            ),
            initialRoute: initialRoute,
            onGenerateRoute: AppRouter.instance.onGenerateRoute,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            locale: locale,
          );
        },
      ),
    );
  }
}
