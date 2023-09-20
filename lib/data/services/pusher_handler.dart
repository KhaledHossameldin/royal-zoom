import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherHandler {
  static PusherHandler instance = PusherHandler._();
  PusherHandler._();

  final pusher = PusherChannelsFlutter.getInstance();

  Future<void> connect(int chatId, dynamic onEvent) async {
    await pusher.subscribe(
      // channelName: 'new-chat-message-$chatId',
      channelName: 'my-channel',
      onEvent: onEvent,
    );
    await pusher.connect();
  }

  Future<void> disconnect(int chatId) async {
    await pusher.unsubscribe(channelName: 'my-channel');
    // await pusher.unsubscribe(channelName: 'new-chat-message-$chatId');
    await pusher.disconnect();
  }

  Future<void> init() async => await pusher.init(
        apiKey: 'ef9b3a5d95c4f6628719',
        cluster: 'mt1',
      );
}
