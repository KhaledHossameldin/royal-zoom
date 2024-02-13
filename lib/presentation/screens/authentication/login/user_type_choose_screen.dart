import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../core/utils/ui/snackbar/custom_snack_bar.dart';

import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class UserTypeChooseScreen extends StatefulWidget {
  const UserTypeChooseScreen({super.key});

  @override
  State<UserTypeChooseScreen> createState() => _UserTypeChooseScreenState();
}

class _UserTypeChooseScreenState extends State<UserTypeChooseScreen> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.width),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Material(),
              SizedBox(width: 169.width, child: 'royake'.png),
              Column(
                children: [
                  Text(
                    appLocalizations.howEnterAccount,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: BrandColors.darkBlackGreen,
                    ),
                  ),
                  36.emptyHeight,
                  BlocConsumer<LoginCubit, LoginState>(
                    listenWhen: (o, n) =>
                        o.normalTypeState != n.normalTypeState,
                    buildWhen: (o, n) => o.normalTypeState != n.normalTypeState,
                    bloc: DIManager.findDep<LoginCubit>(),
                    listener: (context, state) {
                      final typeState = state.normalTypeState;
                      if (typeState is BaseFailState) {
                        CustomSnackbar.showErrorSnackbar(typeState.error!);
                      }
                      if (typeState is BaseSuccessState) {
                        DIManager.findNavigator()
                            .pushReplacementNamed(Routes.home);
                      }
                    },
                    builder: (context, state) {
                      return OutlinedButton(
                        onPressed: () {
                          DIManager.findDep<LoginCubit>().noramlLoginType();
                        },
                        child: state.normalTypeState is! BaseLoadingState
                            ? Text(appLocalizations.accountAsUser)
                            : const CircularProgressIndicator(),
                      );
                    },
                  ),
                  20.emptyHeight,
                  BlocConsumer<LoginCubit, LoginState>(
                    bloc: DIManager.findDep<LoginCubit>(),
                    listenWhen: (o, n) =>
                        o.consultantTypeState != n.consultantTypeState,
                    buildWhen: (o, n) =>
                        o.consultantTypeState != n.consultantTypeState,
                    listener: (context, state) {
                      final typeState = state.consultantTypeState;
                      if (typeState is BaseFailState) {
                        CustomSnackbar.showErrorSnackbar(typeState.error!);
                      }
                      if (typeState is BaseSuccessState) {
                        DIManager.findNavigator()
                            .pushReplacementNamed(Routes.home);
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.consultantTypeState is BaseSuccessState
                            ? null
                            : () => DIManager.findDep<LoginCubit>()
                                .consultantLoginType(),
                        child: Builder(builder: (context) {
                          if (state.consultantTypeState is BaseLoadingState) {
                            return const CircularProgressIndicator();
                          }
                          return Text(appLocalizations.accountAsConsultant);
                        }),
                      );
                    },
                  ),
                ],
              ),
              Text(appLocalizations.copyright, style: textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
