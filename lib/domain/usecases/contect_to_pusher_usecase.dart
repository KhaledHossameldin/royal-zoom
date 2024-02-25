import '../../core/services/pusher_handler.dart';

class ConnectToPusherUseCase implements IConnectToPusherUseCase {
  final PusherHandler _pusher;
  ConnectToPusherUseCase(this._pusher);
  @override
  Future<void> call(int chatId, Function(dynamic event) onEvent) async {
    return await _pusher.connect(chatId, onEvent);
  }
}

abstract class IConnectToPusherUseCase {
  Future<void> call(int chatId, Function(dynamic event) onEvent);
}
