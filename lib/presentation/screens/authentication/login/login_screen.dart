import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../core/utils/ui/snackbar/custom_snack_bar.dart';
import '../../../../data/enums/user_type.dart';
import '../../../../data/models/authentication/user.dart';
import '../../../../data/services/location_services.dart';
import '../../../../data/services/repository.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/countries.dart';
import '../../../../utilities/extensions.dart';
import '../../../../utilities/validators.dart';
import '../../../widgets/copyright.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late final TabController _controller;

  final _email = TextEditingController();
  final _emailKey = GlobalKey<FormFieldState>();
  final _phone = TextEditingController();
  final _phoneKey = GlobalKey<FormFieldState>();
  final _password = TextEditingController();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _isPhone = ValueNotifier<bool>(true);

  bool _isRemember = false;
  Country _country = LocationServices.instance.country;

  @override
  void initState() {
    Repository.instance.setCurrentLocation().then((value) =>
        setState(() => _country = LocationServices.instance.country));
    _controller = TabController(length: 2, vsync: this, initialIndex: 1);
    if (kDebugMode) {
      _controller.index = 0;
      _isPhone.value = false;
      _email.text = 'royake_test@mailinator.com';
      _password.text = '123456789';
    }
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _isPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: BrandColors.orange),
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              Routes.home,
            ),
            child: Text(appLocalizations.continueAsGuest),
          ),
          21.emptyWidth,
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(
                left: 34.width,
                right: 34.width,
                bottom: bottomViewPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 169.width,
                    child: 'royake'.png,
                  ),
                  Text(
                    appLocalizations.loginToAccount,
                    style: textTheme.headlineSmall,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: BrandColors.snowWhite,
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                    child: TabBar(
                      controller: _controller,
                      onTap: (value) => _isPhone.value = value == 1,
                      tabs: [
                        Tab(text: appLocalizations.email),
                        Tab(text: appLocalizations.phone),
                      ],
                    ),
                  ),
                  _buildLoginForm(),
                  _buildRemeberMe(),
                  Column(
                    children: [
                      _buildLoginButton(),
                      14.emptyHeight,
                      const _SwitchToRegisterButton(),
                    ],
                  ),
                  const CopyRight(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getUsername() =>
      _isPhone.value ? '+${_country.dialCode}${_phone.text}' : _email.text;

  bool _validateForm() {
    bool isValid = _passwordKey.currentState!.validate();
    if (_isPhone.value) {
      final isPhoneValid = _phoneKey.currentState!.validate();
      isValid = isValid && isPhoneValid;
    } else {
      final isEmailValid = _emailKey.currentState!.validate();
      isValid = isValid && isEmailValid;
    }
    return isValid;
  }

  // BlocConsumer<AuthenticationBloc, AuthenticationState> _buildLoginButton() {
  //   final appLocalizations = AppLocalizations.of(context);

  //   return BlocConsumer<AuthenticationBloc, AuthenticationState>(
  //     buildWhen: (previous, current) => current.step == 0,
  //     listenWhen: (previous, current) => current.step == 0,
  //     listener: (context, state) {
  //       if (state is AuthenticationError) {
  //         if (state.isOTP) {
  //           Navigator.pushNamed(
  //             context,
  //             Routes.otp,
  //             arguments: {
  //               'username': _getUsername(),
  //               'isRegister': true,
  //             },
  //           );
  //           return;
  //         }
  //         state.message.showSnackbar(
  //           context,
  //           color: Colors.red,
  //         );
  //       } else if (state is AuthenticationLoaded) {
  //         Navigator.pushReplacementNamed(
  //           context,
  //           (state.user?.data.type ?? UserType.normal) == UserType.normal
  //               ? Routes.home
  //               : Routes.userTypeChoose,
  //         );
  //       }
  //     },
  //     builder: (context, state) {
  //       return IgnorePointer(
  //         ignoring: state is AuthenticationLoading,
  //         child: ElevatedButton(
  //           onPressed: () {
  //             bool isValid = _validateForm();
  //             if (isValid) {
  //               context.read<AuthenticationBloc>().add(AuthenticationLogin(
  //                     context,
  //                     username: _getUsername(),
  //                     password: _password.text,
  //                     isRemember: _isRemember,
  //                   ));
  //             }
  //           },
  //           child: Builder(builder: (context) {
  //             if (state is AuthenticationLoading) {
  //               return const CircularProgressIndicator(
  //                 color: Colors.white,
  //               );
  //             }
  //             return Text(appLocalizations.login);
  //           }),
  //         ),
  //       );
  //     },
  //   );
  // }

  BlocConsumer<LoginCubit, LoginState> _buildLoginButton() {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<LoginCubit, LoginState>(
      // buildWhen: (previous, current) => current.step == 0,
      // listenWhen: (previous, current) => current.step == 0,
      bloc: DIManager.findDep<LoginCubit>(),
      listener: (context, state) {
        final login = state.loginState;
        if (login is BaseSuccessState) {
          DIManager.findNavigator().pushReplacementNamed(
            ((login.data as UserEntity).type ?? UserType.normal) ==
                    UserType.normal
                ? Routes.home
                : Routes.userTypeChoose,
          );
          return;
        }
        if (login is BaseFailState) {
          if (login.error!.code == 401) {
            DIManager.findNavigator().pushNamed(Routes.otp, arguments: {
              'username': _getUsername(),
              'isRegister': true,
            });
            return;
          }
          CustomSnackbar.showSnackbar(login.error?.message ?? '');
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state.loginState is BaseLoadingState,
          child: ElevatedButton(
            onPressed: () {
              bool isValid = _validateForm();
              if (isValid) {
                DIManager.findDep<LoginCubit>()
                    .login(_getUsername(), _password.text);
              }
            },
            child: Builder(builder: (context) {
              if (state.loginState is BaseLoadingState) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              }
              return Text(appLocalizations.login);
            }),
          ),
        );
      },
    );
  }

  ValueListenableBuilder<bool> _buildLoginForm() {
    final emailField = _EmailTextField(emailKey: _emailKey, email: _email);
    final phoneField = _buildPhoneTextField();

    return ValueListenableBuilder<bool>(
      valueListenable: _isPhone,
      builder: (context, value, child) => Column(
        children: [
          AnimatedCrossFade(
            firstChild: phoneField,
            secondChild: emailField,
            crossFadeState:
                value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: kTabScrollDuration,
          ),
          17.emptyHeight,
          _PasswordTextField(passwordKey: _passwordKey, password: _password),
        ],
      ),
    );
  }

  Column _buildPhoneTextField() {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appLocalizations.phone),
        7.emptyHeight,
        StatefulBuilder(
          builder: (context, setState) => Directionality(
            textDirection: TextDirection.ltr,
            child: TextFormField(
              key: _phoneKey,
              controller: _phone,
              textAlign: TextAlign.start,
              maxLength: _country.maxLength,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              validator: (value) => Validators.phone(
                context,
                phone: value!,
                length: _country.minLength,
              ),
              decoration: InputDecoration(
                prefixIcon: Container(
                  width: 120.width,
                  padding: EdgeInsetsDirectional.only(end: 12.width),
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => ListView.builder(
                          itemCount: countries.length,
                          itemBuilder: (context, index) {
                            final country = countries[index];
                            return ListTile(
                              onTap: () {
                                setState(() => _country = country);
                                Navigator.pop(context);
                              },
                              title: Text(
                                '${country.flag} +${country.dialCode} ${country.name}',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '+${_country.dialCode}',
                          textDirection: TextDirection.ltr,
                        ),
                        5.emptyWidth,
                        Text(
                          _country.flag,
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildRemeberMe() {
    final appLocalizations = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: StatefulBuilder(
            builder: (context, setState) => CheckboxListTile(
              value: _isRemember,
              title: Text(appLocalizations.rememberMe),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) => setState(() => _isRemember = value!),
            ),
          ),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, Routes.resetPasswordDetails),
          style: TextButton.styleFrom(
            foregroundColor: BrandColors.orange,
          ),
          child: Text(appLocalizations.resetPassword),
        ),
      ],
    );
  }
}

class _SwitchToRegisterButton extends StatelessWidget {
  const _SwitchToRegisterButton();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return TextButton(
      onPressed: () => Navigator.pushNamed(context, Routes.register),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: appLocalizations.dontHaveAccount,
              style: textTheme.bodyLarge!.copyWith(color: BrandColors.black),
            ),
            TextSpan(
              text: ' ${appLocalizations.registerNowFree}',
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    required TextEditingController email,
    required GlobalKey<FormFieldState> emailKey,
  })  : _email = email,
        _key = emailKey;

  final TextEditingController _email;
  final GlobalKey<FormFieldState> _key;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appLocalizations.email),
        7.emptyHeight,
        TextFormField(
          key: _key,
          controller: _email,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => Validators.email(context, email: value!),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
      ],
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required TextEditingController password,
    required GlobalKey<FormFieldState> passwordKey,
  })  : _password = password,
        _key = passwordKey;

  final TextEditingController _password;
  final GlobalKey<FormFieldState> _key;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appLocalizations.password),
        7.emptyHeight,
        StatefulBuilder(
          builder: (context, setState) => TextFormField(
            key: widget._key,
            obscureText: _isObscure,
            controller: widget._password,
            obscuringCharacter: '*',
            keyboardType: TextInputType.visiblePassword,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            validator: (value) =>
                Validators.password(context, password: value!),
            decoration: InputDecoration(
              errorMaxLines: 3,
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                splashRadius: 0.01,
                onPressed: () => setState(
                  () => _isObscure = !_isObscure,
                ),
                icon: Icon(
                  _isObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
