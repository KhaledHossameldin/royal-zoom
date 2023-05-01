import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../blocs/authentication/authentication_bloc.dart';
import '../../../blocs/reset_password/reset_password_bloc.dart';
import '../../../constants/brand_colors.dart';
import '../../../constants/numbers.dart';
import '../../../constants/routes.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../../widgets/app_bar_logo.dart';
import '../../widgets/copyright.dart';
import '../../widgets/reset_password_image.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.username,
    required this.isRegister,
  });

  final String username;
  final bool isRegister;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otp = TextEditingController();
  final _seconds = ValueNotifier<int>(Numbers.otp);

  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _seconds.value--;
        if (_seconds.value <= 0) {
          timer.cancel();
        }
      },
    );
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _otp.dispose();
    _timer?.cancel();
    _seconds.dispose();
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
        actions: const [AppBarLogo(padding: 20)],
      ),
      body: Builder(builder: (context) {
        if (_timer == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return CustomScrollView(
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
                    const ResetPasswordImage(),
                    Text(
                      appLocalizations.otpTitle,
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge,
                    ),
                    Text(
                      appLocalizations.getOTPSubtitle(widget.username),
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: BrandColors.darkGray,
                      ),
                    ),
                    _OTPTextField(otp: _otp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(appLocalizations.didntReceiveCode),
                        8.emptyWidth,
                        StatefulBuilder(
                          builder: (context, setState) {
                            if (widget.isRegister) {
                              return _buildRegisterTimerButton();
                            }
                            return _buildResetTimerButton();
                          },
                        ),
                      ],
                    ),
                    Builder(
                      builder: (context) {
                        if (widget.isRegister) {
                          return _buildRegisterConfirmButton();
                        }
                        return _buildResetConfirmButton();
                      },
                    ),
                    const CopyRight(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  BlocConsumer<AuthenticationBloc, AuthenticationState>
      _buildRegisterConfirmButton() {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => !current.isResend! && current.step == 2,
      listenWhen: (previous, current) =>
          !current.isResend! && current.step == 2,
      listener: (context, state) {
        if (state is AuthenticationError) {
          state.message.showSnackbar(
            context,
            color: Colors.red,
          );
        } else if (state is AuthenticationLoaded) {
          Navigator.pushNamed(context, Routes.registerSuccess);
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is AuthenticationLoading,
          child: ElevatedButton(
            onPressed: () {
              if (_seconds.value <= 0) {
                appLocalizations.resetTimerDone.showSnackbar(
                  context,
                  color: Colors.red,
                );
                return;
              }
              context.read<AuthenticationBloc>().add(
                    AuthenticationActivate(
                      context,
                      username: widget.username,
                      code: _otp.text,
                    ),
                  );
            },
            child: Builder(builder: (context) {
              if (state is AuthenticationLoading) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              }
              return Text(appLocalizations.confirm);
            }),
          ),
        );
      },
    );
  }

  BlocConsumer<ResetPasswordBloc, ResetPasswordState>
      _buildResetConfirmButton() {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => !current.isResend! && current.step == 2,
      listenWhen: (previous, current) =>
          !current.isResend! && current.step == 2,
      listener: (context, state) {
        if (state is ResetPasswordError) {
          state.message.showSnackbar(
            context,
            color: Colors.red,
          );
        } else if (state is ResetPasswordLoaded) {
          Navigator.pushReplacementNamed(
            context,
            Routes.resetPassword,
            arguments: [widget.username, _otp],
          );
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is ResetPasswordLoading,
          child: ElevatedButton(
            onPressed: () {
              if (_seconds.value <= 0) {
                appLocalizations.resetTimerDone.showSnackbar(
                  context,
                  color: Colors.red,
                );
                return;
              }
              context.read<ResetPasswordBloc>().add(
                    ResetPasswordOTP(
                      context,
                      code: _otp.text,
                      username: widget.username,
                    ),
                  );
            },
            child: Builder(builder: (context) {
              if (state is ResetPasswordLoading) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              }
              return Text(appLocalizations.confirm);
            }),
          ),
        );
      },
    );
  }

  BlocConsumer<ResetPasswordBloc, ResetPasswordState> _buildResetTimerButton() {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => current.isResend! && current.step == 2,
      listenWhen: (previous, current) => current.isResend! && current.step == 2,
      listener: (context, state) {
        if (state is ResetPasswordError) {
          state.message.showSnackbar(
            context,
            color: Colors.red,
          );
        } else if (state is ResetPasswordLoaded) {
          _seconds.value = Numbers.otp;
          _startTimer();
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is ResetPasswordLoading,
          child: TextButton(
            onPressed: () {
              context.read<ResetPasswordBloc>().add(ResetPasswordResend(
                    context,
                    username: widget.username,
                  ));
            },
            style: TextButton.styleFrom(
              foregroundColor: BrandColors.orange,
            ),
            child: Builder(builder: (context) {
              if (state is ResetPasswordLoading) {
                return const CircularProgressIndicator();
              }
              return ValueListenableBuilder<int>(
                valueListenable: _seconds,
                builder: (context, value, child) => Text(
                  appLocalizations.getTimerText(value),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  BlocConsumer<AuthenticationBloc, AuthenticationState>
      _buildRegisterTimerButton() {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => current.isResend! && current.step == 2,
      listenWhen: (previous, current) => current.isResend! && current.step == 2,
      listener: (context, state) {
        if (state is AuthenticationError) {
          state.message.showSnackbar(
            context,
            color: Colors.red,
          );
        } else if (state is AuthenticationLoaded) {
          _seconds.value = Numbers.otp;
          _startTimer();
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is AuthenticationLoading,
          child: TextButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(
                  AuthenticationResend(context, username: widget.username));
            },
            style: TextButton.styleFrom(
              foregroundColor: BrandColors.orange,
            ),
            child: Builder(builder: (context) {
              if (state is AuthenticationLoading) {
                return const CircularProgressIndicator();
              }
              return ValueListenableBuilder<int>(
                valueListenable: _seconds,
                builder: (context, value, child) => Text(
                  appLocalizations.getTimerText(value),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _OTPTextField extends StatelessWidget {
  const _OTPTextField({required TextEditingController otp}) : _otp = otp;

  final TextEditingController _otp;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: _otp,
        pinAnimationType: PinAnimationType.slide,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        defaultPinTheme: PinTheme(
          width: 62.width,
          height: 62.height,
          textStyle: textTheme.headlineSmall,
          decoration: BoxDecoration(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }
}
