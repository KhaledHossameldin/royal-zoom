import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../constants/brand_colors.dart';
import '../../cubits/chat_messages/chat_messages_cubit.dart';
import '../../cubits/chat_recording/chat_recording_cubit.dart';
import '../../data/enums/chat_content_type.dart';
import '../../data/enums/chat_resource_type.dart';
import '../../data/models/account.dart';
import '../../localization/app_localizations.dart';
import '../../utilities/extensions.dart';
import '../widgets/reload_widget.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({
    super.key,
    required this.id,
    required this.type,
    required this.account,
  });

  final int id;
  final ChatResourceType type;
  final Account account;

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
    context
        .read<ChatMessagesCubit>()
        .fetch(context, id: widget.id, type: widget.type);
    super.initState();
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

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          dense: true,
          leading: CircleAvatar(
            radius: 16.width,
            backgroundColor: Colors.white,
            backgroundImage: widget.account.image.isNotEmpty
                ? NetworkImage(widget.account.image)
                : 'royake'.png.image,
          ),
          title: Text(widget.account.previewName ?? appLocalizations.none),
        ),
      ),
      body: BlocConsumer<ChatMessagesCubit, ChatMessagesState>(
        listener: (context, state) {
          if (state is ChatMessagesLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent);
            });
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatMessagesLoading:
              return const Center(child: CircularProgressIndicator());

            case ChatMessagesLoaded:
              final messages = (state as ChatMessagesLoaded).messages;
              return Column(
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
                            separatorBuilder: (context, index) =>
                                10.emptyHeight,
                            itemBuilder: (context, index) {
                              final isSelf = messages[index].senderId ==
                                  context
                                      .read<AuthenticationBloc>()
                                      .user!
                                      .data
                                      .id;
                              return UnconstrainedBox(
                                alignment: isSelf
                                    ? AlignmentDirectional.centerStart
                                    : AlignmentDirectional.centerEnd,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.height,
                                    horizontal: 10.width,
                                  ),
                                  constraints:
                                      BoxConstraints(maxWidth: 320.width),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.only(
                                      topEnd: const Radius.circular(26.0),
                                      topStart: const Radius.circular(26.0),
                                      bottomEnd:
                                          Radius.circular(isSelf ? 26.0 : 3.0),
                                      bottomStart:
                                          Radius.circular(isSelf ? 3.0 : 26.0),
                                    ),
                                    color: isSelf
                                        ? BrandColors.snowWhite
                                        : BrandColors.darkGreen,
                                  ),
                                  child: Builder(builder: (context) {
                                    if (messages[index].contentType ==
                                        ChatContentType.attachment) {
                                      return ListTile(
                                        dense: true,
                                        leading: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.height,
                                            horizontal: 8.width,
                                          ),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: BrandColors.red,
                                          ),
                                          child: 'send_consultation'.svg,
                                        ),
                                        title: const Text('Document File'),
                                        onTap: () async {
                                          launchUrl(Uri.parse(
                                              messages[index].content));
                                        },
                                      );
                                    }
                                    if (messages[index].contentType ==
                                        ChatContentType.voice) {
                                      if (messages[index].player == null) {
                                        return const Text(
                                            'لا يمكن تشغيل الصوت');
                                      }
                                      return Row(
                                        children: [
                                          Text(
                                            messages[index]
                                                .player!
                                                .duration!
                                                .audioTime,
                                            style: TextStyle(
                                              fontSize: 9.0,
                                              color: isSelf
                                                  ? BrandColors.black
                                                  : BrandColors.snowWhite,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          8.emptyWidth,
                                          Expanded(
                                            child: StreamBuilder(
                                              stream: messages[index]
                                                  .player!
                                                  .positionStream,
                                              builder: (context, snapshot) =>
                                                  Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: LinearProgressIndicator(
                                                  color: isSelf
                                                      ? BrandColors.darkGreen
                                                      : BrandColors.snowWhite,
                                                  backgroundColor: Colors.grey,
                                                  value: (snapshot.data ??
                                                              Duration.zero)
                                                          .inSeconds /
                                                      max(
                                                          messages[index]
                                                              .player!
                                                              .duration!
                                                              .inSeconds,
                                                          1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          8.emptyWidth,
                                          FloatingActionButton.small(
                                            elevation: 0.0,
                                            backgroundColor: isSelf
                                                ? BrandColors.darkGreen
                                                : BrandColors.snowWhite,
                                            heroTag: 'id-${messages[index].id}',
                                            child: Icon(
                                              Icons.play_arrow_rounded,
                                              color: !isSelf
                                                  ? BrandColors.darkGreen
                                                  : null,
                                            ),
                                            onPressed: () async {
                                              await messages[index]
                                                  .player!
                                                  .seek(Duration.zero);
                                              messages[index].player!.play();
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                    return Text(messages[index].content);
                                  }),
                                ),
                              );
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
                      child:
                          BlocBuilder<ChatRecordingCubit, ChatRecordingState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  final result =
                                      await FilePicker.platform.pickFiles();
                                  if (result == null) return;
                                  if (!context.mounted) return;
                                  await context.read<ChatMessagesCubit>().send(
                                        context,
                                        isSending: _isSending,
                                        content: result.files.single.path!,
                                        type: ChatContentType.attachment,
                                      );
                                },
                                icon: 'attachment'.imageIcon,
                                color: BrandColors.darkGray,
                              ),
                              Expanded(
                                child: state is ChatRecordingWorking
                                    ? ValueListenableBuilder(
                                        valueListenable: state.seconds,
                                        builder: (context, value, child) =>
                                            Align(
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
                                            await context
                                                .read<ChatMessagesCubit>()
                                                .send(
                                                  context,
                                                  isSending: _isSending,
                                                  content: context
                                                      .read<
                                                          ChatRecordingCubit>()
                                                      .recordPath!,
                                                  type: ChatContentType.voice,
                                                );
                                            return;
                                          }
                                          if (_messageController.text.isEmpty) {
                                            return;
                                          }
                                          await context
                                              .read<ChatMessagesCubit>()
                                              .send(
                                                context,
                                                isSending: _isSending,
                                                content:
                                                    _messageController.text,
                                                type: state
                                                        is ChatRecordingWorking
                                                    ? ChatContentType.voice
                                                    : ChatContentType.text,
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
                  ),
                ],
              );

            case ChatMessagesError:
              return ReloadWidget(
                title: (state as ChatMessagesError).message,
                buttonText: appLocalizations.getReload(''),
                onPressed: () => context
                    .read<ChatMessagesCubit>()
                    .fetch(context, id: widget.id, type: widget.type),
              );

            default:
              return const Material();
          }
        },
      ),
    );
  }
}
