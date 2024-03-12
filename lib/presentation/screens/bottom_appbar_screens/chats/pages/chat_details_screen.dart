import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../core/di/di_manager.dart';
import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../core/states/base_wait_state.dart';

import '../../../../../data/models/chat/chat_message.dart';
import '../../../../../data/models/new_chat/new_chat.dart';
import '../../../../../data/sources/local/shared_prefs.dart';
import '../../../../../localization/app_localizations.dart';
import '../../../../../utilities/extensions.dart';
import '../../../../widgets/reload_widget.dart';
import '../cubit/chats_cubit.dart';
import '../cubit/chats_state.dart';
import '../widgets/message_parent_widget.dart';
import '../widgets/send_message_widget.dart';

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

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  void initState() {
    super.initState();
    DIManager.findDep<ChatsCubit>().showChatMessages(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<ChatsCubit, ChatsState>(
      bloc: DIManager.findDep<ChatsCubit>(),
      listener: (context, state) {},
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
                      ? GroupedListView<ChatMessage, DateTime>(
                          elements: messages,
                          groupBy: (message) => DateTime(
                            message.createdAt!.year,
                            message.createdAt!.month,
                            message.createdAt!.day,
                          ),
                          reverse: true,
                          order: GroupedListOrder.DESC,
                          groupHeaderBuilder: (element) => 0.emptyHeight,
                          separator: 8.emptyHeight,
                          padding: EdgeInsets.symmetric(
                            vertical: 16.height,
                            horizontal: 16.width,
                          ),
                          itemBuilder: (context, message) {
                            final isSelf = DIManager.findDep<SharedPrefs>()
                                    .getUser()!
                                    .id ==
                                message.senderId!.toInt();
                            return Align(
                              alignment: isSelf
                                  ? AlignmentDirectional.centerStart
                                  : AlignmentDirectional.centerEnd,
                              child: MessageParentWidget(
                                message: message,
                                isSelf: isSelf,
                              ),
                            );
                          },
                        )
                      : Center(child: Text(appLocalizations.chatsEmpty)),
                ),
                SendMessageWidget(
                  chatId: widget.id,
                  isChatClosed: chat.isActive == 0,
                )
              ],
            ),
          );
        }

        if (messagesState is BaseFailState) {
          return ReloadWidget(
            title: messagesState.error!.message!,
            buttonText: appLocalizations.getReload(''),
            onPressed: () {
              DIManager.findDep<ChatsCubit>().showChatMessages(widget.id);
            },
          );
        }

        return const Material();
      },
    );
  }
}
