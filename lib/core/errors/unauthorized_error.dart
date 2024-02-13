import '../../../core/utils/localization/app_localizations.dart';
import 'base_error.dart';

class UnauthorizedError extends BaseError {
  UnauthorizedError({String? message, int? code})
      : super(message ?? translate('un_authorized_error'), code: code);
}
