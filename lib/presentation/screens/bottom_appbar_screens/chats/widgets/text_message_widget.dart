import 'package:flutter/material.dart';

import '../../../../../localization/localizor.dart';

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({super.key, required this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Text(message ?? Localizor.translator.none);
  }
}
