import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../core/di/di_manager.dart';
import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../core/states/base_wait_state.dart';
import '../../../../../cubits/chat_recording/chat_recording_cubit.dart';

import '../../../../../data/models/chat/chat_message.dart';
import '../../../../../data/models/new_chat/new_chat.dart';
import '../../../../../localization/app_localizations.dart';
import '../../../../../utilities/extensions.dart';
import '../../../../widgets/reload_widget.dart';
import '../cubit/chats_cubit.dart';
import '../cubit/chats_state.dart';
import '../widgets/message_parent_widget.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({
    super.key,
    required this.id,
    // required this.type,
    // required this.account,
    // this.chat,
  });

  final int id;
  // final ChatResourceType type;
  // final Account account;
  // final Chat? chat;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _messageController = TextEditingController();
  final ValueNotifier<bool> _isSending = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    DIManager.findDep<ChatsCubit>().showChatMessages(widget.id);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _isSending.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<ChatsCubit, ChatsState>(
      bloc: DIManager.findDep<ChatsCubit>(),
      listener: (context, state) {
        if (state.showChatMessagesState is BaseSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          });
        }
      },
      builder: (context, state) {
        final messagesState = state.showChatMessagesState;

        if (messagesState is BaseLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (messagesState is BaseSuccessState) {
          final messages = messagesState.data['messages'] as List<ChatMessage>;
          final chat = messagesState.data['chat'] as NewChat;
          return Scaffold(
            appBar: AppBar(
              title: ListTile(
                dense: true,
                leading: CircleAvatar(
                  radius: 16.width,
                  backgroundColor: Colors.white,
                  backgroundImage: chat.sender!.image!.isNotEmpty
                      ? NetworkImage(chat.sender!.image!)
                      : 'royake'.png.image,
                ),
                title: Text(chat.sender!.previewName ?? appLocalizations.none),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: messages.isNotEmpty
                      ? ListView.separated(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(
                            vertical: 16.height,
                            horizontal: 16.width,
                          ),
                          itemCount: messages.length,
                          separatorBuilder: (context, index) => 10.emptyHeight,
                          itemBuilder: (context, index) {
                            return MessageParentWidget(
                                message: messages[index]);
                          },
                        )
                      : Center(child: Text(appLocalizations.chatsEmpty)),
                ),
                BottomAppBar(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 27.width,
                      top: 24.height,
                      right: 27.width,
                      bottom: Platform.isAndroid ? 17.height : 0.0,
                    ),
                    child: BlocBuilder<ChatRecordingCubit, ChatRecordingState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result == null) return;
                                // if (!context.mounted) return;
                                // await context.read<ChatsCubit>().send(
                                //       context,
                                //       isSending: _isSending,
                                //       content: result.files.single.path!,
                                //       type: ChatContentType.attachment,
                                //     );
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
                                            '${appLocalizations.yourMessage}...',
                                      ),
                                    ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (state is ChatRecordingWorking) {
                                  context.read<ChatRecordingCubit>().stop();
                                  return;
                                }
                                context
                                    .read<ChatRecordingCubit>()
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
                                          await context
                                              .read<ChatRecordingCubit>()
                                              .stop();
                                          if (!context.mounted) {
                                            return;
                                          }
                                          // await context
                                          //     .read<ChatsCubit>()
                                          //     .send(
                                          //       context,
                                          //       isSending: _isSending,
                                          //       content: context
                                          //           .read<
                                          //               ChatRecordingCubit>()
                                          //           .recordPath!,
                                          //       type: ChatContentType.voice,
                                          //     );
                                          return;
                                        }
                                        if (_messageController.text.isEmpty) {
                                          return;
                                        }
                                        // await context.read<ChatsCubit>().send(
                                        //       context,
                                        //       isSending: _isSending,
                                        //       content:
                                        //           _messageController.text,
                                        //       type: state
                                        //               is ChatRecordingWorking
                                        //           ? ChatContentType.voice
                                        //           : ChatContentType.text,
                                        //     );
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
                ),
              ],
            ),
          );
        }

        if (messagesState is BaseFailState) {
          return ReloadWidget(
            title: messagesState.error!.message!,
            buttonText: appLocalizations.getReload(''),
            // onPressed: () => context
            //     .read<ChatsCubit>()
            //     .fetch(context, id: widget.id, type: widget.type),
            onPressed: () {},
          );
        }

        return const Material();
      },
    );
  }
}
