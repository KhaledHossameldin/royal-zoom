import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/numbers.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/consultation_recording/consultation_recording_cubit.dart';
import '../../../../cubits/customized_consultation/customized_consultation_cubit.dart';
import '../../../../data/enums/consultation_content_type.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/border_painter.dart';

class CustomizedConsultationContentScreen extends StatefulWidget {
  const CustomizedConsultationContentScreen({super.key});

  @override
  State<CustomizedConsultationContentScreen> createState() =>
      _CustomizedConsultationContentScreenState();
}

class _CustomizedConsultationContentScreenState
    extends State<CustomizedConsultationContentScreen>
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
        toolbarHeight: kToolbarHeight * 1.5,
        centerTitle: true,
        title: Column(
          children: [
            Text(appLocalizations.customizedConsultation),
            Text(
              '3 - ${appLocalizations.consultationContent}',
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
                progress: 3 / 6,
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
                  _contentController.clear();
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
            Text(appLocalizations.attachedFiles, style: textstyle),
            8.emptyHeight,
            _AttachmentSection(files: _files),
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
                    builder: (context, value, child) => ElevatedButton.icon(
                      onPressed: value
                          ? () {
                              final cubit =
                                  context.read<CustomizedConsultationCubit>();
                              cubit.setContent(
                                type: _type.value,
                                files: _files.value,
                                content:
                                    _type.value == ConsultationContentType.text
                                        ? _contentController.text
                                        : context
                                            .read<ConsultationRecordingCubit>()
                                            .recordPath,
                              );
                              Navigator.pushNamed(
                                context,
                                Routes.customizedConsultantAnswer,
                                arguments: cubit,
                              );
                            }
                          : null,
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

class _AttachmentSection extends StatelessWidget {
  const _AttachmentSection({required ValueNotifier<List<PlatformFile>> files})
      : _files = files;

  final ValueNotifier<List<PlatformFile>> _files;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return ValueListenableBuilder<List<PlatformFile>>(
      valueListenable: _files,
      builder: (context, value, child) {
        return Column(
          children: [
            Builder(
              builder: (context) {
                if (value.isEmpty) {
                  return const Material();
                }
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 3.5,
                  mainAxisSpacing: 16.height,
                  crossAxisSpacing: 24.width,
                  padding: EdgeInsets.only(top: 12.height, bottom: 24.height),
                  children: value
                      .map((e) => ListTile(
                            horizontalTitleGap: 0.0,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.width,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: BrandColors.orange.withOpacity(0.4),
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            dense: true,
                            title: Text(
                              e.name,
                              style: const TextStyle(
                                fontSize: 9.0,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            trailing: Icon(Icons.close, size: 18.width),
                            onTap: () => _files.value = List.from(_files.value)
                              ..remove(e),
                          ))
                      .toList(),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: BrandColors.snowWhite,
                foregroundColor: BrandColors.gray,
              ),
              onPressed: value.length < 5
                  ? () async {
                      final result = await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                      );
                      if (result == null) {
                        return;
                      }
                      final files = List<PlatformFile>.from(_files.value)
                        ..addAll(result.files);
                      bool isSizeError = false;
                      bool isLimitError = false;
                      int size = files.length;
                      files.removeWhere(
                          (element) => element.size > Numbers.maximumFileSize);
                      isSizeError = size != files.length;
                      if (files.length > 5) {
                        files.removeRange(5, files.length);
                        isLimitError = true;
                      }
                      if (context.mounted && (isLimitError || isSizeError)) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isLimitError)
                                  Text('- ${appLocalizations.filesLimitError}'),
                                if (isSizeError)
                                  Text('- ${appLocalizations.filesSizeError}'),
                              ],
                            ),
                          ),
                        );
                      }
                      _files.value = files;
                    }
                  : null,
              child: const Icon(Icons.add),
            ),
            Builder(
              builder: (context) {
                if (value.isNotEmpty) {
                  return const Material();
                }
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.emptyHeight,
                      Text(
                        appLocalizations.filesLimitTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      2.emptyHeight,
                      Text(
                        appLocalizations.filesLimitSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey.withOpacity(0.7),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
