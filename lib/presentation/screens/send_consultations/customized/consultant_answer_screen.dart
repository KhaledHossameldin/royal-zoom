import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/customized_consultation/customized_consultation_cubit.dart';
import '../../../../data/enums/consultant_response_type.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/border_painter.dart';

class CustomizedConsultantAnswerScreen extends StatefulWidget {
  const CustomizedConsultantAnswerScreen({super.key});

  @override
  State<CustomizedConsultantAnswerScreen> createState() =>
      _CustomizedConsultantAnswerScreenState();
}

class _CustomizedConsultantAnswerScreenState
    extends State<CustomizedConsultantAnswerScreen> {
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

    return Scaffold(
      backgroundColor: BrandColors.snowWhite,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 1.5,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              appLocalizations.customizedConsultation,
            ),
            Text(
              '4 - ${appLocalizations.consultantAnswer}',
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
                progress: 4 / 6,
              ),
              child: Transform.translate(
                offset: const Offset(0, 2),
                child: const Center(
                  child: Text.rich(
                    style: TextStyle(color: BrandColors.gray),
                    TextSpan(children: [
                      TextSpan(
                        text: '4',
                        style: TextStyle(color: BrandColors.orange),
                      ),
                      TextSpan(text: '/6'),
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
          vertical: 25.height,
          horizontal: 20.width,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.answerPreference,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            10.emptyHeight,
            ValueListenableBuilder(
              valueListenable: type,
              builder: (context, value, child) => Column(
                children: [
                  // _Item(
                  //   type: type,
                  //   newType: ConsultantResponseType.appCall,
                  //   icon: Icons.phone_in_talk_rounded,
                  // ),
                  // 10.emptyHeight,
                  _Item(
                    type: type,
                    newType: ConsultantResponseType.text,
                    icon: Icons.border_color_rounded,
                  ),
                  10.emptyHeight,
                  _Item(
                    type: type,
                    newType: ConsultantResponseType.voice,
                    icon: Icons.mic_rounded,
                  ),
                  10.emptyHeight,
                  _Item(
                    type: type,
                    newType: ConsultantResponseType.video,
                    icon: Icons.videocam_rounded,
                  ),
                  // 10.emptyHeight,
                  // _Item(
                  //   type: type,
                  //   newType: ConsultantResponseType.onlineMeeting,
                  //   icon: Icons.question_answer_rounded,
                  // ),
                  10.emptyHeight,
                  // _Item(
                  //   type: type,
                  //   newType: ConsultantResponseType.frequentConsultation,
                  //   icon: Icons.description_rounded,
                  // ),
                  // 10.emptyHeight,
                  _Item(
                    type: type,
                    newType: ConsultantResponseType.fieldConsultation,
                    icon: Icons.place_rounded,
                  ),
                  10.emptyHeight,
                  _Item(
                    type: type,
                    newType: ConsultantResponseType.appropriateForConsultant,
                    icon: Icons.person_rounded,
                  ),
                ],
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
                    builder: (context, value, child) => ElevatedButton.icon(
                      onPressed: value == ConsultantResponseType.none
                          ? null
                          : () {
                              final cubit =
                                  context.read<CustomizedConsultationCubit>();
                              cubit.setResponseType(type: value);
                              Navigator.pushNamed(
                                context,
                                cubit.isOneConsultantChosen
                                    ? Routes.customizedChooseTime
                                    : Routes.customizedChoosePrice,
                                arguments: cubit,
                              );
                            },
                      icon:
                          const Icon(Icons.keyboard_double_arrow_left_outlined),
                      label: Text(appLocalizations.next),
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
}

class _Item extends StatelessWidget {
  const _Item({required this.type, required this.newType, required this.icon});

  final ValueNotifier<ConsultantResponseType> type;
  final ConsultantResponseType newType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: type.value == newType ? BrandColors.green : BrandColors.gray,
        ),
      ),
      leading: Icon(icon, color: BrandColors.orange),
      title: Text(
        appLocalizations.getConsultantResponseType(newType),
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: BrandColors.darkGreen,
        ),
      ),
      subtitle: Text(
        appLocalizations.getConsultationResponseTypeSubtitle(newType),
        style: const TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: CircleAvatar(
        backgroundColor:
            type.value == newType ? BrandColors.green : Colors.grey.shade400,
        child: const Icon(Icons.done, color: Colors.white),
      ),
      onTap: () => type.value = newType,
    );
  }
}
