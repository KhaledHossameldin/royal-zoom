import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../localization/app_localizations.dart';
import '../../../../../../utilities/extensions.dart';
import '../../../../../constants/brand_colors.dart';
import '../../../../../constants/routes.dart';
import '../../../../../core/di/di_manager.dart';
import '../../../../../core/states/base_fail_state.dart';
import '../../../../../core/states/base_success_state.dart';
import '../../../../../core/states/base_wait_state.dart';
import '../../../../../data/models/new_chat/new_chat.dart';
import '../../../../widgets/reload_widget.dart';
import '../cubit/chats_cubit.dart';
import '../cubit/chats_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    DIManager.findDep<ChatsCubit>().showAllChats();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.chat),
      ),
      body: BlocBuilder<ChatsCubit, ChatsState>(
        bloc: DIManager.findDep<ChatsCubit>(),
        builder: (context, state) {
          final chatsState = state.showAllChatsState;

          if (chatsState is BaseLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          // case ChatsEmpty:
          // return SizedBox(
          //   width: double.infinity,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       'chat'.lottie,
          //       Text(appLocalizations.chatEmpty,
          //           style: textTheme.bodyMedium),
          //     ],
          //   ),
          // );

          if (chatsState is BaseSuccessState) {
            final chats = (state.showAllChatsState as BaseSuccessState).data
                as List<NewChat>;
            if (chats.isEmpty) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'chat'.lottie,
                    Text(appLocalizations.chatEmpty,
                        style: textTheme.bodyMedium),
                  ],
                ),
              );
            }
            return ListView.separated(
              itemCount: chats.length,
              padding: EdgeInsets.symmetric(
                vertical: 15.height,
                horizontal: 19.width,
              ),
              separatorBuilder: (context, index) => 10.emptyHeight,
              itemBuilder: (context, index) => Card(
                child: Slidable(
                  startActionPane: ActionPane(
                    extentRatio: 0.25,
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        icon: Icons.drafts,
                        backgroundColor: Colors.green,
                        borderRadius: BorderRadius.horizontal(
                          right: appLocalizations.locale.languageCode == 'ar'
                              ? const Radius.circular(10.0)
                              : Radius.zero,
                          left: appLocalizations.locale.languageCode == 'ar'
                              ? Radius.zero
                              : const Radius.circular(10.0),
                        ),
                        onPressed: (context) {},
                      ),
                    ],
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    leading: CircleAvatar(
                      radius: 21.0,
                      backgroundColor: BrandColors.orange,
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.white,
                        backgroundImage: chats[index].sender!.image!.isNotEmpty
                            ? NetworkImage(chats[index].sender!.image!)
                            : 'royake'.png.image,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chats[index].sender?.previewName ??
                              appLocalizations.none,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: BrandColors.darkGreen,
                          ),
                        ),
                        Text(
                          chats[index].resourceId.toString(),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: BrandColors.darkGreen,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.chatDetails,
                      arguments: {
                        'id': chats[index].id!.toInt(),
                        // 'type': chats[index].resourceType,
                        // 'account': chats[index].receiver,
                      },
                    ),
                  ),
                ),
              ),
            );
          }
          if (chatsState is BaseFailState) {
            return ReloadWidget(
              title: (state.showAllChatsState as BaseFailState).error!.message!,
              buttonText: appLocalizations.getReload(''),
              onPressed: () => DIManager.findDep<ChatsCubit>().showAllChats(),
            );
          }

          return const Placeholder();
        },
      ),
    );
  }
}
