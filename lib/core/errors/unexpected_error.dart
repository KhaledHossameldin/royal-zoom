import '../../localization/localizor.dart';
import 'base_error.dart';

class UnExpectedError extends BaseError {
  UnExpectedError() : super(Localizor.translator.unknownError);
}
