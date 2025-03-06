import '../../../../core/utils/localization/app_localizations.dart';
import '../validators/base_validator.dart';

class VerificationCodeValidator extends BaseValidator {
  @override
  String getMessage() {
    return translate('v_invalid_code');
  }

  @override
  bool validate(String? value) {
    return value != null && value.isNotEmpty && value.length == 5;
  }
}
