// ignore_for_file: annotate_overrides, overridden_fields

import 'base_error.dart';

class CustomError extends BaseError {
  final String? message;
  final int? statusCode;

  CustomError({
    this.message,
    this.statusCode,
  }) : super(message);

  @override
  String toString() {
    return 'CustomError{message: $message, statusCode: $statusCode)';
  }
}
