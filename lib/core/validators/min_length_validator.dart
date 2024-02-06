import '../../../../core/utils/localization/app_localizations.dart';
import 'base_validator.dart';

class MinLengthValidator extends BaseValidator {
  final int minLength;

  MinLengthValidator({required this.minLength});

  @override
  String getMessage() {
    return '${translate('v_min_length_1')} '
        '$minLength '
        '${translate('v_min_length_2')}';
  }

  @override
  bool validate(String? value) {
    return value!.length >= minLength;
  }
}
