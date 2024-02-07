// ignore_for_file: unused_element

import '../../app/cubit/application_bloc.dart';
import '../../cubits/general/auth/auth_cubit.dart';
import '../../data/repositories_impl/general/auth_repo_impl.dart';
import '../../data/sources/general/auth/auth_remote_data_source.dart';
import '../../data/sources/general/media/media_remote_data_source.dart';
import '../../data/sources/general/world/world_remote_data_source.dart';
import '../../domain/repositories/general/auth_repo_i.dart';
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
    _injectDep(NetworkModule.provideDio());
    _injectDep(ApplicationCubit());
    _injectDep(AppNavigator());
    _injectDep(AppColorsController());

    /// --------------- remote data sources --------------
    _injectDep(AuthRemoteDataSource());
    _injectDep(WorldRemoteDataSource());
    _injectDep(MediaRemoteDataSource());

    /// ------------------ repos ---------------------
    _injectDep<IAuthRepo>(AuthRepo(findDep()));

    ///  ----------------- usecases ----------------
    _injectDep<IRegisterUsecase>(RegisterUseCase(findDep()));

    /// ------------------ cubits ----------------
    _injectDep(AuthCubit(registerUsecase: findDep()));
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

  static T _injectDep<T extends Object>(T dependency) {
    getIt.registerSingleton<T>(dependency);
    return getIt<T>();
  }

  static ApplicationCubit findAC() {
    return findDep<ApplicationCubit>();
  }

  static dispose() {
    findAC().close();
  }
}
