import '../../../core/errors/base_error.dart';
import '../../../core/utils/localization/app_localizations.dart';

class ForbiddenError extends BaseError {
  ForbiddenError() : super(translate('forbidden_err'));
}
