import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../core/utils/ui/snackbar/custom_snack_bar.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';
import '../../../../data/enums/email_phone.dart';
import '../../../../data/services/location_services.dart';
import '../../../../data/services/repository.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/countries.dart';
import '../../../../utilities/extensions.dart';
import '../../../../utilities/validators.dart';
import '../../../widgets/copyright.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Country _country = LocationServices.instance.country;
  EmailPhone _emailPhone = EmailPhone.none;

  @override
  void initState() {
    Repository.instance.setCurrentLocation().then((value) =>
        setState(() => _country = LocationServices.instance.country));
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final viewPadding = MediaQuery.of(context).viewPadding;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(
                left: 34.width,
                right: 34.width,
                bottom: viewPadding.bottom,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 169.width,
                    child: 'royake'.png,
                  ),
                  Text(
                    appLocalizations.registerTitle,
                    style: textTheme.headlineLarge,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEmailPhoneTextField(),
                        13.emptyHeight,
                        _PasswordTextField(
                          title: appLocalizations.password,
                          controller: _password,
                        ),
                        13.emptyHeight,
                        _PasswordTextField(
                          title: appLocalizations.confirmPassword,
                          controller: _confirm,
                        ),
                        13.emptyHeight,
                        const _TermsListTile(),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      _buildConfirmButton(),
                      14.emptyHeight,
                      const _SwitchToLoginButton(),
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

  // BlocConsumer<AuthenticationBloc, AuthenticationState> _buildConfirmButton() {
  //   final appLocalizations = AppLocalizations.of(context);

  //   return BlocConsumer<AuthenticationBloc, AuthenticationState>(
  //     buildWhen: (previous, current) => current.step == 1,
  //     listenWhen: (previous, current) => current.step == 1,
  //     listener: (context, state) {
  //       if (state is AuthenticationError) {
  //         state.message.showSnackbar(
  //           context,
  //           color: Colors.red,
  //         );
  //       } else if (state is AuthenticationLoaded) {
  //         Navigator.pushNamed(
  //           context,
  //           Routes.otp,
  //           arguments: {
  //             'username': _getUsername(),
  //             'isRegister': true,
  //           },
  //         );
  //       }
  //     },
  //     builder: (context, state) {
  //       return IgnorePointer(
  //         ignoring: state is AuthenticationLoading,
  //         child: ElevatedButton(
  //           onPressed: () {
  //             final isValid = _formKey.currentState!.validate();
  //             if (isValid) {
  //               context.read<AuthenticationBloc>().add(AuthenticationRegister(
  //                     context,
  //                     username: _getUsername(),
  //                     password: _password.text,
  //                     confirm: _confirm.text,
  //                   ));
  //             }
  //           },
  //           child: Builder(builder: (context) {
  //             if (state is AuthenticationLoading) {
  //               return const CircularProgressIndicator(
  //                 color: Colors.white,
  //               );
  //             }
  //             return Text(appLocalizations.register);
  //           }),
  //         ),
  //       );
  //     },
  //   );
  // }
  BlocConsumer<RegisterCubit, RegisterState> _buildConfirmButton() {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<RegisterCubit, RegisterState>(
      // buildWhen: (previous, current) => current.step == 1,
      // listenWhen: (previous, current) => current.step == 1,
      bloc: DIManager.findDep<RegisterCubit>(),
      listener: (context, state) {
        final register = state.registerState;
        if (register is BaseFailState) {
          // state.message.showSnackbar(
          //   context,
          //   color: Colors.red,
          // );
          CustomSnackbar.showErrorSnackbar(register.error!);
        } else if (register is BaseSuccessState) {
          Navigator.pushNamed(
            context,
            Routes.otp,
            arguments: {
              'username': _getUsername(),
              'isRegister': true,
            },
          );
        }
      },
      builder: (context, state) {
        final register = state.registerState;
        return IgnorePointer(
          ignoring: register is BaseLoadingState,
          child: ElevatedButton(
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                DIManager.findDep<RegisterCubit>().register(
                  username: _getUsername(),
                  password: _password.text,
                  confirm: _confirm.text,
                );
              }
            },
            child: Builder(builder: (context) {
              if (register is BaseLoadingState) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              }
              return Text(appLocalizations.register);
            }),
          ),
        );
      },
    );
  }

  String _getUsername() {
    String username = _username.text;
    if (_emailPhone == EmailPhone.phone) {
      return '+${_country.dialCode}$username';
    }
    return username;
  }

  Column _buildEmailPhoneTextField() {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appLocalizations.emailOrPhone),
        7.emptyHeight,
        StatefulBuilder(
          builder: (context, setState) => TextFormField(
            controller: _username,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            validator: (value) => Validators.phoneEmail(
              context,
              emailPhone: _emailPhone,
              username: _username.text,
              length: _country.minLength,
            ),
            maxLength:
                _emailPhone == EmailPhone.phone ? _country.maxLength : null,
            decoration: InputDecoration(
              prefixIcon: _emailPhone == EmailPhone.email
                  ? const Icon(Icons.email_outlined)
                  : null,
              suffixIcon: _emailPhone == EmailPhone.phone
                  ? Container(
                      width: 120.width,
                      padding: EdgeInsetsDirectional.only(
                        end: 12.width,
                      ),
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
                                    '${country.flag} +${country.name} ${country.dialCode}',
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
                    )
                  : null,
            ),
            textAlign: _emailPhone == EmailPhone.phone
                ? TextAlign.end
                : TextAlign.start,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() => _emailPhone = EmailPhone.none);
                return;
              }
              final number = int.tryParse(value[0]);
              if (number == null) {
                setState(() => _emailPhone = EmailPhone.email);
                return;
              }
              setState(() => _emailPhone = EmailPhone.phone);
            },
          ),
        ),
      ],
    );
  }
}

class _TermsListTile extends StatelessWidget {
  const _TermsListTile();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return FormField<bool>(
      initialValue: false,
      validator: (value) => Validators.termsAndPolicy(
        context,
        value!,
      ),
      builder: (field) {
        final orangeTextTheme = theme.textTheme.bodySmall!.copyWith(
          color: BrandColors.orange,
          fontWeight: FontWeight.normal,
        );
        final buttonStyle = TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 6.width),
        );
        return CheckboxListTile(
          value: field.value ?? false,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (value) => field.didChange(value),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(
              color: field.hasError ? Colors.red : Colors.transparent,
            ),
          ),
          title: FittedBox(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: appLocalizations.acceptTerms,
                    style: orangeTextTheme,
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Routes.privacyPolicy,
                        arguments: false,
                      ),
                      style: buttonStyle,
                      child: Text(
                        appLocalizations.privacyPolicy,
                        style: orangeTextTheme.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(text: appLocalizations.and, style: orangeTextTheme),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Routes.termsAndConditions,
                        arguments: false,
                      ),
                      style: buttonStyle,
                      child: Text(
                        appLocalizations.termsOfUse,
                        style: orangeTextTheme.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          subtitle: field.errorText != null
              ? Text(
                  field.errorText!,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.error,
                  ),
                )
              : null,
        );
      },
    );
  }
}

class _SwitchToLoginButton extends StatelessWidget {
  const _SwitchToLoginButton();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: appLocalizations.haveAccount,
              style: textTheme.bodyLarge!.copyWith(color: BrandColors.black),
            ),
            TextSpan(
              text: ' ${appLocalizations.login}',
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required String title,
    required TextEditingController controller,
  })  : _title = title,
        _password = controller;

  final String _title;
  final TextEditingController _password;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget._title),
        7.emptyHeight,
        StatefulBuilder(
          builder: (context, setState) => TextFormField(
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
                onPressed: () => setState(() => _isObscure = !_isObscure),
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
