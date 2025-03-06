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
              color: statusColor(status)[1],
              borderRadius: BorderRadius.circular(5.width)),
          alignment: Alignment.center,
          child: Text(
            Localizor.translator.getNewMajorStatus(status),
            style: TextStyle(color: statusColor(status)[0], fontSize: 12),
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
              padding: EdgeInsets.symmetric(horizontal: 8.width),
              decoration: BoxDecoration(
                  color: BrandColors.snowWhite,
                  borderRadius: BorderRadius.circular(5.width)),
              child: 'eye'.buildSVG(color: BrandColors.purple),
            ),
          ),
      ],
    );
  }

  List<Color> statusColor(int status) {
    switch (status) {
      case 1:
        return [BrandColors.orange, BrandColors.orange.withOpacity(0.2)];
      case 2:
        return [BrandColors.green, BrandColors.green.withOpacity(0.2)];
      default:
        return [BrandColors.red, BrandColors.red.withOpacity(0.2)];
    }
  }
}
