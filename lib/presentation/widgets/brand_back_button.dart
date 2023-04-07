import 'package:flutter/material.dart';
import 'package:royake_mobile/utilities/extensions.dart';

class BrandBackButton extends StatelessWidget {
  const BrandBackButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        icon: 'back'.svg,
        onPressed: () => Navigator.pop(context),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      );
}
