import '../../../../core/utils/localization/app_localizations.dart';
import 'base_validator.dart';

class MatchValidator extends BaseValidator {
  String value;

  MatchValidator({required this.value});

  @override
  String getMessage() {
    return translate('v_not_match');
  }

  @override
  bool validate(String? value) {
    return value == this.value;
  }
}
