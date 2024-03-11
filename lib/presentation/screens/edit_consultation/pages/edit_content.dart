import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';

import '../../../../core/di/di_manager.dart';
import '../../../../core/states/base_init_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../cubits/consultation_recording/consultation_recording_cubit.dart';

import '../../../../data/enums/consultation_content_type.dart';
import '../../../../data/models/consultations/details.dart';
import '../../../../localization/app_localizations.dart';

import '../../../../utilities/extensions.dart';
import '../cubit/edit_consultation_cubit.dart';
import '../cubit/edit_consultation_state.dart';

class EditConsultationContent extends StatefulWidget {
  const EditConsultationContent({super.key, required this.consultation});

  final ConsultationDetails consultation;

  @override
  State<EditConsultationContent> createState() =>
      _EditConsultationContentState();
}

class _EditConsultationContentState extends State<EditConsultationContent>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  final _contentController = TextEditingController();
  final _type = ValueNotifier<ConsultationContentType>(
    ConsultationContentType.text,
  );
  final _files = ValueNotifier<List<PlatformFile>>(<PlatformFile>[]);
  final _canGoNext = ValueNotifier<bool>(false);

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _contentController.text =
        widget.consultation.contentType == ConsultationContentType.text
            ? widget.consultation.content
            : '';
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _contentController.dispose();
    _files.dispose();
    _type.dispose();
    _canGoNext.dispose();
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
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              appLocalizations.editConsultation,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 18.height,
          horizontal: 34.width,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.chooseConsultationContent,
              style: textstyle,
            ),
            11.emptyHeight,
            Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: TabBar(
                controller: _controller,
                onTap: (value) {
                  context.read<ConsultationRecordingCubit>().cancel();
                  _canGoNext.value = false;
                  _type.value = (value + 1).consultationContentTypeFromMap();
                },
                tabs: [
                  Tab(text: appLocalizations.textType),
                  Tab(text: appLocalizations.voiceType),
                ],
              ),
            ),
            25.emptyHeight,
            Text(appLocalizations.consultation, style: textstyle),
            8.emptyHeight,
            ValueListenableBuilder(
              valueListenable: _type,
              builder: (context, value, child) => AnimatedCrossFade(
                alignment: Alignment.topCenter,
                firstChild: TextField(
                  controller: _contentController,
                  maxLines: 5,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: appLocalizations.enterConsultation,
                    hintStyle: const TextStyle(
                      fontSize: 15.0,
                      color: BrandColors.gray,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      _canGoNext.value = false;
                      return;
                    }
                    _canGoNext.value = true;
                  },
                ),
                secondChild: BlocBuilder<ConsultationRecordingCubit,
                    ConsultationRecordingState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final cubit =
                                  context.read<ConsultationRecordingCubit>();
                              if (state is ConsultationRecordingInitial) {
                                cubit.start(vsync: this);
                              } else if (state
                                  is ConsultationRecordingWorking) {
                                cubit.stop();
                                _canGoNext.value = true;
                              }
                            },
                            child: CircleAvatar(
                              radius: 130.width,
                              backgroundColor:
                                  state is ConsultationRecordingInitial
                                      ? BrandColors.orange.withOpacity(0.1)
                                      : Colors.white,
                              child: Card(
                                color: state is ConsultationRecordingInitial
                                    ? BrandColors.orange
                                    : Colors.white,
                                elevation: state is ConsultationRecordingInitial
                                    ? 0
                                    : null,
                                shadowColor: BrandColors.orange,
                                shape: const CircleBorder(),
                                child: SizedBox.square(
                                  dimension: 226.width,
                                  child: Builder(builder: (context) {
                                    switch (state.runtimeType) {
                                      case ConsultationRecordingInitial:
                                        return Icon(
                                          Icons.mic,
                                          size: 130.width,
                                          color: Colors.white,
                                        );

                                      case ConsultationRecordingWorking:
                                        state as ConsultationRecordingWorking;
                                        return ValueListenableBuilder<int>(
                                          valueListenable: state.seconds,
                                          builder: (context, value, child) =>
                                              Center(
                                            child: Text(
                                              value.seconds,
                                              style: const TextStyle(
                                                fontSize: 49.0,
                                                fontWeight: FontWeight.bold,
                                                color: BrandColors.black,
                                              ),
                                            ),
                                          ),
                                        );

                                      default:
                                        state as ConsultationRecordingEnded;
                                        return Center(
                                          child: Text(
                                            state.seconds.seconds,
                                            style: const TextStyle(
                                              fontSize: 49.0,
                                              fontWeight: FontWeight.bold,
                                              color: BrandColors.black,
                                            ),
                                          ),
                                        );
                                    }
                                  }),
                                ),
                              ),
                            ),
                          ),
                          if (state is ConsultationRecordingEnded)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton.small(
                                  heroTag: 'play-fab',
                                  onPressed: () => context
                                      .read<ConsultationRecordingCubit>()
                                      .play(),
                                  elevation: 0,
                                  highlightElevation: 0.0,
                                  child: const Icon(Icons.play_arrow),
                                ),
                                44.emptyWidth,
                                FloatingActionButton.small(
                                  heroTag: 'stop-fab',
                                  onPressed: () {
                                    context
                                        .read<ConsultationRecordingCubit>()
                                        .cancel();
                                    _canGoNext.value = false;
                                  },
                                  elevation: 0,
                                  highlightElevation: 0.0,
                                  backgroundColor: Colors.red,
                                  child: const Icon(Icons.close),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
                crossFadeState: value == ConsultationContentType.voice
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: kTabScrollDuration,
              ),
            ),
            24.emptyHeight,
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
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _canGoNext,
                    builder: (context, value, child) => BlocConsumer<
                        EditConsultationCubit, EditConsultationState>(
                      bloc: DIManager.findDep<EditConsultationCubit>(),
                      listener: (context, state) {
                        if (state.sendUpdatedConsultation is BaseSuccessState) {
                          state.sendUpdatedConsultation = BaseInitState();
                          Navigator.of(context).pop();
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton.icon(
                          onPressed: value
                              ? () {
                                  DIManager.findDep<EditConsultationCubit>()
                                      .updateConsultation(
                                    id: widget.consultation.id,
                                    contentType: _type.value,
                                    consultantResponseType:
                                        widget.consultation.responseType,
                                    content: _type.value ==
                                            ConsultationContentType.text
                                        ? _contentController.text
                                        : context
                                            .read<ConsultationRecordingCubit>()
                                            .recordPath!,
                                  );
                                }
                              : null,
                          icon: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: Icon(Icons.send_rounded),
                          ),
                          label:
                              state.sendUpdatedConsultation is BaseLoadingState
                                  ? const CircularProgressIndicator()
                                  : Text(appLocalizations.send),
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
}
