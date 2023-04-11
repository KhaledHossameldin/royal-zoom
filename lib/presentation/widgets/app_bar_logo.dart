import 'package:flutter/material.dart';

import '../../constants/hero_tags.dart';
import '../../utilities/extensions.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.width),
      child: Hero(tag: HeroTags.appLogo, child: 'royake'.png),
    );
  }
}
