import '../../../core/utils/localization/app_localizations.dart';
import 'base_error.dart';

class CancelError extends BaseError {
  CancelError({String? message})
      : super(message ?? translate('user_cancel_error'));
}
