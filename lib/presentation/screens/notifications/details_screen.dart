import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/brand_colors.dart';
import '../../../data/models/user_notification/user_notification.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key, required this.notification});

  final UserNotification notification;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.notifications)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 11.height,
          horizontal: 14.width,
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 11.height,
              horizontal: 14.width,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                          image: notification.sender?.image != null
                              ? NetworkImage(notification.sender!.image!)
                              : 'royake'.png.image,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    notification.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  subtitle: Text(
                    notification.sender?.previewName ?? '',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: BrandColors.gray,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        notification.id.toString(),
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: BrandColors.black,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy')
                            .add_jms()
                            .format(notification.createdAt!),
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: BrandColors.snowWhite,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    notification.content ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
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
    );
  }
}
