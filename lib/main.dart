import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royake_mobile/constants/brand_colors.dart';

import 'cubits/locale_cubit.dart';
import 'data/services/repository.dart';
import 'localization/app_localizations_setup.dart';
import 'utilities/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedLocale = await Repositroy.instance.getLocale();
  runApp(MyApp(savedLocale: savedLocale));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.savedLocale, super.key});

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
            ),
            initialRoute: null,
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
