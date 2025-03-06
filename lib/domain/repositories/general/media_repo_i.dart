import 'dart:io';

import '../../../core/results/result.dart';

abstract class IMediaRepo {
  Future<Result<String>> uploadImage(File image);
}
