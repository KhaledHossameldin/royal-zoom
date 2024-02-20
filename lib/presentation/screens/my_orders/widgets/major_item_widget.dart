import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/utils/date_utils/date_utils.dart';
import '../../../../data/enums/new_major_status.dart';
import '../../../../utilities/extensions.dart';

class MajorItemWidget extends StatelessWidget {
  const MajorItemWidget({
    super.key,
    required this.id,
    required this.status,
    required this.parentMajor,
    required this.subMajor,
    required this.createdAt,
    required this.isMajorsTab,
  });
  final int id;
  final int status;
  final String parentMajor;
  final String subMajor;
  final DateTime createdAt;
  final bool isMajorsTab;

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
                  'رقم الطلب: $id',
                  style: AppStyle.smallTitleStyle,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.height, horizontal: 8.width),
                  decoration: BoxDecoration(
                      color: BrandColors.snowWhite,
                      borderRadius: BorderRadius.circular(5.width)),
                  child: Text(
                    status.newMajorStatusFromMap().name,
                    style: const TextStyle(color: BrandColors.green),
                  ),
                ),
              ],
            ),
            Text('التاريح: ${DateUtil.dateWithTime(createdAt)}'),
            const Divider(),
            Text(
              'التخصص ${isMajorsTab ? "المطلوب" : "الفرعي"}: $subMajor',
              style: AppStyle.smallTitleStyle,
            ),
            Text(
              'التخصص الرئيسي: $parentMajor',
              style: AppStyle.smallTitleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
