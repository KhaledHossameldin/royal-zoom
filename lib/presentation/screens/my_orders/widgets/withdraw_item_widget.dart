import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../domain/entities/withdraw_request_entity.dart';
import '../../../../utilities/extensions.dart';

class WithDrawItemWidget extends StatelessWidget {
  const WithDrawItemWidget({super.key, required this.item});
  final WithdrawRequesEntity item;
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
                  'رقم الطلب: ${item.id}',
                  style: AppStyle.smallTitleStyle,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.height, horizontal: 8.width),
                  decoration: BoxDecoration(
                      color: BrandColors.snowWhite,
                      borderRadius: BorderRadius.circular(5.width)),
                  child: Text(
                    item.getStatus(),
                    style: const TextStyle(color: BrandColors.green),
                  ),
                ),
              ],
            ),
            Text('التاريح: ${item.getCreatedAtTime()}'),
            const Divider(),
            Text(
              'المبلغ: ${item.amount}',
              style: AppStyle.smallTitleStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('نوع التحويل: ${item.transferType}'),
                if (item.chat != null)
                  Row(
                    children: [
                      const ImageIcon(
                          AssetImage(
                              'assets/images/bottom_app_bar_icons/chat.png'),
                          size: 20.0),
                      Text(
                        'التفاصيل',
                        style: AppStyle.smallTitleStyle,
                      )
                    ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
