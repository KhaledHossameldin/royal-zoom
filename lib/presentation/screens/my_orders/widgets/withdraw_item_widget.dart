import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../domain/entities/withdraw_request_entity.dart';
import '../../../../localization/localizor.dart';
import '../../../../utilities/extensions.dart';
import 'status_widget.dart';

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
                    '${Localizor.translator.hisotry}: ${item.getCreatedAtTime()}'),
                Text(
                  '${Localizor.translator.orderNumber} ${item.id}',
                  style: AppStyle.smallTitleStyle,
                ),
              ],
            ),
            const Divider(),
            Text(
              '${Localizor.translator.amount}: ${item.amount}',
              style: AppStyle.smallTitleStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${Localizor.translator.transferType}: ${Localizor.translator.getWithdrawStatus(item.transferType!.toInt())}'),
                StatusWidget(
                  onChatTapped: () {
                    Navigator.of(context).pushNamed(Routes.chatDetails,
                        arguments: {'id': item.chat?.id});
                  },
                  status: item.status!.toInt(),
                  isChatVisible: item.chat != null,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
