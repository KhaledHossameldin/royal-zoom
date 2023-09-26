import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/reset_password/reset_password_bloc.dart';
import '../../../../constants/routes.dart';
import '../../../../data/enums/email_phone.dart';
import '../../../../data/services/location_services.dart';
import '../../../../data/services/repository.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/countries.dart';
import '../../../../utilities/extensions.dart';
import '../../../../utilities/validators.dart';
import '../../../widgets/app_bar_logo.dart';
import '../../../widgets/copyright.dart';
import '../../../widgets/reset_password_image.dart';

class ResetPasswordDetailsScreen extends StatefulWidget {
  const ResetPasswordDetailsScreen({super.key});

  @override
  State<ResetPasswordDetailsScreen> createState() =>
      _ResetPasswordDetailsScreenState();
}

class _ResetPasswordDetailsScreenState
    extends State<ResetPasswordDetailsScreen> {
  final _username = TextEditingController();
  final _textFieldKey = GlobalKey<FormFieldState>();

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
                    appLocalizations.resetPasswordDetailsTitle,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineMedium,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appLocalizations.emailOrPhone),
                      7.emptyHeight,
                      _buildEmailPhoneTextField(),
                    ],
                  ),
                  _buildRestoreButton(),
                  const CopyRight(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getUsername() {
    String username = _username.text;
    if (_emailPhone == EmailPhone.phone) {
      return '${_country.dialCode}$username';
    }
    return username;
  }

  BlocConsumer<ResetPasswordBloc, ResetPasswordState> _buildRestoreButton() {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => current.step == 1,
      listenWhen: (previous, current) => current.step == 1,
      listener: (context, state) {
        if (state is ResetPasswordError) {
          state.message.showSnackbar(
            context,
            color: Colors.red,
          );
        } else if (state is ResetPasswordLoaded) {
          Navigator.pushNamed(
            context,
            Routes.otp,
            arguments: {'username': _getUsername(), 'isRegister': false},
          );
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is ResetPasswordLoading,
          child: ElevatedButton(
            onPressed: () {
              final isValid = _textFieldKey.currentState!.validate();
              if (isValid) {
                context.read<ResetPasswordBloc>().add(
                      ResetPasswordForget(
                        context,
                        username: _getUsername(),
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
              return Text(appLocalizations.restore);
            }),
          ),
        );
      },
    );
  }

  StatefulBuilder _buildEmailPhoneTextField() => StatefulBuilder(
        builder: (context, setState) => TextFormField(
          key: _textFieldKey,
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
          textAlign:
              _emailPhone == EmailPhone.phone ? TextAlign.end : TextAlign.start,
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
      );
}
