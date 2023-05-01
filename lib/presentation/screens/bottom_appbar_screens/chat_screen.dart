import 'package:flutter/material.dart';

import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.chat),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            'chat'.lottie,
            Text(appLocalizations.chatEmpty, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
