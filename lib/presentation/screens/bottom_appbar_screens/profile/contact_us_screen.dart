import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/hero_tags.dart';
import '../../../../constants/routes.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/countries.dart';
import '../../../../utilities/extensions.dart';
import '../../../../utilities/validators.dart';
import '../../../widgets/brand_back_button.dart';

const _phoneInfo = '+9660500186476';
const _emailInfo = 'info@wtsaudi.com';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key, required this.isGuest});

  final bool isGuest;

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final ValueNotifier<bool> _isWhatsApp = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _topic = TextEditingController();
  final _message = TextEditingController();
  final _phoneFocus = FocusNode();
  Country _country = countries[194];

  @override
  void initState() {
    checkWhatsApp(context).then((value) => _isWhatsApp.value = value);
    super.initState();
  }

  @override
  void dispose() {
    _isWhatsApp.dispose();
    _fullName.dispose();
    _email.dispose();
    _phone.dispose();
    _topic.dispose();
    _message.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      appBar: AppBar(
        leading: const BrandBackButton(),
        title: Hero(
          tag: appLocalizations.contactUs,
          child: Text(appLocalizations.contactUs),
        ),
        actions: widget.isGuest
            ? [
                TextButton.icon(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                    (route) => false,
                  ),
                  icon: 'profile'.svg,
                  label: Text(appLocalizations.register),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          41.height,
          14.width,
          41.width,
          bottomViewPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactInfo(),
            10.emptyHeight,
            Text(
              appLocalizations.leaveMessage,
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            10.emptyHeight,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildNameField(),
                  10.emptyHeight,
                  _buildEmailField(),
                  10.emptyHeight,
                  _buildPhoneField(),
                  10.emptyHeight,
                  _buildTopicField(),
                  10.emptyHeight,
                  _buildMessageField(),
                  10.emptyHeight,
                  Hero(
                    tag: HeroTags.elevatedButton,
                    child: ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.validate();
                      },
                      child: Text(appLocalizations.send),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildMessageField() {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.yourMessage,
          style: const TextStyle(
            fontSize: 16.0,
            color: BrandColors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        8.emptyHeight,
        TextFormField(
          controller: _message,
          keyboardType: TextInputType.multiline,
          validator: (value) => Validators.message(context, message: value!),
          maxLines: 4,
          decoration: InputDecoration(
            hintText: '${appLocalizations.yourMessage}...',
            hintStyle: const TextStyle(
              fontSize: 16.0,
              color: BrandColors.gray,
            ),
          ),
        ),
      ],
    );
  }

  Column _buildTopicField() {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.topic,
          style: const TextStyle(
            fontSize: 16.0,
            color: BrandColors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        8.emptyHeight,
        TextFormField(
          controller: _topic,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: (value) => Validators.topic(context, topic: value!),
          decoration: InputDecoration(
            hintText: appLocalizations.topic,
            prefixIcon: const Icon(Icons.email_outlined),
            hintStyle: const TextStyle(
              fontSize: 16.0,
              color: BrandColors.gray,
            ),
          ),
        ),
      ],
    );
  }

  Column _buildNameField() {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.yourName,
          style: const TextStyle(
            fontSize: 16.0,
            color: BrandColors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        8.emptyHeight,
        TextFormField(
          controller: _fullName,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: (value) => Validators.name(context, name: value!),
          decoration: InputDecoration(
            hintText: appLocalizations.fullName,
            prefixIcon: const Icon(Icons.person_outline),
            hintStyle: const TextStyle(
              fontSize: 16.0,
              color: BrandColors.gray,
            ),
          ),
        ),
      ],
    );
  }

  Column _buildEmailField() {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.email,
          style: const TextStyle(
            fontSize: 16.0,
            color: BrandColors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        8.emptyHeight,
        TextFormField(
          controller: _email,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => Validators.email(context, email: value!),
          onFieldSubmitted: (value) => _phoneFocus.requestFocus(),
          decoration: InputDecoration(
            hintText: appLocalizations.email,
            prefixIcon: const Icon(Icons.email_outlined),
            hintStyle: const TextStyle(
              fontSize: 16.0,
              color: BrandColors.gray,
            ),
          ),
        ),
      ],
    );
  }

  Column _buildPhoneField() {
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
              focusNode: _phoneFocus,
              controller: _phone,
              textAlign: TextAlign.start,
              maxLength: _country.maxLength,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
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

  Wrap _buildContactInfo() {
    const textStyle = TextStyle(fontSize: 12.0, color: BrandColors.black);

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () {
            launchUrl(Uri(scheme: 'mailto', path: _emailInfo));
          },
          icon: const Icon(Icons.add),
          label: const Text(_emailInfo, style: textStyle),
        ),
        TextButton.icon(
          onPressed: () {
            launchUrl(Uri(
              scheme: 'tel',
              path: _phoneInfo,
            ));
          },
          icon: const Icon(Icons.add),
          label: Text(
            phoneFormat,
            textDirection: TextDirection.ltr,
            style: textStyle,
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isWhatsApp,
          builder: (context, value, child) {
            if (!value) {
              return const Material();
            }
            return TextButton.icon(
              onPressed: () => openWhatsApp(context),
              icon: const Icon(Icons.add),
              label: Text(
                phoneFormat,
                textDirection: TextDirection.ltr,
                style: textStyle,
              ),
            );
          },
        ),
      ],
    );
  }

  String get phoneFormat {
    return '(${_phoneInfo.substring(0, 4)}) ${_phoneInfo.substring(4, 7)} ${_phoneInfo.substring(7, 10)} ${_phoneInfo.substring(10)}';
  }

  Future<bool> checkWhatsApp(BuildContext context) async {
    const whatsappURlAndroid = 'whatsapp://send?phone=$_phoneInfo';
    const whatsappURLIos = 'https://wa.me/$_phoneInfo';
    if (Platform.isIOS) {
      return await canLaunchUrl(Uri.parse(whatsappURLIos));
    }
    return await canLaunchUrl(Uri.parse(whatsappURlAndroid));
  }

  Future<void> openWhatsApp(BuildContext context) async {
    const whatsappURlAndroid = 'whatsapp://send?phone=$_phoneInfo';
    const whatsappURLIos = 'https://wa.me/$_phoneInfo';
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(whatsappURLIos));
      return;
    }
    await launchUrl(Uri.parse(whatsappURlAndroid));
  }
}
