import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/fast_consultation/fast_consultation_cubit.dart';
import '../../../../data/enums/consultant_response_type.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/border_painter.dart';

// ignore: must_be_immutable
class ConsultantAnswerScreen extends StatefulWidget {
  const ConsultantAnswerScreen({super.key});

  @override
  State<ConsultantAnswerScreen> createState() => _ConsultantAnswerScreenState();
}

class _ConsultantAnswerScreenState extends State<ConsultantAnswerScreen> {
  ValueNotifier<ConsultantResponseType> type =
      ValueNotifier(ConsultantResponseType.none);

  @override
  void dispose() {
    type.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    const textstyle = TextStyle(
      fontSize: 16.0,
      color: BrandColors.black,
      fontWeight: FontWeight.normal,
    );

    return Scaffold(
      backgroundColor: BrandColors.snowWhite,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 1.5,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              '${appLocalizations.send} ${appLocalizations.normalConsultation}',
            ),
            Text(
              '3 - ${appLocalizations.consultantAnswer}',
              style: const TextStyle(color: BrandColors.gray),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 27.width),
            child: CustomPaint(
              painter: BorderPainter(
                stroke: 3.0,
                padding: 8.width,
                progress: 1.0,
              ),
              child: Transform.translate(
                offset: const Offset(0, 2),
                child: const Center(
                  child: Text.rich(
                    style: TextStyle(color: BrandColors.gray),
                    TextSpan(children: [
                      TextSpan(
                        text: '3',
                        style: TextStyle(color: BrandColors.orange),
                      ),
                      TextSpan(text: '/3'),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 16.width,
          horizontal: 34.width,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appLocalizations.answerPreference, style: textstyle),
            10.emptyHeight,
            ValueListenableBuilder(
              valueListenable: type,
              builder: (context, value, child) => Column(
                children: [
                  _buildItem(
                    appLocalizations,
                    setState,
                    icon: Icons.phone_in_talk_rounded,
                    title: appLocalizations.connectNowTitle,
                    subtitle: appLocalizations.connectNowSubtitle,
                    index: 7,
                  ),
                  14.emptyHeight,
                  _buildItem(
                    appLocalizations,
                    setState,
                    icon: Icons.mic,
                    title: appLocalizations.voiceTitle,
                    subtitle: appLocalizations.voiceSubtitle,
                    index: 2,
                  ),
                  14.emptyHeight,
                  _buildItem(
                    appLocalizations,
                    setState,
                    icon: Icons.videocam,
                    title: appLocalizations.videoTitle,
                    subtitle: appLocalizations.videoSubtitle,
                    index: 3,
                  ),
                ],
              ),
            ),
            Divider(height: 66.height),
            Text(appLocalizations.consultationPriceTitle, style: textstyle),
            4.emptyHeight,
            Text(
              appLocalizations.consultationPriceSubitle,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
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
                  child: ValueListenableBuilder(
                    valueListenable: type,
                    builder: (context, value, child) => BlocConsumer<
                        FastConsultationCubit, FastConsultationState>(
                      listener: (context, state) {
                        if (state is FastConsultationSent) {
                          Navigator.pushNamed(
                            context,
                            Routes.consultationSent,
                            arguments: context.read<FastConsultationCubit>(),
                          );
                        } else if (state is FastConsultationError) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton.icon(
                          onPressed: value != ConsultantResponseType.none
                              ? () => context
                                  .read<FastConsultationCubit>()
                                  .send(context, type: type.value)
                              : null,
                          icon: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: Icon(Icons.send_rounded),
                          ),
                          label: Builder(builder: (context) {
                            if (state is FastConsultationSending) {
                              return const CircularProgressIndicator(
                                  color: Colors.white);
                            }
                            return Text(appLocalizations.send);
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildItem(
    AppLocalizations appLocalizations,
    StateSetter setState, {
    required IconData icon,
    required String title,
    required String subtitle,
    required int index,
  }) =>
      ListTile(
        dense: true,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            color: BrandColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 10.0,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: CircleAvatar(
          backgroundColor: type.value == index.consultantResponseTypeFromMap()
              ? BrandColors.green
              : Colors.grey.shade400,
          child: const Icon(Icons.done, color: Colors.white),
        ),
        onTap: () => type.value = index.consultantResponseTypeFromMap(),
      );
}
