import '../../../core/errors/base_error.dart';
import '../../localization/localizor.dart';

class NetError extends BaseError {
  NetError() : super(Localizor.translator.httpError);
}
