import '../../../core/errors/base_error.dart';
import '../../../core/utils/localization/app_localizations.dart';

class NetError extends BaseError {
  NetError() : super(translate('connection_err'));
}
