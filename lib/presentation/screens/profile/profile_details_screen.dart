import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../blocs/authentication/authentication_bloc.dart';
import '../../../constants/brand_colors.dart';
import '../../../core/di/di_manager.dart';
import '../../../cubits/profile/profile_cubit.dart';
import '../../../data/enums/gender.dart';
import '../../../data/enums/perview_status.dart';
import '../../../data/models/authentication/city.dart';
import '../../../data/services/location_services.dart';
import '../../../data/sources/local/shared_prefs.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/countries.dart';
import '../../../utilities/extensions.dart';
import '../../../utilities/validators.dart';
import '../../widgets/reload_widget.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _buttonText = ValueNotifier<String?>('');
  final _isAdvanced = ValueNotifier<bool>(false);

  Country _country = LocationServices.instance.country;

  void setTabListener() {
    final appLocalizations = AppLocalizations.of(context);
    switch (_tabController.index) {
      case 0:
        _buttonText.value = '${appLocalizations.save} ${appLocalizations.data}';
        break;

      case 1:
        _buttonText.value =
            '${appLocalizations.save} ${appLocalizations.settings}';
        break;

      case 2:
        _buttonText.value =
            '${appLocalizations.save} ${appLocalizations.notifications}';
        break;

      default:
        _buttonText.value = '';
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(setTabListener);
    context.read<ProfileCubit>().fetch(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final appLocalizations = AppLocalizations.of(context);
      _buttonText.value = '${appLocalizations.save} ${appLocalizations.data}';
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(setTabListener);
    _buttonText.dispose();
    _isAdvanced.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.profile)),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProfileLoading:
              if (state.countries == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _buildBody(state);
              }

            case ProfileLoaded:
              return _buildBody(state);

            case ProfileError:
              state as ProfileError;
              if (state.countries == null) {
                return ReloadWidget(
                  title: state.message,
                  buttonText: appLocalizations.getReload(''),
                  onPressed: () => context.read<ProfileCubit>().fetch(context),
                );
              } else {
                return _buildBody(state);
              }

            default:
              return const Material();
          }
        },
      ),
      bottomNavigationBar: ColoredBox(
        color: BrandColors.snowWhite,
        child: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.only(
              left: 27.width,
              top: 24.height,
              right: 27.width,
              bottom: Platform.isAndroid ? 17.height : 0.0,
            ),
            child: ValueListenableBuilder(
              valueListenable: _buttonText,
              builder: (context, value, child) => ElevatedButton(
                onPressed: value != null
                    ? () async {
                        switch (_tabController.index) {
                          case 0:
                            await updateProfile();
                            break;

                          case 1:
                            await updateSettings();
                            break;

                          case 2:
                            await updateNotifications();
                            break;
                          default:
                        }
                      }
                    : null,
                child: value != null
                    ? Text(value)
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateNotifications() async {
    final cubit = context.read<ProfileCubit>();

    final text = _buttonText.value;
    _buttonText.value = null;
    try {
      await cubit.updateNotifications(context);
      _buttonText.value = text;
      if (context.mounted) {
        AppLocalizations.of(context)
            .successMessage
            .showSnackbar(context, color: BrandColors.green);
      }
    } catch (e) {
      if (!context.mounted) return;
      '$e'.showSnackbar(context, color: BrandColors.orange);
      _buttonText.value = text;
    }
  }

  Future<void> updateSettings() async {
    final cubit = context.read<ProfileCubit>();

    final text = _buttonText.value;
    _buttonText.value = null;
    try {
      await cubit.updateSettings(context);
      _buttonText.value = text;
    } catch (e) {
      if (!context.mounted) return;
      '$e'.showSnackbar(context, color: BrandColors.red);
      _buttonText.value = text;
    }
  }

  Future<void> updateProfile() async {
    final appLocalizations = AppLocalizations.of(context);
    final cubit = context.read<ProfileCubit>();

    if (cubit.profileUpdate.previewName.isNullOrEmpty) {
      appLocalizations.previewNameValidation
          .showSnackbar(context, color: BrandColors.red);
      return;
    }
    if (cubit.profileUpdate.email.isNullOrEmpty &&
        cubit.profileUpdate.phone.isNullOrEmpty) {
      appLocalizations.profileUpdateValidation
          .showSnackbar(context, color: BrandColors.red);
      return;
    }
    if (cubit.profileUpdate.email.isNullOrEmpty) {
      final isEmailValid =
          Validators.email(context, email: cubit.profileUpdate.email!);
      isEmailValid?.showSnackbar(context, color: BrandColors.red);
      return;
    }
    final text = _buttonText.value;
    _buttonText.value = null;
    try {
      await cubit.updateProfile(context);
      _buttonText.value = text;
      if (mounted) {
        appLocalizations.profileUpdatedSuccessfully.showSnackbar(context);
      }
    } catch (e) {
      if (!mounted) return;
      '$e'.showSnackbar(context, color: BrandColors.red);
      _buttonText.value = text;
    }
  }

  Column _buildBody(ProfileState state) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 22.height,
            left: 34.width,
            right: 34.width,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: BrandColors.gray.withOpacity(0.5)),
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(26.0),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: appLocalizations.data),
              Tab(text: appLocalizations.settings),
              Tab(text: appLocalizations.notifications),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildDataTab(state),
              _buildSettingsTab(state),
              _buildNotificationstab(),
            ],
          ),
        ),
      ],
    );
  }

  SingleChildScrollView _buildNotificationstab() {
    final appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 18.height, horizontal: 34.width),
      child: Column(
        children: [
          CheckboxListTile(
            title: Text(
              appLocalizations.email,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            subtitle: Text(
              appLocalizations.emailSubtitle,
              style: const TextStyle(
                fontSize: 13.0,
                color: BrandColors.gray,
                fontWeight: FontWeight.normal,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value:
                context.read<ProfileCubit>().notificationsUpdate.acceptViaEmail,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(acceptViaEmail: value)),
          ),
          12.emptyHeight,
          CheckboxListTile(
            title: Text.rich(
              TextSpan(children: [
                TextSpan(text: '${appLocalizations.smsTitle1} '),
                TextSpan(
                  text: appLocalizations.smsTitle2,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: BrandColors.gray,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ]),
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            subtitle: Text(
              appLocalizations.smsSubtitle,
              style: const TextStyle(
                fontSize: 13.0,
                color: BrandColors.gray,
                fontWeight: FontWeight.normal,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value:
                context.read<ProfileCubit>().notificationsUpdate.acceptViaSMS,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(acceptViaSMS: value)),
          ),
          12.emptyHeight,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 37.0),
            ),
            onPressed: () {},
            child: Text(appLocalizations.completePayment),
          ),
          12.emptyHeight,
          CheckboxListTile(
            title: Text(
              appLocalizations.appTitle,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            subtitle: Text(
              appLocalizations.appSubtitle,
              style: const TextStyle(
                fontSize: 13.0,
                color: BrandColors.gray,
                fontWeight: FontWeight.normal,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value:
                context.read<ProfileCubit>().notificationsUpdate.acceptViaApp,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(acceptViaApp: value)),
          ),
          12.emptyHeight,
          CheckboxListTile(
            title: const Text(
              'WhatsApp',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            subtitle: Text(
              appLocalizations.whatsappSubtitle,
              style: const TextStyle(
                fontSize: 13.0,
                color: BrandColors.gray,
                fontWeight: FontWeight.normal,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: context
                .read<ProfileCubit>()
                .notificationsUpdate
                .acceptViaWhatsapp,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(acceptViaWhatsapp: value)),
          ),
          12.emptyHeight,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 37.0),
            ),
            onPressed: () {},
            child: Text(appLocalizations.activate),
          ),
          Divider(height: 24.height),
          CheckboxListTile(
            title: Text(
              appLocalizations.consultationReply,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: context
                .read<ProfileCubit>()
                .notificationsUpdate
                .receiveOnConsultationReply,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(receiveOnConsultationReply: value)),
          ),
          4.emptyHeight,
          CheckboxListTile(
            title: Text(
              appLocalizations.appointmentAccept,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: context
                .read<ProfileCubit>()
                .notificationsUpdate
                .receiveOnAppointmentAccept,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(receiveOnAppointmentAccept: value)),
          ),
          4.emptyHeight,
          CheckboxListTile(
            title: Text(
              appLocalizations.changeRequest,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: context
                .read<ProfileCubit>()
                .notificationsUpdate
                .receiveOnAppointmentChangeRequest,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(
                    receiveOnAppointmentChangeRequest: value)),
          ),
          4.emptyHeight,
          CheckboxListTile(
            title: Text(
              appLocalizations.appointmentReject,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: context
                .read<ProfileCubit>()
                .notificationsUpdate
                .receiveOnAppointmentReject,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(receiveOnAppointmentReject: value)),
          ),
          4.emptyHeight,
          CheckboxListTile(
            title: Text(
              appLocalizations.receivePendingPayment,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: context
                .read<ProfileCubit>()
                .notificationsUpdate
                .receiveOnPendingPayment,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(receiveOnPendingPayment: value)),
          ),
          4.emptyHeight,
          CheckboxListTile(
            title: Text(
              appLocalizations.consultantMessage,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: context
                .read<ProfileCubit>()
                .notificationsUpdate
                .receiveOnConsultantMessage,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(receiveOnConsultantMessage: value)),
          ),
          4.emptyHeight,
          CheckboxListTile(
            title: Text(
              appLocalizations.receiveScheduledConsultation,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: context
                .read<ProfileCubit>()
                .notificationsUpdate
                .receiveBeforePublishingScheduledConsultation,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(
                    receiveBeforePublishingScheduledConsultation: value)),
          ),
          4.emptyHeight,
          CheckboxListTile(
            title: Text(
              appLocalizations.customerSupport,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: context
                .read<ProfileCubit>()
                .notificationsUpdate
                .receiveOnCustomerSupportMessage,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(
                    receiveOnCustomerSupportMessage: value)),
          ),
          4.emptyHeight,
          CheckboxListTile(
            title: Text(
              appLocalizations.refundCredit,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: context
                .read<ProfileCubit>()
                .notificationsUpdate
                .receiveOnRefundCredit,
            onChanged: (value) => setState(() => context
                .read<ProfileCubit>()
                .setNotificationsUpdate(receiveOnRefundCredit: value)),
          ),
          ValueListenableBuilder(
            valueListenable: _isAdvanced,
            builder: (context, value, child) => SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.emptyHeight,
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: BrandColors.orange),
                    onPressed: () => _isAdvanced.value = !_isAdvanced.value,
                    child: Text(
                      '${value ? MaterialLocalizations.of(context).closeButtonTooltip : ''} ${appLocalizations.advancedSettings}',
                    ),
                  ),
                  8.emptyHeight,
                  AnimatedCrossFade(
                    alignment: AlignmentDirectional.topCenter,
                    firstChild: const SizedBox(
                      width: double.infinity,
                    ),
                    secondChild: Column(
                      children: [
                        CheckboxListTile(
                          title: Text(
                            appLocalizations.expiredConsultation,
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: BrandColors.darkBlackGreen,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: context
                              .read<ProfileCubit>()
                              .notificationsUpdate
                              .receiveOnExpiredConsultationAccept,
                          onChanged: (value) => setState(() => context
                              .read<ProfileCubit>()
                              .setNotificationsUpdate(
                                  receiveOnExpiredConsultationAccept: value)),
                        ),
                        4.emptyHeight,
                        CheckboxListTile(
                          title: Text(
                            appLocalizations.successfulPayment,
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: BrandColors.darkBlackGreen,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: context
                              .read<ProfileCubit>()
                              .notificationsUpdate
                              .receiveOnSuccessfulPayment,
                          onChanged: (value) => setState(() => context
                              .read<ProfileCubit>()
                              .setNotificationsUpdate(
                                  receiveOnSuccessfulPayment: value)),
                        ),
                        4.emptyHeight,
                        CheckboxListTile(
                          title: Text(
                            appLocalizations.twoFactorAuth,
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: BrandColors.darkBlackGreen,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: context
                              .read<ProfileCubit>()
                              .notificationsUpdate
                              .receiveOnTwoFactorAuthEnabled,
                          onChanged: (value) => setState(() => context
                              .read<ProfileCubit>()
                              .setNotificationsUpdate(
                                  receiveOnTwoFactorAuthEnabled: value)),
                        ),
                        4.emptyHeight,
                        CheckboxListTile(
                          title: Text(
                            appLocalizations.priceOffer,
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: BrandColors.darkBlackGreen,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: context
                              .read<ProfileCubit>()
                              .notificationsUpdate
                              .receiveOnPriceOffer,
                          onChanged: (value) => setState(() => context
                              .read<ProfileCubit>()
                              .setNotificationsUpdate(
                                  receiveOnPriceOffer: value)),
                        ),
                      ],
                    ),
                    crossFadeState: value
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: kTabScrollDuration,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _buildSettingsTab(ProfileState state) {
    final appLocalizations = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 18.height,
        horizontal: 34.width,
      ),
      child: Column(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.language,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            Material(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(12.0),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<int>(
                  value: context.read<ProfileCubit>().settingsUpdate.languageId,
                  isExpanded: true,
                  menuMaxHeight: 300.height,
                  hint: Text(appLocalizations.choose),
                  underline: const Material(),
                  borderRadius: BorderRadius.circular(12.0),
                  icon: const Icon(Icons.expand_more_rounded),
                  style: textTheme.bodySmall!.copyWith(
                    color: BrandColors.darkBlue,
                  ),
                  items: state.languages!
                      .map((e) => DropdownMenuItem<int>(
                            value: e.id,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: (value) => setState(
                    () => context
                        .read<ProfileCubit>()
                        .setSettingsUpdate(languageId: value),
                  ),
                ),
              ),
            ),
            12.emptyHeight,
            Text(
              appLocalizations.timezone,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            Material(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(12.0),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<int>(
                  value: context.read<ProfileCubit>().settingsUpdate.timezoneId,
                  isExpanded: true,
                  menuMaxHeight: 300.height,
                  hint: Text(appLocalizations.choose),
                  underline: const Material(),
                  borderRadius: BorderRadius.circular(12.0),
                  icon: const Icon(Icons.expand_more_rounded),
                  style: textTheme.bodySmall!.copyWith(
                    color: BrandColors.darkBlue,
                  ),
                  items: state.timezones!
                      .map((e) => DropdownMenuItem<int>(
                            value: e.id,
                            child: Text(e.timezone),
                          ))
                      .toList(),
                  onChanged: (value) => setState(
                    () => context
                        .read<ProfileCubit>()
                        .setSettingsUpdate(timezoneId: value),
                  ),
                ),
              ),
            ),
            12.emptyHeight,
            Text(
              appLocalizations.currency,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            Material(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(12.0),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<int>(
                  value: context.read<ProfileCubit>().settingsUpdate.currencyId,
                  isExpanded: true,
                  menuMaxHeight: 300.height,
                  hint: Text(appLocalizations.choose),
                  underline: const Material(),
                  borderRadius: BorderRadius.circular(12.0),
                  icon: const Icon(Icons.expand_more_rounded),
                  style: textTheme.bodySmall!.copyWith(
                    color: BrandColors.darkBlue,
                  ),
                  items: state.currencies!
                      .map((e) => DropdownMenuItem<int>(
                            value: e.id,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: (value) => setState(
                    () => context
                        .read<ProfileCubit>()
                        .setSettingsUpdate(currencyId: value),
                  ),
                ),
              ),
            ),
            16.emptyHeight,
            CheckboxListTile(
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                appLocalizations.twoFactorTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                appLocalizations.twoFactorSubtitle,
                style: const TextStyle(color: BrandColors.gray),
              ),
              value: context
                      .read<ProfileCubit>()
                      .settingsUpdate
                      .activateMultiFactorAuthentication ??
                  false,
              onChanged: (value) => setState(() => context
                  .read<ProfileCubit>()
                  .setSettingsUpdate(activateMultiFactorAuthentication: value)),
            ),
          ],
        ),
      ]),
    );
  }

  SingleChildScrollView _buildDataTab(ProfileState state) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final userData = DIManager.findDep<SharedPrefs>().getUser()!;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 18.height,
        horizontal: 34.width,
      ),
      child: Column(children: [
        StatefulBuilder(
          builder: (context, setState) => GestureDetector(
            onTap: () async {
              final imagePicker = ImagePicker();
              final image =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              if (image == null) {
                return;
              }
              setState(() => context
                  .read<ProfileCubit>()
                  .setProfileUpdate(image: image.path));
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 67.width,
                  backgroundColor: BrandColors.orange,
                  child: CircleAvatar(
                    radius: 65.width,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60.width,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          // context.read<ProfileCubit>().profileUpdate.image !=
                          // userData.image
                          // ? FileImage(File(context
                          // .read<ProfileCubit>()
                          // .profileUpdate
                          // .image!)):
                          userData.image.isNotEmpty
                              ? NetworkImage(userData.image)
                              : 'royake'.png.image,
                    ),
                  ),
                ),
                Positioned.directional(
                  textDirection: appLocalizations.isEnLocale
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  start: 0,
                  bottom: 0,
                  child: const CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor: BrandColors.mediumGray,
                    child: Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
        10.emptyHeight,
        Text(
          appLocalizations.profileImageFormat,
          style: const TextStyle(
            fontSize: 12.0,
            color: BrandColors.gray,
            fontWeight: FontWeight.normal,
          ),
        ),
        10.emptyHeight,
        if (!userData.email.isNullOrEmpty)
          Text(
            userData.email!,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: BrandColors.darkBlackGreen,
            ),
          ),
        if (!userData.phone.isNullOrEmpty)
          Text(
            userData.phone!,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: BrandColors.darkBlackGreen,
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.firstName,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            TextFormField(
              initialValue: userData.firstName,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                isDense: true,
                hintText: appLocalizations.firstName,
              ),
              onChanged: (value) {
                context.read<ProfileCubit>().setProfileUpdate(firstName: value);
              },
            ),
            12.emptyHeight,
            Text(
              appLocalizations.middleName,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            TextFormField(
              initialValue: userData.middleName,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                isDense: true,
                hintText: appLocalizations.middleName,
              ),
              onChanged: (value) {
                context
                    .read<ProfileCubit>()
                    .setProfileUpdate(middleName: value);
              },
            ),
            12.emptyHeight,
            Text(
              appLocalizations.lastName,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            TextFormField(
              initialValue: userData.lastName,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                isDense: true,
                hintText: appLocalizations.lastName,
              ),
              onChanged: (value) {
                context.read<ProfileCubit>().setProfileUpdate(lastName: value);
              },
            ),
            12.emptyHeight,
            Text(
              appLocalizations.previewName,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            TextFormField(
              initialValue: userData.previewName,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                isDense: true,
                hintText: appLocalizations.previewName,
              ),
              onChanged: (value) {
                context
                    .read<ProfileCubit>()
                    .setProfileUpdate(previewName: value);
              },
            ),
            8.emptyHeight,
            Text(
              appLocalizations.previewNameDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11.0,
                color: BrandColors.mediumGray,
                fontWeight: FontWeight.normal,
              ),
            ),
            12.emptyHeight,
            Text(
              appLocalizations.email,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            TextFormField(
              initialValue: userData.email,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validators.email(context, email: value!),
              decoration: InputDecoration(
                hintText: appLocalizations.email,
              ),
              onChanged: (value) {
                context.read<ProfileCubit>().setProfileUpdate(email: value);
              },
            ),
            12.emptyHeight,
            Text(
              appLocalizations.phone,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            StatefulBuilder(
              builder: (context, setState) => Directionality(
                textDirection: TextDirection.ltr,
                child: TextFormField(
                  initialValue: userData.phone,
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
                  onChanged: (value) {
                    context.read<ProfileCubit>().setProfileUpdate(
                        phone: value.isNotEmpty
                            ? '+${_country.dialCode}$value'
                            : '');
                  },
                ),
              ),
            ),
            12.emptyHeight,
            Text(
              appLocalizations.gender,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            Material(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(12.0),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<Gender>(
                  value: context.read<ProfileCubit>().profileUpdate.gender,
                  isExpanded: true,
                  menuMaxHeight: 300.height,
                  hint: Text(appLocalizations.choose),
                  underline: const Material(),
                  borderRadius: BorderRadius.circular(12.0),
                  icon: const Icon(Icons.expand_more_rounded),
                  style: textTheme.bodySmall!.copyWith(
                    color: BrandColors.darkBlue,
                  ),
                  items: [
                    DropdownMenuItem<Gender>(
                      value: Gender.male,
                      child: Text(appLocalizations.male),
                    ),
                    DropdownMenuItem<Gender>(
                      value: Gender.female,
                      child: Text(appLocalizations.female),
                    ),
                  ],
                  onChanged: (value) => setState(
                    () => context
                        .read<ProfileCubit>()
                        .setProfileUpdate(gender: value),
                  ),
                ),
              ),
            ),
            12.emptyHeight,
            Text(
              appLocalizations.country,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            Material(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(12.0),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<int>(
                  value: context.read<ProfileCubit>().profileUpdate.countryId,
                  isExpanded: true,
                  menuMaxHeight: 300.height,
                  hint: Text(appLocalizations.choose),
                  underline: const Material(),
                  borderRadius: BorderRadius.circular(12.0),
                  icon: const Icon(Icons.expand_more_rounded),
                  style: textTheme.bodySmall!.copyWith(
                    color: BrandColors.darkBlue,
                  ),
                  items: state.countries!
                      .map((e) => DropdownMenuItem<int>(
                            value: e.id,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    final cubit = context.read<ProfileCubit>();
                    cubit.setProfileUpdate(countryId: value);
                    cubit.fetchCities(context, countryId: value!);
                  },
                ),
              ),
            ),
            12.emptyHeight,
            Builder(
              builder: (context) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ProfileError) {
                  return Text(state.message);
                }
                return _buildCities((state as ProfileLoaded).cities);
              },
            ),
            12.emptyHeight,
            Text(
              appLocalizations.previewStatus,
              style: const TextStyle(
                fontSize: 15.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            8.emptyHeight,
            Material(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(12.0),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<PreviewStatus>(
                  value:
                      context.read<ProfileCubit>().profileUpdate.previewStatus,
                  isExpanded: true,
                  menuMaxHeight: 300.height,
                  hint: Text(appLocalizations.choose),
                  underline: const Material(),
                  borderRadius: BorderRadius.circular(12.0),
                  icon: const Icon(Icons.expand_more_rounded),
                  style: textTheme.bodySmall!.copyWith(
                    color: BrandColors.darkBlue,
                  ),
                  items: [
                    DropdownMenuItem<PreviewStatus>(
                      value: PreviewStatus.visible,
                      child: Text(
                        appLocalizations
                            .getPreviewStatus(PreviewStatus.visible),
                      ),
                    ),
                    DropdownMenuItem<PreviewStatus>(
                      value: PreviewStatus.hidden,
                      child: Text(
                        appLocalizations.getPreviewStatus(PreviewStatus.hidden),
                      ),
                    ),
                    DropdownMenuItem<PreviewStatus>(
                      value: PreviewStatus.busy,
                      child: Text(
                        appLocalizations.getPreviewStatus(PreviewStatus.busy),
                      ),
                    ),
                  ],
                  onChanged: (value) => setState(() => context
                      .read<ProfileCubit>()
                      .setProfileUpdate(previewStatus: value)),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  StatefulBuilder _buildCities(List<City>? cities) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final cubit = context.read<ProfileCubit>();

    return StatefulBuilder(
      builder: (context, setState) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.city,
            style: const TextStyle(
              fontSize: 15.0,
              color: BrandColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          8.emptyHeight,
          Material(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(12.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<int>(
                value: cubit.profileUpdate.cityId,
                isExpanded: true,
                menuMaxHeight: 300.height,
                hint: Text(appLocalizations.choose),
                underline: const Material(),
                borderRadius: BorderRadius.circular(12.0),
                icon: const Icon(Icons.expand_more_rounded),
                style: textTheme.bodySmall!.copyWith(
                  color: BrandColors.darkBlue,
                ),
                items: cities
                    ?.map((item) => DropdownMenuItem<int>(
                        value: item.id, child: Text(item.name)))
                    .toList(),
                onChanged: (value) => cubit.setProfileUpdate(cityId: value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
