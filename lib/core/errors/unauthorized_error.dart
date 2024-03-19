import '../../localization/localizor.dart';
import 'base_error.dart';

class UnauthorizedError extends BaseError {
  UnauthorizedError({String? message, int? code})
      : super(message ?? Localizor.translator.httpError, code: code);
}
