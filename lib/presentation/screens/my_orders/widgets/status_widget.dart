import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../localization/localizor.dart';
import '../../../../utilities/extensions.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.onChatTapped,
    required this.status,
    this.isChatVisible = true,
  });
  final Function() onChatTapped;
  final int status;
  final bool isChatVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 42.height,
          padding: EdgeInsets.symmetric(horizontal: 8.width),
          decoration: BoxDecoration(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(5.width)),
          alignment: Alignment.center,
          child: Text(
            Localizor.translator.getNewMajorStatus(status),
            style: TextStyle(color: statusColor(status), fontSize: 12),
          ),
        ),
        if (isChatVisible) 2.emptyWidth,
        if (isChatVisible)
          InkWell(
            onTap: () {
              onChatTapped();
            },
            child: Container(
                height: 42.height,
                padding: EdgeInsets.symmetric(
                    vertical: 8.height, horizontal: 8.width),
                decoration: BoxDecoration(
                    color: BrandColors.snowWhite,
                    borderRadius: BorderRadius.circular(5.width)),
                child: const ImageIcon(
                    AssetImage('assets/images/bottom_app_bar_icons/chat.png'))),
          ),
      ],
    );
  }

  Color statusColor(int status) {
    switch (status) {
      case 1:
        return BrandColors.orange;
      case 2:
        return BrandColors.green;
      default:
        return BrandColors.red;
    }
  }
}
