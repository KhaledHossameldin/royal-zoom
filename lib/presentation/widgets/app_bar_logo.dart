import 'package:flutter/material.dart';

import '../../utilities/extensions.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key, this.padding = 34.0});

  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding.width),
      child: 'royake'.png,
    );
  }
}
