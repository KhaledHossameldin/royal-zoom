import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../../../constants/brand_colors.dart';
import '../../../../../core/di/di_manager.dart';
import '../../../../../core/states/base_wait_state.dart';
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
  final RecorderController _recorderController = RecorderController();

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
            child: (widget.isChatClosed)
                ? _buildClosedChat()
                : Row(
                    children: [
                      _buildAttachmentButton(),
                      _buildChatTextWavesWidget(),
                      _buildRecordOrCancelWidget(),
                      _buildSendButton(),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildChatTextWavesWidget() {
    return Expanded(
      child: _recorderController.isRecording
          ? _buildRecordingWavesWidget()
          : TextField(
              controller: _messageController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                isDense: true,
                hintText: '${Localizor.translator.yourMessage}...',
              ),
            ),
    );
  }

  Widget _buildRecordingWavesWidget() {
    return AudioWaveforms(
      size: Size(200.width, 50.height),
      recorderController: _recorderController,
      waveStyle: const WaveStyle(
        showMiddleLine: false,
        extendWaveform: true,
      ),
    );
  }

  Widget _buildClosedChat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(Localizor.translator.closedChat)],
    );
  }

  Widget _buildAttachmentButton() {
    return IconButton(
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        DIManager.findDep<ChatsCubit>().sendMessage(
          chatId: widget.chatId,
          content: result.files.single.path!,
          contentType: ChatContentType.attachment,
        );
      },
      icon: 'attachment'.imageIcon,
      color: BrandColors.darkGray,
    );
  }

  Widget _buildSendButton() {
    return ValueListenableBuilder(
      valueListenable: _isSending,
      builder: (context, value, child) => FloatingActionButton(
        heroTag: 'send-message-fab',
        onPressed: value
            ? null
            : () async {
                if (_recorderController.isRecording) {
                  final path = await _recorderController.stop();
                  Logger().d(path);
                  DIManager.findDep<ChatsCubit>().sendMessage(
                    chatId: widget.chatId,
                    content: path!,
                    contentType: ChatContentType.voice,
                  );
                }
                if (_messageController.text.isEmpty) {
                  return;
                }

                DIManager.findDep<ChatsCubit>().sendMessage(
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
    );
  }

  Widget _buildRecordOrCancelWidget() {
    return IconButton(
      onPressed: () async {
        if (_recorderController.isRecording) {
          _recorderController.pause();
        } else {
          _recorderController.record();
        }
      },
      icon: _recorderController.isRecording
          ? const Icon(Icons.delete)
          : 'microphone'.imageIcon,
      color: BrandColors.darkGray,
    );
  }

  @override
  void initState() {
    super.initState();
    _recorderController.onRecorderStateChanged.listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _isSending.dispose();
    _recorderController.dispose();
    super.dispose();
  }
}
