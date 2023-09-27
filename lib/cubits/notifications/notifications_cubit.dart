import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/notifications/user_notification.dart';
import '../../data/services/repository.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsInitial());

  final repository = Repository.instance;

  int _page = 1;

  Future<void> fetch(BuildContext context) async {
    try {
      emit(const NotificationsLoading());
      final response = await repository.notifications(context, page: _page);
      final notifications = response['notifications'] as List<UserNotification>;
      final perPage = response['per_page'] as int;
      _page++;
      if (notifications.isEmpty) {
        emit(const NotificationsEmpty());
        return;
      }
      emit(NotificationsLoaded(notifications,
          canFetchMore: notifications.length == perPage));
    } catch (e) {
      emit(NotificationsError('$e'));
    }
  }

  Future<void> fetchMore(BuildContext context) async {
    final notifications = (state as NotificationsLoaded).notifications;
    emit(NotificationsLoaded(notifications, hasEndedScrolling: true));
    final response = await repository.notifications(context, page: _page);
    final newNotifications =
        response['notifications'] as List<UserNotification>;
    final perPage = response['per_page'] as int;
    notifications.addAll(newNotifications);
    _page++;
    emit(NotificationsLoaded(
      notifications,
      hasEndedScrolling: false,
      canFetchMore: notifications.length == perPage,
    ));
  }
}
