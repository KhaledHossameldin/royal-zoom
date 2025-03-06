import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_consts.dart';
import '../../core/constants/app_font.dart';
import '../../core/constants/app_style.dart';

import '../../core/di/di_manager.dart';
import '../../core/localization/translations.dart';
import '../../core/navigator/route_generator.dart';
import '../../core/utils/screen_utils/device_utils.dart';
import '../core/navigator/app_navigator_observer.dart';
import 'cubit/application_bloc.dart';
import 'cubit/application_state.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ApplicationCubit>(
              create: (cxt) => DIManager.findDep<ApplicationCubit>()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(376, 812),
          builder: (context, _) {
            return BlocConsumer<ApplicationCubit, ApplicationState>(
                listener: (_, __) {},
                buildWhen: (s0, s1) {
                  return false;
                },
                listenWhen: (s0, s1) {
                  return false;
                },
                builder: (_, appState) {
                  return GetMaterialApp(
                    enableLog: false,
                    navigatorObservers: [AppNavigatorObserver()],
                    onGenerateRoute: RouteGenerator.generateRoutes,
                    debugShowCheckedModeBanner: false,
                    builder: (BuildContext context, Widget? widget) {
                      ScreenHelper(context);
                      return const Placeholder();
                    },
                    theme: ThemeData(
                      textTheme:
                          AppFont.getTextTheme(Theme.of(context).textTheme),
                      tabBarTheme: TabBarTheme(
                        labelColor: DIManager.findDep<AppColorsController>()
                            .primaryColor,
                        unselectedLabelColor:
                            DIManager.findDep<AppColorsController>()
                                .greyTextColor,
                        labelStyle: AppStyle.tabBarLabelStyle,
                        unselectedLabelStyle:
                            AppStyle.tabBarUnselectedLabelStyle,
                      ),
                      primaryColor:
                          DIManager.findDep<AppColorsController>().primaryColor,
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              DIManager.findDep<AppColorsController>()
                                  .textButtonBackground,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      // colorScheme: ColorScheme(
                      //     background: DIManager.findDep<AppColorsController>()
                      //         .scaffoldBGColor),
                    ),
                    title: AppConsts.appName,

                    translations: AppTranslations(),
                    // locale: DIManager.findDep<ApplicationCubit>().appLanguage,
                    // locale: Locale(AppConsts.LANG_AR),
                    fallbackLocale: const Locale(AppConsts.LANG_DEFAULT),
                    // supportedLocales: DIManager.findDep<ApplicationCubit>()
                    //     .supportedLanguages,
                    localizationsDelegates: const [
                      // Built-in localization of basic text for Material widgets
                      GlobalMaterialLocalizations.delegate,
                      // Built-in localization for text direction LTR/RTL
                      GlobalWidgetsLocalizations.delegate,
                      // Built-in localization of basic text for Cupertino widgets
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    // initialRoute: SplashPage.routeName,
                  );
                });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    DIManager.dispose();
    super.dispose();
  }
}
