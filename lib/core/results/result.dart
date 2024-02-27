import '../../../core/errors/base_error.dart';
import '../../data/models/meta.dart';

class Result<Data> {
  final Data? data;
  final Meta? meta;
  final BaseError? error;

  Result({this.data, this.meta, this.error})
      : assert(data != null || error != null);

  bool get hasDataOnly => data != null && error == null;

  bool get hasErrorOnly => data == null && error != null;

  @override
  String toString() {
    return 'Result{data: $data, error: $error}';
  }
}
