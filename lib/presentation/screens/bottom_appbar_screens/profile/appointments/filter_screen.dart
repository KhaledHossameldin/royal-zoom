import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../cubits/appointments/appointments_cubit.dart';
import '../../../../../cubits/cubit/appointments_filter_cubit.dart';
import '../../../../../data/enums/appointment_status.dart';
import '../../../../../localization/app_localizations.dart';
import '../../../../../utilities/extensions.dart';

class AppointmentsFilterScreen extends StatefulWidget {
  const AppointmentsFilterScreen({super.key});

  @override
  State<AppointmentsFilterScreen> createState() =>
      _AppointmentsFilterScreenState();
}

class _AppointmentsFilterScreenState extends State<AppointmentsFilterScreen> {
  final _dateRangeController = TextEditingController();

  @override
  void initState() {
    context.read<AppointmentsFilterCubit>().fetch(context);
    final cubit = context.read<AppointmentsCubit>();
    if (cubit.dateRange != null) {
      _dateRangeController.text = cubit.dateRange!.text;
    }
    super.initState();
  }

  @override
  void dispose() {
    _dateRangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final cubit = context.read<AppointmentsCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.filter),
        actions: [
          TextButton(
            onPressed: () {
              final cubit = context.read<AppointmentsCubit>();
              cubit.clearFilter();
              cubit.fetch(context);
              Navigator.pop(context);
            },
            child: Text(appLocalizations.reset),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 34.width,
          vertical: 34.height,
        ),
        child: Column(
          children: [
            _buildDateRangePicker(cubit),
            16.emptyHeight,
            _buildAppointmentStatusDropDown(cubit),
            16.emptyHeight,
            _buildConsultantsDropDown(cubit),
            16.emptyHeight,
            _buildConsultationsDropDown(cubit),
            16.emptyHeight,
            ElevatedButton(
              onPressed: () {
                cubit.fetch(context);
                Navigator.pop(context);
              },
              child: Text(appLocalizations.confirm),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildConsultationsDropDown(AppointmentsCubit cubit) {
    final appLocalizations = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.consultation,
          style: const TextStyle(
            color: BrandColors.darkBlackGreen,
            fontWeight: FontWeight.normal,
          ),
        ),
        8.emptyHeight,
        BlocBuilder<AppointmentsFilterCubit, AppointmentsFilterState>(
          builder: (context, state) {
            if (state is AppointmentsFilterLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AppointmentsFilterError) {
              return Center(child: Text(state.message));
            }
            final consultations =
                (state as AppointmentsFilterLoaded).consultations;
            return Material(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(12.0),
              child: ButtonTheme(
                alignedDropdown: true,
                child: StatefulBuilder(
                  builder: (context, setState) => DropdownButton<int>(
                    value: cubit.consultationId,
                    isExpanded: true,
                    menuMaxHeight: 300.height,
                    underline: const Material(),
                    borderRadius: BorderRadius.circular(12.0),
                    icon: const Icon(Icons.expand_more_rounded),
                    items: consultations
                        .map((c) => DropdownMenuItem<int>(
                            value: c.id,
                            child: Text(c.consultant?.previewName ??
                                appLocalizations.none)))
                        .toList(),
                    onChanged: (value) =>
                        cubit.applyFilter(consultationId: value),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Column _buildConsultantsDropDown(AppointmentsCubit cubit) {
    final appLocalizations = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.consultant,
          style: const TextStyle(
            color: BrandColors.darkBlackGreen,
            fontWeight: FontWeight.normal,
          ),
        ),
        8.emptyHeight,
        BlocBuilder<AppointmentsFilterCubit, AppointmentsFilterState>(
          builder: (context, state) {
            if (state is AppointmentsFilterLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AppointmentsFilterError) {
              return Center(child: Text(state.message));
            }
            final consultants = (state as AppointmentsFilterLoaded).consultants;
            return Material(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(12.0),
              child: ButtonTheme(
                alignedDropdown: true,
                child: StatefulBuilder(
                  builder: (context, setState) => DropdownButton<int>(
                    value: cubit.consultantId,
                    isExpanded: true,
                    menuMaxHeight: 300.height,
                    underline: const Material(),
                    borderRadius: BorderRadius.circular(12.0),
                    icon: const Icon(Icons.expand_more_rounded),
                    items: consultants
                        .map((c) => DropdownMenuItem<int>(
                            value: c.id,
                            child:
                                Text(c.previewName ?? appLocalizations.none)))
                        .toList(),
                    onChanged: (value) =>
                        cubit.applyFilter(consultantId: value),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildAppointmentStatusDropDown(AppointmentsCubit cubit) {
    final appLocalizations = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.appointmentStatus,
          style: const TextStyle(
            color: BrandColors.darkBlackGreen,
            fontWeight: FontWeight.normal,
          ),
        ),
        8.emptyHeight,
        Material(
          color: BrandColors.snowWhite,
          borderRadius: BorderRadius.circular(12.0),
          child: ButtonTheme(
            alignedDropdown: true,
            child: StatefulBuilder(
              builder: (context, setState) => DropdownButton<AppointmentStatus>(
                value: cubit.status,
                isExpanded: true,
                menuMaxHeight: 300.height,
                underline: const Material(),
                borderRadius: BorderRadius.circular(12.0),
                icon: const Icon(Icons.expand_more_rounded),
                items: [
                  DropdownMenuItem<AppointmentStatus>(
                    value: AppointmentStatus.upcoming,
                    child: Text(appLocalizations.appointmentUpcoming),
                  ),
                  DropdownMenuItem<AppointmentStatus>(
                    value: AppointmentStatus.ended,
                    child: Text(appLocalizations.appointmentEnded),
                  ),
                ],
                onChanged: (value) => setState(
                  () => cubit.applyFilter(status: value),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildDateRangePicker(AppointmentsCubit cubit) {
    final appLocalizations = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.date,
          style: const TextStyle(
            color: BrandColors.darkBlackGreen,
            fontWeight: FontWeight.normal,
          ),
        ),
        8.emptyHeight,
        TextField(
          controller: _dateRangeController,
          readOnly: true,
          decoration: const InputDecoration(
            isDense: true,
            prefixIcon: Icon(Icons.calendar_month_rounded),
            prefixIconColor: BrandColors.orange,
            suffixIcon: Icon(Icons.expand_more_rounded, size: 25.0),
            suffixIconColor: Colors.grey,
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onTap: () async {
            final range = await showDateRangePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().copyWith(
                year: DateTime.now().year + 100,
              ),
            );
            if (context.mounted && range != null) {
              setState(() {
                cubit.applyFilter(dateRange: range);
                _dateRangeController.text = range.text;
              });
            }
          },
        ),
      ],
    );
  }
}
