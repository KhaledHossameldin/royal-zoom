import 'package:flutter/material.dart';
import 'package:royake_mobile/utilities/extensions.dart';

class ReloadWidget extends StatelessWidget {
  const ReloadWidget({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textTheme.headlineSmall,
          ),
          24.emptyHeight,
          FractionallySizedBox(
            widthFactor: 0.6,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
