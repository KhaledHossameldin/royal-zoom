abstract class BaseError {
  final String? message;
  final int? code;

  const BaseError(this.message, {this.code});
}
