import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/utils/date_utils/date_utils.dart';
import '../../../../localization/localizor.dart';
import '../../../../utilities/extensions.dart';
import 'status_widget.dart';

class MajorItemWidget extends StatelessWidget {
  const MajorItemWidget({
    super.key,
    required this.id,
    required this.status,
    required this.parentMajor,
    required this.subMajor,
    required this.createdAt,
    required this.isMajorsTab,
    required this.chatId,
  });
  final int id;
  final int status;
  final String parentMajor;
  final String subMajor;
  final DateTime createdAt;
  final bool isMajorsTab;
  final int chatId;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.width),
          side: BorderSide(
            width: 0.3.width,
            color: BrandColors.gray,
          )),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 10.width, vertical: 12.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${Localizor.translator.hisotry}: ${DateUtil.dateWithTime(createdAt)}'),
                Text(
                  '${Localizor.translator.orderNumber}: $id',
                  style: AppStyle.smallTitleStyle,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    isMajorsTab
                        ? '${Localizor.translator.neededMajor}: $subMajor'
                        : '${Localizor.translator.getMajor(true)}: $subMajor',
                    maxLines: 2,
                    style: AppStyle.smallTitleStyle,
                  ),
                ),
                if (!isMajorsTab)
                  StatusWidget(
                    onChatTapped: () {
                      Navigator.of(context).pushNamed(Routes.chatDetails,
                          arguments: {'id': chatId});
                    },
                    status: status,
                  ),
              ],
            ),
            if (isMajorsTab)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${Localizor.translator.mainMajor}: $parentMajor',
                      style: AppStyle.smallTitleStyle,
                      maxLines: 2,
                    ),
                  ),
                  StatusWidget(
                    onChatTapped: () {
                      Navigator.of(context).pushNamed(Routes.chatDetails,
                          arguments: {'id': chatId});
                    },
                    status: status,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
