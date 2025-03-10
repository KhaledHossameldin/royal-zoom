import '../../../../core/utils/localization/app_localizations.dart';
import '../validators/base_validator.dart';

class EmailValidator extends BaseValidator {
  @override
  String getMessage() {
    return translate('v_invalid_email');
  }

  @override
  bool validate(String? value) {
    final regex = RegExp(
        '^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\$');
    return regex.hasMatch(value!);
  }
}
