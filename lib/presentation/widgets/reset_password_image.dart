import 'package:flutter/material.dart';

import '../../constants/hero_tags.dart';
import '../../utilities/extensions.dart';

class ResetPasswordImage extends StatelessWidget {
  const ResetPasswordImage({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 190.width,
        child: Hero(
          tag: HeroTags.restPasswordImage,
          child: 'reset-password'.png,
        ),
      );
}
