import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/customized_consultation/customized_consultation_cubit.dart';
import '../../../../cubits/majors/majors_cubit.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/border_painter.dart';
import '../../../widgets/reload_widget.dart';
import '../../../../data/models/major.dart';

class ChooseCustomizedMajorScreen extends StatefulWidget {
  const ChooseCustomizedMajorScreen({super.key});

  @override
  State<ChooseCustomizedMajorScreen> createState() =>
      _ChooseCustomizedMajorScreenState();
}

class _ChooseCustomizedMajorScreenState
    extends State<ChooseCustomizedMajorScreen> {
  int? _subMajorId;

  bool _sendToAll = false;
  bool _requestAssistence = false;

  final _showBottom = ValueNotifier<bool>(false);
  final _mainMajorId = ValueNotifier<int?>(null);

  @override
  void initState() {
    context.read<MajorsCubit>().fetch(context);
    super.initState();
  }

  @override
  void dispose() {
    _showBottom.dispose();
    _mainMajorId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 1.5,
        centerTitle: true,
        title: Column(
          children: [
            Text(appLocalizations.customizedConsultation),
            Text(
              '1 - ${appLocalizations.chooseMajor}',
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
                progress: 1 / 6,
              ),
              child: Transform.translate(
                offset: const Offset(0, 2),
                child: const Center(
                  child: Text.rich(
                    style: TextStyle(color: BrandColors.gray),
                    TextSpan(children: [
                      TextSpan(
                        text: '1',
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
      body: BlocConsumer<MajorsCubit, MajorsState>(
        listener: (context, state) {
          if (state is MajorsLoaded) {
            _showBottom.value = true;
            return;
          }
          _showBottom.value = false;
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case MajorsLoading:
              return const Center(child: CircularProgressIndicator());

            case MajorsLoaded:
              final majors = (state as MajorsLoaded).majors;
              const textStyle = TextStyle(
                fontSize: 16.0,
                color: BrandColors.darkGray,
                fontWeight: FontWeight.normal,
              );
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: 14.height,
                  horizontal: 27.width,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMainMajor(textStyle, majors),
                    20.emptyHeight,
                    _buildSubMajor(textStyle, majors),
                    20.emptyHeight,
                    _buildSendToAll(),
                    20.emptyHeight,
                    _buildRequestAssistance(),
                    Divider(height: 24.height),
                    Text(
                      appLocalizations.sendConsultationDuration,
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: BrandColors.darkGray,
                      ),
                    ),
                    12.emptyHeight,
                    Text(
                      appLocalizations.chooseConsultantSubtitle,
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal,
                        color: BrandColors.darkGray,
                      ),
                    ),
                  ],
                ),
              );

            case MajorsError:
              return ReloadWidget(
                title: (state as MajorsError).message,
                buttonText: appLocalizations.getReload(''),
                onPressed: () => context.read<MajorsCubit>().fetch(context),
              );

            default:
              return const Material();
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar,
    );
  }

  StatefulBuilder _buildRequestAssistance() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => CheckboxListTile(
        value: _requestAssistence,
        title: Text(
          appLocalizations.requestAssistance,
          style: const TextStyle(fontSize: 13.0),
        ),
        subtitle: Text(
          appLocalizations.requestAssistanceFees,
          style: const TextStyle(fontSize: 10.0),
        ),
        onChanged: (value) => setState(
          () => _requestAssistence = value!,
        ),
      ),
    );
  }

  StatefulBuilder _buildSendToAll() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => CheckboxListTile(
        value: _sendToAll,
        title: Text(
          appLocalizations.sendAllConsultants,
          style: const TextStyle(fontSize: 13.0),
        ),
        subtitle: Text(
          appLocalizations.consultantAppropriateResponse,
          style: const TextStyle(fontSize: 10.0),
        ),
        onChanged: (value) => setState(() => _sendToAll = value!),
      ),
    );
  }

  StatefulBuilder _buildSubMajor(TextStyle textStyle, List<Major> majors) {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.subMajor, style: textStyle),
          8.emptyHeight,
          Material(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(12.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<int>(
                value: _subMajorId,
                isExpanded: true,
                menuMaxHeight: 300.height,
                hint: Text(appLocalizations.choose),
                underline: const Material(),
                borderRadius: BorderRadius.circular(12.0),
                icon: const Icon(Icons.expand_more_rounded),
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: Fonts.main,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.darkBlue,
                ),
                items: majors
                    .map((item) => DropdownMenuItem<int>(
                        value: item.id, child: Text(item.name)))
                    .toList(),
                onChanged: (value) => setState(() => _subMajorId = value),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ValueListenableBuilder _buildMainMajor(
      TextStyle textStyle, List<Major> majors) {
    final appLocalizations = AppLocalizations.of(context);

    return ValueListenableBuilder(
      valueListenable: _mainMajorId,
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.mainMajor, style: textStyle),
          8.emptyHeight,
          Material(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(12.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<int>(
                value: value,
                isExpanded: true,
                menuMaxHeight: 300.height,
                hint: Text(appLocalizations.choose),
                underline: const Material(),
                borderRadius: BorderRadius.circular(12.0),
                icon: const Icon(Icons.expand_more_rounded),
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: Fonts.main,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.darkBlue,
                ),
                items: majors
                    .map((item) => DropdownMenuItem<int>(
                        value: item.id, child: Text(item.name)))
                    .toList(),
                onChanged: (value) => _mainMajorId.value = value!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ValueListenableBuilder<bool> get _buildBottomNavigationBar {
    final appLocalizations = AppLocalizations.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: _showBottom,
      builder: (context, value, child) {
        if (!value) {
          return const Material();
        }
        return ColoredBox(
          color: BrandColors.snowWhite,
          child: BottomAppBar(
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
                      child: Text(appLocalizations.cancel),
                    ),
                  ),
                  10.emptyWidth,
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: ValueListenableBuilder<int?>(
                        valueListenable: _mainMajorId,
                        builder: (context, value, child) => ElevatedButton.icon(
                          onPressed: value == null
                              ? null
                              : () {
                                  context
                                      .read<CustomizedConsultationCubit>()
                                      .chooseMajor(value, _requestAssistence);
                                  Navigator.pushNamed(
                                    context,
                                    Routes.chooseCustomizedConsultant,
                                    arguments: {
                                      'mainMajorId': value,
                                      'subMajorId': _subMajorId,
                                      'cubit': context
                                          .read<CustomizedConsultationCubit>(),
                                    },
                                  );
                                },
                          icon: const Icon(
                            Icons.keyboard_double_arrow_left_outlined,
                          ),
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
      },
    );
  }
}
