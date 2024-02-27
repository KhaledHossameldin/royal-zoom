// ignore_for_file: unused_element

import 'package:flutter/material.dart';

import '../../app/cubit/application_bloc.dart';
import '../../data/repositories_impl/consultant/balance_repo_impl.dart';
import '../../data/repositories_impl/consultant/major_repo_impl.dart';
import '../../data/repositories_impl/general/auth_repo_impl.dart';
import '../../data/repositories_impl/general/medi_repo_impl.dart';
import '../../data/repositories_impl/general/profile_repo_impl.dart';
import '../../data/sources/local/shared_prefs.dart';
import '../../data/sources/remote/consultant/balance/balance_remote_data_source.dart';
import '../../data/sources/remote/consultant/major/major_remote_data_source.dart';
import '../../data/sources/remote/general/auth/auth_remote_data_source.dart';
import '../../data/sources/remote/general/media/media_remote_data_source.dart';
import '../../data/sources/remote/general/profile/profile_remote_data_source.dart';
import '../../data/sources/remote/general/world/world_remote_data_source.dart';
import '../../data/sources/remote/user/home_statistics/statistics_remote_data_source.dart';
import '../../data/sources/remote/user/invoices/invoices_remote_data_source.dart';
import '../../domain/repositories/consultant/major_repo_i.dart';
import '../../domain/repositories/consultant/balance_repo_i.dart';
import '../../domain/repositories/general/auth_repo_i.dart';
import '../../domain/repositories/general/media_repo_i.dart';
import '../../domain/repositories/general/profile_repo_i.dart';
import '../../domain/usecases/change_consultant_major_status_usecase.dart';
import '../../domain/usecases/consultant_majors_usecase.dart';
import '../../domain/usecases/delete_consultant_major_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/major_verification_request_usecase.dart';
import '../../domain/usecases/new_major_requests_usecase.dart';
import '../../domain/usecases/profile_usecase.dart';
import '../../domain/usecases/update_consultant_major_usecase.dart';
import '../../domain/usecases/upload_file_usecase.dart';
import '../../domain/usecases/verify_consultant_major_usecase.dart';
import '../../localization/app_localizations.dart';
import '../../presentation/screens/authentication/login/cubit/login_cubit.dart';
import '../../presentation/screens/authentication/register/cubit/register_cubit.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../presentation/screens/majors_and_experiences/cubit/major_and_experience_cubit.dart';
import '../../domain/usecases/refund_request_usecase.dart';
import '../../domain/usecases/withdraw_request_usecase.dart';

import '../../presentation/screens/my_orders/cubit/my_orders_cubit.dart';
import '../constants/app_colors.dart';
import '../navigator/app_navigator.dart';
import '../network/network_module.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DIManager {
  DIManager._();
  static Future<void> initDI() async {
    /// -------------- Setup -------------------
    await _initSharedPrefs();
    _injectDep(NetworkModule.provideDio());
    _injectDep(ApplicationCubit());
    _injectDep(AppNavigator());
    _injectDep(AppColorsController());
    _injectDep(await AppLocalizations.delegate.load(const Locale('ar')));

    // data layer
    _injectDep(AuthRemoteDataSource());
    _injectDep(WorldRemoteDataSource());
    _injectDep(MediaRemoteDataSource());
    _injectDep(MajorRemoteDataSource());
    _injectDep(InvoicesRemoteDataSource());
    _injectDep(StatisticsDataSource());
    _injectDep(ProfileRemoteDataSource());
    _injectDep(BalanceRemoteDataSource());

    /// ------------------ repos ---------------------
    _injectDep<IAuthRepo>(AuthRepo(findDep(), findDep()));
    _injectDep<IProfileRepo>(ProfileRepo(findDep(), findDep()));
    _injectDep<IConsultantMajorRepo>(ConsultantMajorRepo(findDep()));
    _injectDep<IMediaRepo>(MediaRepo(findDep()));
    // _injectDep<IMajorRepo>(MajorRepo(findDep()));
    _injectDep<IBalanceRepo>(BalanceRepo(findDep()));

    ///  ----------------- usecases ----------------
    _injectDep<IRegisterUsecase>(RegisterUseCase(findDep()));
    _injectDep<ILoginUseCase>(LoginUseCase(findDep()));
    _injectDep<IProfileUseCase>(ProfileUseCase(findDep()));
    _injectDep<IUploadFileUseCase>(UploadFileUseCase(findDep()));
    _injectDep<IConsultantMajorsUsecase>(ConsultantMajorsUseCase(findDep()));
    _injectDep<IVerifyConsultantMajorUseCase>(
      VerifyConsultantMajorUseCase(findDep()),
    );
    _injectDep<IChangeConsultantMajorStatusUseCase>(
      ChangeConsultantMajorStatusUseCase(findDep()),
    );
    _injectDep<IUpdateConsultantMajorUseCase>(
      UpdateConsultantMajorUseCase(findDep()),
    );
    _injectDep<IDeleteConsultantMajorUseCase>(
      DeleteConsultantMajorUseCase(findDep()),
    );
    _injectDep<INewMajorRequestsUseCase>(NewMajorRequestUseCase(findDep()));
    _injectDep<IMajorVerificationRequestsUseCase>(
        MajorVerificationRequestUseCase(findDep()));
    _injectDep<IRefundRequestUseCase>(RefundRequestUseCase(findDep()));
    _injectDep<IWithdrawRequestUseCase>(WithdrawRequestUseCase(findDep()));

    /// ------------------ cubits ----------------
    _injectDep(RegisterCubit(registerUsecase: findDep()));
    _injectDep(LoginCubit(findDep(), findDep()));

    _injectDep(MajorAndExperienceCubit(
      consultantMajorsUsecase: findDep(),
      verifyConsultantMajorUseCase: findDep(),
      changeConsultantMajorStatusUseCase: findDep(),
      updateConsultantMajorUseCase: findDep(),
      deleteConsultantMajorUseCase: findDep(),
    ));
    _injectDep(MyOrdersCubit(findDep(), findDep(), findDep()));
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

  static Future<void> _initSharedPrefs() async {
    final prefs = SharedPrefs();
    await prefs.init();
    _injectDep(prefs);
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
