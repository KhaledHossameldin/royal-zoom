import '../../core/services/pusher_handler.dart';

class ConnectToPusherUseCase implements IConnectToPusherUseCase {
  final PusherHandler _pusher;
  ConnectToPusherUseCase(this._pusher);
  @override
  Future<void> call(Function(dynamic event) onEvent) async {
    return await _pusher.connect(onEvent);
  }
}

abstract class IConnectToPusherUseCase {
  Future<void> call(Function(dynamic event) onEvent);
}
