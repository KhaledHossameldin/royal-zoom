import '../../utilities/extensions.dart';
import '../enums/gender.dart';
import '../enums/perview_status.dart';
import 'authentication/user_data.dart';

class ProfileUpdate {
  String? firstName;
  String? middleName;
  String? lastName;
  String? previewName;
  int? countryId;
  int? cityId;
  int? nationalityId;
  String? email;
  String? phone;
  Gender? gender;
  PreviewStatus? previewStatus;
  String? image;

  ProfileUpdate({
    this.firstName,
    this.middleName,
    this.lastName,
    this.previewName,
    this.countryId,
    this.cityId,
    this.nationalityId,
    this.email,
    this.phone,
    this.gender,
    this.previewStatus,
    this.image,
  });

  ProfileUpdate.fromUserData(UserData userData) {
    firstName = userData.firstName;
    middleName = userData.middleName;
    lastName = userData.lastName;
    previewName = userData.previewName;
    countryId = userData.countryId;
    cityId = userData.cityId;
    nationalityId = userData.nationalityId;
    email = userData.email;
    phone = userData.phone;
    gender = userData.gender;
    previewStatus = userData.previewStatus;
    image = userData.image;
  }

  Map<String, Object> toMap(UserData userData) {
    final contract = _ProfileUpdateContract();
    final Map<String, Object> map = {};
    if (!firstName.isNullOrEmpty && firstName != userData.firstName) {
      map.putIfAbsent(contract.firstName, () => firstName!);
    }
    if (!middleName.isNullOrEmpty && middleName != userData.middleName) {
      map.putIfAbsent(contract.middleName, () => middleName!);
    }
    if (!lastName.isNullOrEmpty && lastName != userData.lastName) {
      map.putIfAbsent(contract.lastName, () => lastName!);
    }
    if (!previewName.isNullOrEmpty) {
      map.putIfAbsent(contract.previewName, () => previewName!);
    }
    if (countryId != null && countryId != userData.countryId) {
      map.putIfAbsent(contract.countryId, () => countryId!);
    }
    if (cityId != null && cityId != userData.cityId) {
      map.putIfAbsent(contract.cityId, () => cityId!);
    }
    if (nationalityId != null && nationalityId != userData.nationalityId) {
      map.putIfAbsent(contract.nationalityId, () => nationalityId!);
    }
    if ((!email.isNullOrEmpty)) {
      map.putIfAbsent(contract.email, () => email!);
    }
    if (!phone.isNullOrEmpty) {
      map.putIfAbsent(contract.phone, () => phone!);
    }
    if (gender != null && gender != userData.gender) {
      map.putIfAbsent(contract.gender, () => gender!.toMap().toString());
    }
    if (previewStatus != null && previewStatus != userData.previewStatus) {
      map.putIfAbsent(
          contract.previewStatus, () => previewStatus!.toMap().toString());
    }
    if (!image.isNullOrEmpty && image != userData.image) {
      map.putIfAbsent(contract.image, () => image!);
    }
    return map;
  }

  ProfileUpdate copyWith({
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
  }) =>
      ProfileUpdate(
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        previewName: previewName ?? this.previewName,
        countryId: countryId ?? this.countryId,
        cityId: cityId ?? this.cityId,
        nationalityId: nationalityId ?? this.nationalityId,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        previewStatus: previewStatus ?? this.previewStatus,
        image: image ?? this.image,
      );

  @override
  String toString() {
    return 'ProfileUpdate(firstName: $firstName, middleName: $middleName, lastName: $lastName, previewName: $previewName, countryId: $countryId, cityId: $cityId, nationalityId: $nationalityId, email: $email, phone: $phone, gender: $gender, previewStatus: $previewStatus, image: $image)';
  }
}

class _ProfileUpdateContract {
  final firstName = 'first_name';
  final middleName = 'middle_name';
  final lastName = 'last_name';
  final previewName = 'preview_name';
  final countryId = 'country_id';
  final cityId = 'city_id';
  final nationalityId = 'nationality_id';
  final email = 'email';
  final phone = 'phone';
  final gender = 'gender';
  final previewStatus = 'preview_status';
  final image = 'image';
}
