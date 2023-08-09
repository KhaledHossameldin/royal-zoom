import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../constants/brand_colors.dart';
import '../../../constants/routes.dart';
import '../../../data/enums/notifications_read_status.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.notifications),
        actions: [
          PopupMenuButton<NotificationsReadStatus>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: NotificationsReadStatus.markAsRead,
                child: Text(appLocalizations.markAllRead),
              ),
              PopupMenuItem(
                value: NotificationsReadStatus.markAsUnread,
                child: Text(appLocalizations.markAllUnread),
              ),
            ],
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: 16.height,
          horizontal: 21.width,
        ),
        itemCount: 5,
        separatorBuilder: (context, index) => 9.emptyHeight,
        itemBuilder: (context, index) => Card(
          child: InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.notificationDetails,
            ),
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 11.height,
                horizontal: 14.width,
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: BrandColors.orange),
                      ),
                      child: Container(
                        width: 46.width,
                        height: 46.height,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.0),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: 'royake'.png.image,
                            // image: consultant.image.isNotEmpty
                            //     ? NetworkImage(consultant.image)
                            //     : 'royake'.png.image,
                          ),
                        ),
                      ),
                    ),
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('name', style: TextStyle(fontSize: 14.0)),
                        Text('id', style: TextStyle(fontSize: 10.0)),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'major',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: BrandColors.gray,
                          ),
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy')
                              .add_jms()
                              .format(DateTime.now()),
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: BrandColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 11.height,
                      horizontal: 14.width,
                    ),
                    decoration: BoxDecoration(
                      color: BrandColors.snowWhite,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      'و سأعرض مثال حي لهذا، من منا لم يتحمل جهد بدني شاق إلا من أجل الحصول على ميزة أو فائدة؟ ولكن من لديه الحق أن ينتقد شخص ما أراد أن يشعر بالسعادة التي لا تشوبها عواقب أليمة أو آخر أراد أن يتجنب الألم الذي ربما تنجم عنه بعض المتعة ؟ … علي الجانب الآخر نشجب ونستنكر هؤلاء الرجال المفتونون',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: BrandColors.darkBlackGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // body: SizedBox(
      //   width: double.infinity,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       'notifications'.lottie,
      //       Text(
      //         appLocalizations.notificationsEmpty,
      //         style: textTheme.bodyMedium,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
