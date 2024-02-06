import '../../../core/errors/base_error.dart';
import '../../../core/utils/localization/app_localizations.dart';

class TimeOutError extends BaseError {
  TimeOutError() : super(translate('time_out'));
}
