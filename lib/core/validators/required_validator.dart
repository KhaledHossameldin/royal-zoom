import '../../../../core/utils/localization/app_localizations.dart';
import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  @override
  String getMessage() {
    return translate('v_required');
  }

  @override
  bool validate(String? value) {
    return value != null && value.isNotEmpty;
  }
}
