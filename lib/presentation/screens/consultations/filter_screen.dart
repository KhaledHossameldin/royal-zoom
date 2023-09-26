import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/brand_colors.dart';
import '../../../cubits/consultations/consultations_cubit.dart';
import '../../../data/enums/consultation_status.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

class ConsultationsFilterScreen extends StatefulWidget {
  const ConsultationsFilterScreen({super.key});

  @override
  State<ConsultationsFilterScreen> createState() =>
      _ConsultationsFilterScreenState();
}

class _ConsultationsFilterScreenState extends State<ConsultationsFilterScreen> {
  final textStyle = const TextStyle(
    fontSize: 16.0,
    color: BrandColors.darkBlackGreen,
    fontWeight: FontWeight.normal,
  );
  late final _dateController = TextEditingController(
      text: context.read<ConsultationsCubit>().dateRange?.text ??
          AppLocalizations.of(context).date);

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: () {
        context.read<ConsultationsCubit>().clearFilters();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(appLocalizations.filter),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ConsultationsCubit>().clearFilters();
                context.read<ConsultationsCubit>().fetch(context);
                Navigator.pop(context);
              },
              child: Text(appLocalizations.reset),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 10.height,
            horizontal: 34.width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appLocalizations.status, style: textStyle),
              8.emptyHeight,
              const _StatusDropDown(),
              10.emptyHeight,
              Text(appLocalizations.date, style: textStyle),
              8.emptyHeight,
              _DateRangeTextField(dateController: _dateController),
              30.emptyHeight,
              ElevatedButton(
                onPressed: () {
                  context.read<ConsultationsCubit>().fetch(context);
                  Navigator.pop(context);
                },
                child: Text(appLocalizations.confirm),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateRangeTextField extends StatelessWidget {
  const _DateRangeTextField({
    required TextEditingController dateController,
  }) : _dateController = dateController;

  final TextEditingController _dateController;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => TextField(
        readOnly: true,
        controller: _dateController,
        enableInteractiveSelection: false,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: const InputDecoration(
          isDense: true,
          prefixIcon: Icon(Icons.calendar_month_rounded),
          suffixIcon: Icon(Icons.expand_more_rounded, size: 25.0),
          suffixIconColor: Colors.grey,
        ),
        onTap: () async {
          final range = await showDateRangePicker(
            context: context,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (context.mounted && range != null) {
            context.read<ConsultationsCubit>().applyFilters(dateRange: range);
            setState(() {
              _dateController.text = range.text;
            });
          }
        },
      ),
    );
  }
}

class _StatusDropDown extends StatelessWidget {
  const _StatusDropDown();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final cubit = context.read<ConsultationsCubit>();

    return StatefulBuilder(
      builder: (context, setState) => Material(
        color: BrandColors.snowWhite,
        borderRadius: BorderRadius.circular(12.0),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<ConsultationStatus>(
            value: cubit.firstStatus,
            isExpanded: true,
            menuMaxHeight: 300.height,
            underline: const Material(),
            hint: Text(appLocalizations.choose),
            borderRadius: BorderRadius.circular(12.0),
            icon: const Icon(Icons.expand_more_rounded),
            items: [
              DropdownMenuItem(
                value: ConsultationStatus.draft,
                child: Text(
                  appLocalizations.getConsultationStatus(
                    ConsultationStatus.draft,
                    false,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: ConsultationStatus.pending,
                child: Text(
                  appLocalizations.getConsultationStatus(
                    ConsultationStatus.pending,
                    false,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: ConsultationStatus.scehduled,
                child: Text(
                  appLocalizations.getConsultationStatus(
                    ConsultationStatus.scehduled,
                    false,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: ConsultationStatus.requestToChangetime,
                child: Text(
                  appLocalizations.getConsultationStatus(
                    ConsultationStatus.requestToChangetime,
                    false,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: ConsultationStatus.approvedByConsultant,
                child: Text(
                  appLocalizations.getConsultationStatus(
                    ConsultationStatus.approvedByConsultant,
                    false,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: ConsultationStatus.pendingPayment,
                child: Text(
                  appLocalizations.getConsultationStatus(
                    ConsultationStatus.pendingPayment,
                    false,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: ConsultationStatus.underReview,
                child: Text(
                  appLocalizations.getConsultationStatus(
                    ConsultationStatus.underReview,
                    false,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: ConsultationStatus.answeredByConsultant,
                child: Text(
                  appLocalizations.getConsultationStatus(
                    ConsultationStatus.answeredByConsultant,
                    false,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: ConsultationStatus.ended,
                child: Text(
                  appLocalizations.getConsultationStatus(
                    ConsultationStatus.ended,
                    false,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: ConsultationStatus.cancelledByConsultant,
                child: Text(
                  appLocalizations.getConsultationStatus(
                    ConsultationStatus.cancelledByConsultant,
                    false,
                  ),
                ),
              ),
            ],
            onChanged: (value) => setState(
                () => cubit.applyFilters(status: value != null ? [value] : [])),
          ),
        ),
      ),
    );
  }
}
