import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../utilities/extensions.dart';

class BrandBackButton extends StatelessWidget {
  const BrandBackButton({super.key, this.toHome = false});
  final bool toHome;
  @override
  Widget build(BuildContext context) => IconButton(
        icon: 'back'.svg,
        onPressed: () {
          if (toHome) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.home, (route) => false);
          } else {
            Navigator.of(context).pop();
          }
        },
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      );
}
