import 'dart:ui';

import 'base_states.dart';

import '../../../core/errors/base_error.dart';

class BaseFailState extends BaseState {
  final BaseError? error;
  final VoidCallback? callback;

  const BaseFailState(this.error, {this.callback});
}
