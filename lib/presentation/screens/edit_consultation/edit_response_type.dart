import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/brand_colors.dart';
import '../../../cubits/update_consultation/update_consultation_cubit.dart';
import '../../../data/enums/consultant_response_type.dart';
import '../../../data/models/consultations/details.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

class EditConsultantResponseType extends StatefulWidget {
  const EditConsultantResponseType({super.key});

  @override
  State<EditConsultantResponseType> createState() =>
      _EditConsultantResponseTypeState();
}

class _EditConsultantResponseTypeState
    extends State<EditConsultantResponseType> {
  ValueNotifier<ConsultantResponseType> type =
      ValueNotifier(ConsultantResponseType.none);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final consultation =
          ModalRoute.of(context)!.settings.arguments as ConsultationDetails;
      type.value = consultation.responseType;
    });
    super.initState();
  }

  @override
  void dispose() {
    type.dispose();
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
        title: Text(appLocalizations.editResponseType),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 25.height,
          horizontal: 20.width,
        ),
        child: ValueListenableBuilder(
          valueListenable: type,
          builder: (context, value, child) => Column(
            children: [
              _Item(
                type: type,
                newType: ConsultantResponseType.appCall,
                icon: Icons.phone_in_talk_rounded,
              ),
              10.emptyHeight,
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
              10.emptyHeight,
              _Item(
                type: type,
                newType: ConsultantResponseType.onlineMeeting,
                icon: Icons.question_answer_rounded,
              ),
              10.emptyHeight,
              _Item(
                type: type,
                newType: ConsultantResponseType.frequentConsultation,
                icon: Icons.description_rounded,
              ),
              10.emptyHeight,
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
                  child: BlocConsumer<UpdateConsultationCubit,
                      UpdateConsultationState>(
                    listener: (context, state) {
                      if (state is UpdateConsultationError) {
                        state.message.showSnackbar(
                          context,
                          color: BrandColors.orange,
                        );
                      }
                      if (state is UpdateConsultationLoaded) {
                        'success'.showSnackbar(context);
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: () =>
                            context.read<UpdateConsultationCubit>().update(
                                  context,
                                  id: consultation.id,
                                  responseType: type.value,
                                ),
                        icon: const Directionality(
                          textDirection: TextDirection.rtl,
                          child: Icon(Icons.send_rounded),
                        ),
                        label: Text(appLocalizations.send),
                      );
                    },
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
