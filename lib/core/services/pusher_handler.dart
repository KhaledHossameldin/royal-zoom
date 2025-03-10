import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherHandler {
  PusherHandler() {
    init();
  }
  bool _isSubscribed = false;
  final pusher = PusherChannelsFlutter.getInstance();
  Future<void> init() async => await pusher.init(
        apiKey: 'ef9b3a5d95c4f6628719',
        cluster: 'mt1',
      );

  Future<void> connect(dynamic onEvent) async {
    if (!_isSubscribed) {
      await pusher.subscribe(
        channelName: 'my-channel',
        onEvent: onEvent,
      );
      await pusher.connect();
      _isSubscribed = true;
    }
  }

  Future<void> disconnect() async {
    await pusher.unsubscribe(channelName: 'my-channel');
    await pusher.disconnect();
  }
}
