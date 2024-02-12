// ignore_for_file: unused_element

import '../../app/cubit/application_bloc.dart';
import '../../cubits/general/auth/auth_cubit.dart';
import '../../data/di/di_data.dart';
import '../../domain/usecases/register_usecase.dart';
import '../constants/app_colors.dart';
import '../navigator/app_navigator.dart';
import '../network/network_module.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DIManager {
  DIManager._();
  static Future<void> initDI() async {
    /// -------------- Setup -------------------
    injectDep(NetworkModule.provideDio());
    injectDep(ApplicationCubit());
    injectDep(AppNavigator());
    injectDep(AppColorsController());
    // data layer
    diData();

    ///  ----------------- usecases ----------------
    injectDep<IRegisterUsecase>(RegisterUseCase(findDep()));

    /// ------------------ cubits ----------------
    injectDep(AuthCubit(registerUsecase: findDep()));
  }

  static T findDep<T extends Object>() {
    return getIt<T>();
  }

  static AppNavigator findNavigator() {
    return findDep<AppNavigator>();
  }

  static AppColorsController findCC() {
    return findDep<AppColorsController>();
  }

  static ApplicationCubit findAC() {
    return findDep<ApplicationCubit>();
  }

  static dispose() {
    findAC().close();
  }
}

T injectDep<T extends Object>(T dependency) {
  getIt.registerSingleton<T>(dependency);
  return getIt<T>();
}
