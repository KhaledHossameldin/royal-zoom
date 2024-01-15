import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../constants/brand_colors.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/change_appointment_date/change_appointment_date_cubit.dart';
import '../../../../cubits/consultants_available_times/consultants_available_times_cubit.dart';
import '../../../../data/models/consultations/details.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/reload_widget.dart';

class EditTimeChooseScreen extends StatefulWidget {
  const EditTimeChooseScreen({super.key, required this.consultation});

  final ConsultationDetails consultation;

  @override
  State<EditTimeChooseScreen> createState() => _EditTimeChooseScreenState();
}

class _EditTimeChooseScreenState extends State<EditTimeChooseScreen> {
  final _controller = ScrollController();
  final ValueNotifier<bool> _canSend = ValueNotifier(false);

  int _index = -1;
  bool _addToCalendar = false;
  List<DateTime> _days = [];
  TimeOfDay? _time;
  ValueNotifier<DateTime> current = ValueNotifier(DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 1,
  ));

  @override
  void initState() {
    _days = List.generate(
      _getDays(),
      (index) => DateTime(current.value.year, current.value.month, index + 1),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.jumpTo((DateTime.now().day - 1) * 72.width);
      context
          .read<ConsultantsAvailableTimesCubit>()
          .fetch(context, id: widget.consultation.consultant?.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    current.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.editConsultationTime),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.width),
              child: Text(
                appLocalizations.availableTimes,
                style: const TextStyle(
                  color: BrandColors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            _buildDaysChooseWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvailableTimes(),
                  _buildChooseDateTimeButton(),
                  const Divider(),
                  StatefulBuilder(
                    builder: (context, setState) => CheckboxListTile(
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(appLocalizations.addToCalendar),
                      value: _addToCalendar,
                      onChanged: (value) =>
                          setState(() => _addToCalendar = value!),
                    ),
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
                  child: Text(
                    appLocalizations.cancel,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              10.emptyWidth,
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: ValueListenableBuilder(
                    valueListenable: _canSend,
                    builder: (context, value, child) => BlocConsumer<
                        ChangeAppointmentDateCubit, ChangeAppointmentDateState>(
                      listener: (context, state) {
                        if (state is ChangeAppointmentDateError) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(state.message),
                            ),
                          );
                        } else if (state is ChangeAppointmentDateLoaded) {
                          Navigator.pushNamed(
                            context,
                            Routes.editTimeChooseSuccess,
                            arguments: state.id,
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton.icon(
                          onPressed: value
                              ? () => context
                                  .read<ChangeAppointmentDateCubit>()
                                  .change(
                                    context,
                                    id: 0,
                                    date:
                                        '${current.value.year}-${current.value.month.twoDigits}-${current.value.day.twoDigits} ${_time!.hour.twoDigits}:${_time!.minute.twoDigits}:00',
                                  )
                              : null,
                          icon: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: Icon(Icons.send),
                          ),
                          label: state is ChangeAppointmentDateLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  appLocalizations.send,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
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

  OutlinedButton _buildChooseDateTimeButton() {
    final appLocalizations = AppLocalizations.of(context);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(214.width, 41.height),
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontFamily: Fonts.main,
        ),
      ),
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (context.mounted && date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (time != null) {
            current.value = DateTime(
              date.year,
              date.month,
              date.day,
            );
            _time = time;
            _getDays();
            await _controller.animateTo(
              (current.value.day - 1) * 72.width,
              duration: kTabScrollDuration,
              curve: Curves.easeIn,
            );
            setState(() {});
          }
        }
      },
      child: Text(appLocalizations.orderUnlistedAppointment),
    );
  }

  Padding _buildAvailableTimes() {
    final appLocalizations = AppLocalizations.of(context);
    final materialLocalizations = MaterialLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.height),
      child: BlocBuilder<ConsultantsAvailableTimesCubit,
          ConsultantsAvailableTimesState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ConsultantsAvailableTimesLoading:
              return const Center(child: CircularProgressIndicator());

            case ConsultantsAvailableTimesEmpty:
              return ReloadWidget(
                widthFactor: 0.7,
                title: appLocalizations.availableTimesEmpty,
                buttonText:
                    appLocalizations.getReload(appLocalizations.availableTimes),
                onPressed: () => context
                    .read<ConsultantsAvailableTimesCubit>()
                    .fetch(context, id: widget.consultation.consultant?.id),
              );

            case ConsultantsAvailableTimesLoaded:
              return ValueListenableBuilder(
                valueListenable: current,
                builder: (context, value, child) {
                  final times =
                      (state as ConsultantsAvailableTimesLoaded).times;

                  final today = times[
                      DateFormat.E('en').format(current.value).toLowerCase()];
                  if (today == null) {
                    return Center(
                      child: Text(appLocalizations.availableTimesEmpty),
                    );
                  }
                  return StatefulBuilder(
                    builder: (context, setState) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.width),
                      child: Wrap(
                        spacing: 10.width,
                        children: today
                            .map((e) => ChoiceChip(
                                  selected: today.indexOf(e) == _index,
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: BrandColors.gray,
                                  ),
                                  label: SizedBox(
                                    width: 60.width,
                                    child: Text(
                                      materialLocalizations
                                          .formatTimeOfDay(e.time),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  onSelected: (value) {
                                    _canSend.value = true;
                                    setState(() {
                                      _index = today.indexOf(e);
                                      _time = today[_index].time;
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                    ),
                  );
                },
              );

            case ConsultantsAvailableTimesError:
              final message = (state as ConsultantsAvailableTimesError).message;
              return ReloadWidget(
                widthFactor: 0.7,
                title: message,
                buttonText:
                    appLocalizations.getReload(appLocalizations.availableTimes),
                onPressed: () => context
                    .read<ConsultantsAvailableTimesCubit>()
                    .fetch(context, id: widget.consultation.consultant?.id),
              );

            default:
              return const Material();
          }
        },
      ),
    );
  }

  StatefulBuilder _buildDaysChooseWidget() {
    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        height: 160.height,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 70.height,
              color: BrandColors.indigoBlue,
              margin: EdgeInsets.only(top: 50.height),
            ),
            Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 90.width,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.width,
                    vertical: 12.height,
                  ),
                  margin: EdgeInsetsDirectional.only(start: 27.width),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: kElevationToShadow[1],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _canSend.value = false;
                          _index = -1;
                          current.value = current.value
                              .copyWith(month: current.value.month + 1);
                          if (current.value.month == DateTime.now().month &&
                              current.value.year == DateTime.now().year &&
                              current.value.isBefore(DateTime.now())) {
                            current.value = DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day + 1,
                            );
                          }
                          _days = List.generate(
                            _getDays(),
                            (index) => DateTime(current.value.year,
                                current.value.month, index + 1),
                          );
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.keyboard_double_arrow_up_rounded,
                        ),
                      ),
                      Text(
                        DateFormat.MMM().format(current.value),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: BrandColors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        DateFormat.y().format(current.value),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: BrandColors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (current.value.year == DateTime.now().year &&
                              current.value.month == DateTime.now().month) {
                            return;
                          }
                          _canSend.value = false;
                          _index = -1;
                          current.value = current.value
                              .copyWith(month: current.value.month - 1);
                          if (current.value.month == DateTime.now().month &&
                              current.value.year == DateTime.now().year &&
                              current.value.isBefore(DateTime.now())) {
                            current.value = DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day + 1,
                            );
                          }
                          _days = List.generate(
                            _getDays(),
                            (index) => DateTime(current.value.year,
                                current.value.month, index + 1),
                          );
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.keyboard_double_arrow_down_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: _controller,
                    itemCount: _days.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsetsDirectional.only(
                        end: 27.width, start: 16.width),
                    separatorBuilder: (context, index) => 16.emptyWidth,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (_days[index].isBefore(DateTime.now())) {
                            return;
                          }
                          setState(() => current.value = _days[index]);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical:
                                _days[index] == current.value ? 15.height : 0,
                          ),
                          width: 60.width,
                          height: 120.height,
                          padding: EdgeInsets.only(
                              bottom: _days[index] == current.value
                                  ? 0
                                  : 20.height),
                          decoration: BoxDecoration(
                            color: _days[index] == current.value
                                ? Colors.white
                                : null,
                            boxShadow: _days[index] == current.value
                                ? kElevationToShadow[1]
                                : null,
                            borderRadius: BorderRadius.circular(29.0),
                          ),
                          child: Column(
                            mainAxisAlignment: _days[index] == current.value
                                ? MainAxisAlignment.spaceEvenly
                                : MainAxisAlignment.end,
                            children: [
                              Text(
                                DateFormat.E().format(_days[index]),
                                style: TextStyle(
                                    color: _days[index] == current.value
                                        ? BrandColors.orange
                                        : Colors.white),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 40.width,
                                height: 40.height,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(29),
                                  boxShadow: kElevationToShadow[
                                      _days[index] == current.value ? 0 : 1],
                                ),
                                child: Text(
                                  DateFormat.d().format(_days[index]),
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    color: BrandColors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (_days[index] == current.value)
                                const Icon(
                                  Icons.task_alt,
                                  color: BrandColors.orange,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _getDays() {
    if (current.value.month == 1 ||
        current.value.month == 3 ||
        current.value.month == 5 ||
        current.value.month == 7 ||
        current.value.month == 8 ||
        current.value.month == 10 ||
        current.value.month == 12) {
      return 31;
    } else if (current.value.month != 2) {
      return 30;
    } else {
      return current.value.year % 4 == 0 ? 29 : 28;
    }
  }
}
