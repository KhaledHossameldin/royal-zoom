import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../constants/brand_colors.dart';
import '../../../constants/routes.dart';
import '../../../cubits/notifications/notifications_cubit.dart';
import '../../../data/enums/notifications_read_status.dart';
import '../../widgets/reload_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    context.read<NotificationsCubit>().fetch(context);
    super.initState();
  }

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
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case NotificationsLoading:
                return const Center(child: CircularProgressIndicator());

              case NotificationsEmpty:
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      'notifications'.lottie,
                      Text(
                        appLocalizations.notificationsEmpty,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );

              case NotificationsError:
                return ReloadWidget(
                  title: (state as NotificationsError).message,
                  buttonText: appLocalizations.getReload(''),
                  onPressed: () =>
                      context.read<NotificationsCubit>().fetch(context),
                );

              case NotificationsLoaded:
                final notifications =
                    (state as NotificationsLoaded).notifications;
                return Scrollbar(
                  notificationPredicate: (notification) {
                    if (!state.canFetchMore || state.hasEndedScrolling) {
                      return false;
                    }
                    if (notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent) {
                      context.read<NotificationsCubit>().fetchMore(context);
                    }
                    return false;
                  },
                  child: CustomScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.height,
                        ),
                        sliver: SliverList.separated(
                          itemCount: notifications.length,
                          separatorBuilder: (context, index) => 9.emptyHeight,
                          itemBuilder: (context, index) => Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 21.width,
                            ),
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
                                      leading: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: BrandColors.orange),
                                            ),
                                            child: Container(
                                              width: 46.width,
                                              height: 46.height,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2.0),
                                                image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: notifications[index]
                                                              .sender
                                                              .image !=
                                                          null
                                                      ? NetworkImage(
                                                          notifications[index]
                                                              .sender
                                                              .image!)
                                                      : 'royake'.png.image,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (notifications[index]
                                              .sender
                                              .isActive)
                                            Positioned(
                                              bottom: 0,
                                              left: 5.width,
                                              right: 5.width,
                                              child: Container(
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 3.width,
                                                      backgroundColor:
                                                          BrandColors.green,
                                                    ),
                                                    Text(
                                                      appLocalizations.active,
                                                      style: const TextStyle(
                                                        fontSize: 7,
                                                        color:
                                                            BrandColors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      title: Text(
                                        notifications[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                      subtitle: Text(
                                        notifications[index].sender.name,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: BrandColors.gray,
                                        ),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            notifications[index].id.toString(),
                                            style: const TextStyle(
                                              fontSize: 10.0,
                                              color: BrandColors.black,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yyyy')
                                                .add_jms()
                                                .format(notifications[index]
                                                    .createdAt),
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Text(
                                        notifications[index].content,
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
                        ),
                      ),
                      if (state.canFetchMore)
                        SliverPadding(
                          padding: EdgeInsets.symmetric(vertical: 16.height),
                          sliver: const SliverToBoxAdapter(
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ),
                    ],
                  ),
                );

              default:
                return const Material();
            }
          },
        ));
  }
}
