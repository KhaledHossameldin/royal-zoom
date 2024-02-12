// ignore_for_file: unused_element

import '../../app/cubit/application_bloc.dart';
import '../../data/repositories_impl/general/auth_repo_impl.dart';
import '../../data/sources/consultant/major/major_remote_data_source.dart';
import '../../data/sources/general/auth/auth_remote_data_source.dart';
import '../../data/sources/general/media/media_remote_data_source.dart';
import '../../data/sources/general/world/world_remote_data_source.dart';
import '../../data/sources/user/home_statistics/statistics_remote_data_source.dart';
import '../../data/sources/user/invoices/invoices_remote_data_source.dart';
import '../../domain/repositories/general/auth_repo_i.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentation/screens/authentication/login/cubit/login_cubit.dart';
import '../../presentation/screens/authentication/register/cubit/register_cubit.dart';
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
    // data layer
    _injectDep(AuthRemoteDataSource());
    _injectDep(WorldRemoteDataSource());
    _injectDep(MediaRemoteDataSource());
    _injectDep(MajorRemoteDataSource());
    _injectDep(InvoicesRemoteDataSource());
    _injectDep(StatisticsDataSource());

    /// ------------------ repos ---------------------
    _injectDep<IAuthRepo>(AuthRepo(findDep()));

    ///  ----------------- usecases ----------------
    _injectDep<IRegisterUsecase>(RegisterUseCase(findDep()));
    _injectDep<ILoginUseCase>(LoginUseCase(findDep()));

    /// ------------------ cubits ----------------
    _injectDep(RegisterCubit(registerUsecase: findDep()));
    _injectDep(LoginCubit(findDep()));
  }

  static T _injectDep<T extends Object>(T dependency) {
    getIt.registerSingleton<T>(dependency);
    return getIt<T>();
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
