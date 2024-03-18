import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../core/di/di_manager.dart';
import '../../data/enums/gender.dart';
import '../../data/enums/perview_status.dart';
import '../../data/models/authentication/city.dart';
import '../../data/models/authentication/country.dart';
import '../../data/models/authentication/currency.dart';
import '../../data/models/authentication/language.dart';
import '../../data/models/authentication/timezone.dart';
import '../../data/models/update_profile/notifications_update.dart';
import '../../data/models/update_profile/profile_update.dart';
import '../../data/models/update_profile/settings_update.dart';
import '../../data/services/repository.dart';
import '../../data/sources/local/shared_prefs.dart';
import '../locale_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial());

  final repository = Repository.instance;
  late ProfileUpdate profileUpdate;
  late SettingsUpdate settingsUpdate;
  late NotificationsUpdate notificationsUpdate;

  Future<void> updateNotifications(BuildContext context) async {
    final data = await repository.updateNotifications(context,
        body: notificationsUpdate.toMap());
    if (!context.mounted) return;
    DIManager.findDep<SharedPrefs>().setUser(data);
  }

  void setNotificationsUpdate({
    bool? acceptViaEmail,
    bool? acceptViaSMS,
    bool? acceptViaApp,
    bool? acceptViaWhatsapp,
    bool? receiveOnPriceOffer,
    bool? receiveOnConsultationReply,
    bool? receiveOnAppointmentAccept,
    bool? receiveOnAppointmentReject,
    bool? receiveOnAppointmentChangeRequest,
    bool? receiveOnPendingPayment,
    bool? receiveOnConsultantMessage,
    bool? receiveOnCustomerSupportMessage,
    bool? receiveBeforePublishingScheduledConsultation,
    bool? receiveOnRefundCredit,
    bool? receiveOnExpiredConsultationAccept,
    bool? receiveOnSuccessfulPayment,
    bool? receiveOnTwoFactorAuthEnabled,
  }) {
    notificationsUpdate = notificationsUpdate.copyWith(
      acceptViaEmail: acceptViaEmail,
      acceptViaSMS: acceptViaSMS,
      acceptViaApp: acceptViaApp,
      acceptViaWhatsapp: acceptViaWhatsapp,
      receiveOnPriceOffer: receiveOnPriceOffer,
      receiveOnConsultationReply: receiveOnConsultationReply,
      receiveOnAppointmentAccept: receiveOnAppointmentAccept,
      receiveOnAppointmentReject: receiveOnAppointmentReject,
      receiveOnAppointmentChangeRequest: receiveOnAppointmentChangeRequest,
      receiveOnPendingPayment: receiveOnPendingPayment,
      receiveOnConsultantMessage: receiveOnConsultantMessage,
      receiveOnCustomerSupportMessage: receiveOnCustomerSupportMessage,
      receiveBeforePublishingScheduledConsultation:
          receiveBeforePublishingScheduledConsultation,
      receiveOnRefundCredit: receiveOnRefundCredit,
      receiveOnExpiredConsultationAccept: receiveOnExpiredConsultationAccept,
      receiveOnSuccessfulPayment: receiveOnSuccessfulPayment,
      receiveOnTwoFactorAuthEnabled: receiveOnTwoFactorAuthEnabled,
    );
  }

  Future<void> updateSettings(BuildContext context) async {
    final data =
        await repository.updateSettings(context, body: settingsUpdate.toMap());
    if (!context.mounted) return;
    final user = context.read<AuthenticationBloc>().user!;
    DIManager.findDep<SharedPrefs>().setUser(data);
    if (user.language != null) {
      context.read<LocaleCubit>().switchLanguage(user.language!.symbol);
    }
  }

  void setSettingsUpdate({
    int? languageId,
    int? currencyId,
    int? timezoneId,
    bool? activateMultiFactorAuthentication,
  }) {
    settingsUpdate = settingsUpdate.copyWith(
      languageId: languageId,
      currencyId: currencyId,
      timezoneId: timezoneId,
      activateMultiFactorAuthentication: activateMultiFactorAuthentication,
    );
  }

  Future<void> updateProfile(BuildContext context) async {
    final userData = context.read<AuthenticationBloc>().user!;
    final data = await repository.updateProfile(context,
        body: profileUpdate.toMap(userData));
    DIManager.findDep<SharedPrefs>().setUser(data);
  }

  void setProfileUpdate({
    String? firstName,
    String? middleName,
    String? lastName,
    String? previewName,
    int? countryId,
    int? cityId,
    int? nationalityId,
    String? email,
    String? phone,
    Gender? gender,
    PreviewStatus? previewStatus,
    String? image,
  }) {
    profileUpdate = profileUpdate.copyWith(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      previewName: previewName,
      countryId: countryId,
      cityId: cityId,
      nationalityId: nationalityId,
      email: email,
      phone: phone,
      gender: gender,
      previewStatus: previewStatus,
      image: image,
    );
  }

  Future<void> fetchCities(
    BuildContext context, {
    required int countryId,
  }) async {
    final currentState = state as ProfileLoaded;
    emit(ProfileLoading(countries: currentState.countries));
    final cities = await repository.cities(context, countryId: countryId);
    emit(ProfileLoaded(
      currencies: currentState.currencies,
      languages: currentState.languages,
      timezones: currentState.timezones,
      countries: currentState.countries,
      cities: cities,
    ));
  }

  Future<void> fetch(BuildContext context, {int? countryId}) async {
    final userData = context.read<AuthenticationBloc>().user!;
    profileUpdate = ProfileUpdate.fromUserData(userData);
    settingsUpdate = SettingsUpdate.fromUserData(userData);
    if (userData.settings == null) {
      notificationsUpdate = NotificationsUpdate();
    } else {
      notificationsUpdate =
          NotificationsUpdate.fromUserData(userData.settings!);
    }
    try {
      emit(const ProfileLoading());
      final values = await Future.wait([
        repository.timezones(context),
        repository.currencies(context),
        repository.languages(context),
        repository.countries(context),
        if (countryId != null) repository.cities(context, countryId: countryId),
      ]);
      emit(ProfileLoaded(
        timezones: values[0] as List<Timezone>,
        currencies: values[1] as List<Currency>,
        languages: values[2] as List<Language>,
        countries: values[3] as List<Country>,
        cities: countryId != null ? values[4] as List<City> : null,
      ));
    } catch (e) {
      emit(ProfileError('$e'));
    }
  }
}
