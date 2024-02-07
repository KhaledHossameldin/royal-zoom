import '../../../core/utils/localization/app_localizations.dart';
import 'base_error.dart';

class NotFoundError extends BaseError {
  NotFoundError({String? message}) : super(message ?? translate('not_found'));
}
