import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/authentication_bloc.dart';
import '../../../constants/brand_colors.dart';
import '../../../constants/routes.dart';
import '../../../cubits/switch/switch_cubit.dart';
import '../../../data/enums/user_type.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

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
                  OutlinedButton(
                    onPressed: () {
                      context.read<SwitchCubit>().set(
                            data: context.read<AuthenticationBloc>().user!.data,
                            type: UserType.normal,
                          );
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.home,
                      );
                    },
                    child: Text(appLocalizations.accountAsUser),
                  ),
                  20.emptyHeight,
                  BlocConsumer<SwitchCubit, SwitchState>(
                    listener: (context, state) {
                      if (state is SwitchError) {
                        state.message.showSnackbar(
                          context,
                          color: BrandColors.red,
                        );
                      }
                      if (state is SwitchLoaded) {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.home,
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is SwitchLoading
                            ? null
                            : () => context.read<SwitchCubit>().convert(
                                  context,
                                  type: UserType.consultant,
                                ),
                        child: Builder(builder: (context) {
                          if (state is SwitchLoading) {
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
