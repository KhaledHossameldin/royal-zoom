import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../utilities/extensions.dart';

class AttachmentMessageWidget extends StatelessWidget {
  const AttachmentMessageWidget({super.key, required this.attachmentUri});
  final String? attachmentUri;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.height,
          horizontal: 8.width,
        ),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: BrandColors.red,
        ),
        child: 'send_consultation'.svg,
      ),
      title: const Text('Document File'),
      onTap: () async {
        launchUrl(Uri.parse(attachmentUri ?? 'error'));
      },
    );
  }
}
