import '../../localization/localizor.dart';
import 'base_error.dart';

class NotFoundError extends BaseError {
  NotFoundError({String? message})
      : super(message ?? Localizor.translator.httpError);
}
