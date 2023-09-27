part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {
  const NotificationsState();
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsLoaded extends NotificationsState {
  final List<UserNotification> notifications;
  final bool hasEndedScrolling;
  final bool canFetchMore;
  const NotificationsLoaded(
    this.notifications, {
    this.hasEndedScrolling = false,
    this.canFetchMore = true,
  });
}

class NotificationsEmpty extends NotificationsState {
  const NotificationsEmpty();
}

class NotificationsError extends NotificationsState {
  final String message;
  const NotificationsError(this.message);
}
