import '../../../core/errors/base_error.dart';
import '../../localization/localizor.dart';

class TimeOutError extends BaseError {
  TimeOutError() : super(Localizor.translator.httpError);
}
