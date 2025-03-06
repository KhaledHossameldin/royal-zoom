import '../../../core/errors/base_error.dart';
import '../../localization/localizor.dart';

class ForbiddenError extends BaseError {
  ForbiddenError() : super(Localizor.translator.httpError);
}
