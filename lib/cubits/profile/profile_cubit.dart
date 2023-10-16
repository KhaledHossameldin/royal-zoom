import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../data/enums/gender.dart';
import '../../data/enums/perview_status.dart';
import '../../data/models/authentication/city.dart';
import '../../data/models/authentication/country.dart';
import '../../data/models/profile_update.dart';
import '../../data/services/repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial());

  final repository = Repository.instance;
  late ProfileUpdate profileUpdate;

  Future<void> updateProfile(BuildContext context) async {
    final userData = context.read<AuthenticationBloc>().user!.data;
    final data = await repository.updateProfile(context,
        body: profileUpdate.toMap(userData));
    if (!context.mounted) return;
    context.read<AuthenticationBloc>().user!.updateData(data);
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
      countries: currentState.countries,
      cities: cities,
    ));
  }

  Future<void> fetch(BuildContext context, {int? countryId}) async {
    final userData = context.read<AuthenticationBloc>().user!.data;
    profileUpdate = ProfileUpdate.fromUserData(userData);
    try {
      emit(const ProfileLoading());
      final values = await Future.wait([
        repository.countries(context),
        if (countryId != null) repository.cities(context, countryId: countryId),
      ]);
      emit(ProfileLoaded(
        countries: values[0] as List<Country>,
        cities: countryId != null ? values[1] as List<City> : null,
      ));
    } catch (e) {
      emit(ProfileError('$e'));
    }
  }
}
