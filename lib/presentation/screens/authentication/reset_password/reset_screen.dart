import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/reset_password/reset_password_bloc.dart';
import '../../../../constants/routes.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../../utilities/validators.dart';
import '../../../widgets/app_bar_logo.dart';
import '../../../widgets/copyright.dart';
import '../../../widgets/reset_password_image.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key, required this.username, required this.code});

  final String username;
  final String code;

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _new = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _new.dispose();
    _confirm.dispose();
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
                  const ResetPasswordImage(),
                  Text(
                    appLocalizations.enterNewPassword,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineLarge,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _PasswordTextField(
                          text: appLocalizations.password,
                          controller: _new,
                        ),
                        13.emptyHeight,
                        _PasswordTextField(
                          text: appLocalizations.confirmPassword,
                          controller: _confirm,
                        ),
                      ],
                    ),
                  ),
                  _buildConfirmButton(),
                  const CopyRight(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BlocConsumer<ResetPasswordBloc, ResetPasswordState> _buildConfirmButton() {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listenWhen: (previous, current) => current.step == 3,
      buildWhen: (previous, current) => current.step == 3,
      listener: (context, state) {
        if (state is ResetPasswordError) {
          state.message.showSnackbar(
            context,
            color: Colors.red,
          );
        } else if (state is ResetPasswordLoaded) {
          Navigator.pushNamed(
            context,
            Routes.resetPasswordSuccess,
          );
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is ResetPasswordLoading,
          child: ElevatedButton(
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                context.read<ResetPasswordBloc>().add(
                      ResetPasswordReset(
                        context,
                        username: widget.username,
                        code: widget.code,
                        newPassword: _new.text,
                        confirmPassword: _confirm.text,
                      ),
                    );
              }
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
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({required this.text, required this.controller});

  final String text;
  final TextEditingController controller;

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
        Text(widget.text),
        7.emptyHeight,
        StatefulBuilder(
          builder: (context, setState) => TextFormField(
            obscureText: _isObscure,
            controller: widget.controller,
            obscuringCharacter: '*',
            keyboardType: TextInputType.visiblePassword,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            validator: (value) => Validators.password(
              context,
              password: value!,
            ),
            decoration: InputDecoration(
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
