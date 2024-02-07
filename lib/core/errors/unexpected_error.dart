import '../../../core/utils/localization/app_localizations.dart';
import 'base_error.dart';

class UnExpectedError extends BaseError {
  UnExpectedError() : super(translate('unexpected_err'));
}
