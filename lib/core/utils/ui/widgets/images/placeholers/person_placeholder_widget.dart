import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../core/di/di_manager.dart';

class PersonPlaceholderWidget extends StatelessWidget {
  const PersonPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        color: DIManager.findCC().primaryColor.withOpacity(0.08),
        // child: Icon(Icons.person,color: DependencyInjectionManager.findCC().greyLightTextColor,),
        child: Image.asset(
          AppAssets.person_placeholder,
          fit: BoxFit.contain,
          color: DIManager.findCC().greyLightTextColor,
        ),
      ),
    );
  }
}
