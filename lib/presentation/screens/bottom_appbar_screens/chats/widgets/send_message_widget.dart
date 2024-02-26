import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../core/di/di_manager.dart';
import '../../../../../core/states/base_wait_state.dart';
import '../../../../../cubits/chat_recording/chat_recording_cubit.dart';
import '../../../../../data/enums/chat_content_type.dart';
import '../../../../../localization/localizor.dart';
import '../../../../../utilities/extensions.dart';
import '../cubit/chats_cubit.dart';
import '../cubit/chats_state.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({
    super.key,
    required this.chatId,
    required this.isChatClosed,
  });
  final int chatId;
  final bool isChatClosed;

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget>
    with SingleTickerProviderStateMixin {
  final _messageController = TextEditingController();
  final ValueNotifier<bool> _isSending = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      bloc: DIManager.findDep<ChatsCubit>(),
      builder: (context, state) {
        final sendState = state.sendMessageState;
        _isSending.value = sendState is BaseLoadingState;
        return BottomAppBar(
          child: Padding(
            padding: EdgeInsets.only(
              left: 27.width,
              top: 24.height,
              right: 27.width,
              bottom: Platform.isAndroid ? 17.height : 0.0,
            ),
            child: BlocBuilder<ChatRecordingCubit, ChatRecordingState>(
              bloc: DIManager.findDep<ChatRecordingCubit>(),
              builder: (context, state) {
                return (widget.isChatClosed)
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('closed chat')],
                      )
                    : Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              final result =
                                  await FilePicker.platform.pickFiles();
                              if (result == null) return;
                              DIManager.findDep<ChatsCubit>().sendMessage(
                                chatId: widget.chatId,
                                content: result.files.single.path!,
                                contentType: ChatContentType.attachment,
                              );
                            },
                            icon: 'attachment'.imageIcon,
                            color: BrandColors.darkGray,
                          ),
                          Expanded(
                            child: state is ChatRecordingWorking
                                ? ValueListenableBuilder(
                                    valueListenable: state.seconds,
                                    builder: (context, value, child) => Align(
                                      alignment: Alignment.center,
                                      child: Text(value.seconds),
                                    ),
                                  )
                                : TextField(
                                    controller: _messageController,
                                    onTapOutside: (event) =>
                                        FocusScope.of(context).unfocus(),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText:
                                          '${Localizor.translator.yourMessage}...',
                                    ),
                                  ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (state is ChatRecordingWorking) {
                                DIManager.findDep<ChatRecordingCubit>()
                                    .cancelRecording();
                                return;
                              }
                              DIManager.findDep<ChatRecordingCubit>()
                                  .start(vsync: this);
                            },
                            icon: state is ChatRecordingWorking
                                ? const Icon(Icons.delete)
                                : 'microphone'.imageIcon,
                            color: BrandColors.darkGray,
                          ),
                          ValueListenableBuilder(
                            valueListenable: _isSending,
                            builder: (context, value, child) =>
                                FloatingActionButton(
                              heroTag: 'send-message-fab',
                              onPressed: value
                                  ? null
                                  : () async {
                                      if (state is ChatRecordingWorking) {
                                        DIManager.findDep<ChatRecordingCubit>()
                                            .stop(widget.chatId, ((uri) async {
                                          DIManager.findDep<ChatsCubit>()
                                              .sendMessage(
                                            chatId: widget.chatId,
                                            content: uri,
                                            contentType: ChatContentType.voice,
                                          );
                                        }));
                                      }
                                      if (_messageController.text.isEmpty) {
                                        return;
                                      }

                                      DIManager.findDep<ChatsCubit>()
                                          .sendMessage(
                                        chatId: widget.chatId,
                                        content: _messageController.text,
                                        contentType: ChatContentType.text,
                                      );
                                      _messageController.clear();
                                    },
                              elevation: 0.0,
                              highlightElevation: 0.0,
                              child: value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Icon(Icons.send),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _isSending.dispose();
    super.dispose();
  }
}
