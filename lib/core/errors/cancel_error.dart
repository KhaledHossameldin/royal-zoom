import '../../localization/localizor.dart';
import 'base_error.dart';

class CancelError extends BaseError {
  CancelError({String? message})
      : super(message ?? Localizor.translator.cancelled);
}
