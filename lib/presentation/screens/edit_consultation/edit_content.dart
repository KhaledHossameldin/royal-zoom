import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../constants/brand_colors.dart';
import '../../../constants/routes.dart';
import '../../../data/enums/chat_resource_type.dart';
import '../../../data/enums/consultation_content_type.dart';
import '../../../data/models/consultations/details.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

class EditConsultationContent extends StatefulWidget {
  const EditConsultationContent({super.key});

  @override
  State<EditConsultationContent> createState() =>
      _EditConsultationContentState();
}

class _EditConsultationContentState extends State<EditConsultationContent> {
  final _contentController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _contentController.text =
          (ModalRoute.of(context)!.settings.arguments as ConsultationDetails)
              .content;
    });
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final consultation =
        ModalRoute.of(context)!.settings.arguments as ConsultationDetails;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appLocalizations.editConsultation),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 27.width,
          vertical: 18.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.consultationContent,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            _Content(
              type: consultation.contentType,
              content: consultation.content,
              player: consultation.audioPlayer,
              controller: _contentController,
            ),
            if (consultation.consultant != null)
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.chatDetails,
                  arguments: {
                    'id': consultation.id,
                    'type': ChatResourceType.consultation,
                    'account': consultation.consultant!,
                  },
                ),
                icon: 'chat'.buildSVG(
                  color: Colors.white,
                  blendMode: BlendMode.srcATop,
                ),
                label: Text(appLocalizations.changeContentRequest),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.only(
            left: 27.width,
            top: 24.height,
            right: 27.width,
            bottom: Platform.isAndroid ? 17.height : 0.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: Text(appLocalizations.previous),
                ),
              ),
              10.emptyWidth,
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      Routes.editConsultantResponse,
                      arguments: consultation,
                    ),
                    icon: const Icon(Icons.keyboard_double_arrow_left_outlined),
                    label: Text(appLocalizations.next),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.type,
    required this.content,
    required this.player,
    required this.controller,
  });

  final ConsultationContentType type;
  final String content;
  final AudioPlayer? player;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.height),
      child: Builder(
        builder: (context) {
          if (type == ConsultationContentType.text) {
            return TextField(controller: controller);
          }
          if (player == null) {
            return Text(appLocalizations.cannotPlayAudio);
          }
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.width,
              vertical: 8.height,
            ),
            decoration: BoxDecoration(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(29.0),
            ),
            child: Row(
              children: [
                Text(
                  player!.duration!.audioTime,
                  style: const TextStyle(
                    fontSize: 9.0,
                    color: BrandColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.emptyWidth,
                Expanded(
                  child: StreamBuilder(
                    stream: player!.positionStream,
                    builder: (context, snapshot) => Directionality(
                      textDirection: TextDirection.ltr,
                      child: LinearProgressIndicator(
                        color: BrandColors.darkGreen,
                        backgroundColor: Colors.grey,
                        value: (snapshot.data ?? Duration.zero).inSeconds /
                            max(player!.duration!.inSeconds, 1),
                      ),
                    ),
                  ),
                ),
                8.emptyWidth,
                FloatingActionButton.small(
                  elevation: 0.0,
                  backgroundColor: BrandColors.darkGreen,
                  heroTag: 'change-consultation-details',
                  child: const Icon(Icons.play_arrow_rounded),
                  onPressed: () async {
                    await player!.seek(Duration.zero);
                    player!.play();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
