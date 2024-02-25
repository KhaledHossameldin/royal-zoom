import 'package:flutter/material.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../core/di/di_manager.dart';
import '../../../../../data/enums/chat_content_type.dart';
import '../../../../../data/models/chat/chat_message.dart';
import '../../../../../data/sources/local/shared_prefs.dart';
import '../../../../../utilities/extensions.dart';
import 'attachment_message_widget.dart';
import 'text_message_widget.dart';
import 'voice_message_widget.dart';

class MessageParentWidget extends StatelessWidget {
  const MessageParentWidget({super.key, required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isSelf = DIManager.findDep<SharedPrefs>().getUser()!.data.id ==
        message.senderId!.toInt();
    return UnconstrainedBox(
      alignment: isSelf
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.height,
          horizontal: 10.width,
        ),
        constraints: BoxConstraints(maxWidth: 320.width),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: const Radius.circular(26.0),
            topStart: const Radius.circular(26.0),
            bottomEnd: Radius.circular(isSelf ? 26.0 : 3.0),
            bottomStart: Radius.circular(isSelf ? 3.0 : 26.0),
          ),
          color: isSelf ? BrandColors.snowWhite : BrandColors.darkGreen,
        ),
        child: _buildMessageType(),
      ),
    );
  }

  Widget _buildMessageType() {
    if (message.contentType == ChatContentType.text) {
      return TextMessageWidget(message: message.content);
    }
    if (message.contentType == ChatContentType.attachment) {
      return AttachmentMessageWidget(attachmentUri: message.content);
    }

    return const VoiceMessageWidget();
  }
}
