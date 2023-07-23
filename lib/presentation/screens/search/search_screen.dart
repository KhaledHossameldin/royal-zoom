import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:search_choices/search_choices.dart';

import '../../../constants/brand_colors.dart';
import '../../../constants/routes.dart';
import '../../../cubits/search/search_cubit.dart';
import '../../../data/enums/consultant_response_type.dart';
import '../../../data/enums/consultation_status.dart';
import '../../../data/models/consultations/consultations_filter.dart';
import '../../../data/models/major.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../../widgets/brand_back_button.dart';
import '../../widgets/reload_widget.dart';
import '../send_consultations/fast/filter_screen.dart';

enum Review { unreviewed, reviewed }

class _ReviewSelection {
  final Review review;
  bool isSelected = false;

  _ReviewSelection({required this.review});
}

class _ConsultationSelection {
  final ConsultationStatus status;
  bool isSelected = false;

  _ConsultationSelection({required this.status});
}

class _ConsultantResponseSelection {
  final ConsultantResponseType type;
  bool isSelected = false;

  _ConsultantResponseSelection({required this.type});
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  final _numberController = TextEditingController();
  final _dateRangeController = TextEditingController();
  final _startPrice = TextEditingController(text: '0');
  final _endPrice = TextEditingController(text: '1000');
  final _isViewBottom = ValueNotifier<bool>(false);
  final _status = [
    _ConsultationSelection(status: ConsultationStatus.draft),
    _ConsultationSelection(status: ConsultationStatus.pending),
    _ConsultationSelection(status: ConsultationStatus.scehduled),
    _ConsultationSelection(status: ConsultationStatus.requestToChangetime),
    _ConsultationSelection(status: ConsultationStatus.approvedByConsultant),
    _ConsultationSelection(status: ConsultationStatus.confirmedByUser),
    _ConsultationSelection(status: ConsultationStatus.pendingPayment),
    _ConsultationSelection(status: ConsultationStatus.underReview),
    _ConsultationSelection(status: ConsultationStatus.answeredByConsultant),
    _ConsultationSelection(status: ConsultationStatus.ended),
    _ConsultationSelection(status: ConsultationStatus.cancelledByConsultant),
    _ConsultationSelection(status: ConsultationStatus.cancelledByUser),
    _ConsultationSelection(status: ConsultationStatus.cancelledBySystem),
  ];
  final _responseTypes = [
    _ConsultantResponseSelection(type: ConsultantResponseType.text),
    _ConsultantResponseSelection(type: ConsultantResponseType.voice),
    _ConsultantResponseSelection(type: ConsultantResponseType.video),
    _ConsultantResponseSelection(type: ConsultantResponseType.onlineMeeting),
    _ConsultantResponseSelection(
      type: ConsultantResponseType.appropriateForConsultant,
    ),
    _ConsultantResponseSelection(
      type: ConsultantResponseType.fieldConsultation,
    ),
    _ConsultantResponseSelection(type: ConsultantResponseType.appCall),
    _ConsultantResponseSelection(
      type: ConsultantResponseType.frequentConsultation,
    ),
  ];
  final _reviews = [
    _ReviewSelection(review: Review.unreviewed),
    _ReviewSelection(review: Review.reviewed),
  ];
  final _appointments = [false, false, false];
  final _payment = [false, false];
  final _paymentEvaluation = [false, false];
  final _paymentType = [false, false];

  double _reviewsCount = 0.0;
  bool _isFavourite = false;
  RangeValues rangeValues = const RangeValues(0, 1000);

  int? _mainMajorId;
  int? _subMajorId;
  DateTimeRange? _dateRange;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    context.read<SearchCubit>().fetch(context);
    super.initState();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _dateRangeController.dispose();
    _startPrice.dispose();
    _endPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      appBar: AppBar(
        leading: const BrandBackButton(),
        title: Text(appLocalizations.search),
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchLoaded) {
            _isViewBottom.value = true;
            return;
          }
          _isViewBottom.value = false;
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case SearchLoading:
              return const Center(child: CircularProgressIndicator());

            case SearchLoaded:
              state as SearchLoaded;
              final majors = state.majors;
              final consultants = state.consultants;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 21.height,
                      horizontal: 35.width,
                    ),
                    child: TabBar(
                      controller: _controller,
                      tabs: [
                        Tab(text: appLocalizations.consultation),
                        Tab(text: appLocalizations.consultationNumberTitle),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35.width),
                          child: ListView(
                            children: [
                              _Item(
                                title: appLocalizations.mainMajor,
                                child: _buildMajorsDropDown(majors),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.subMajor,
                                child: _buildMajorsDropDown(
                                  majors,
                                  isMain: false,
                                ),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.consultationStatus,
                                child: _buildStatusSelection(),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.consultant,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.width,
                                  ),
                                  decoration: BoxDecoration(
                                    color: BrandColors.snowWhite,
                                    borderRadius: BorderRadius.circular(29.0),
                                  ),
                                  child: SearchChoices.multiple(
                                    isExpanded: true,
                                    rightToLeft: true,
                                    selectedItems: const [],
                                    displayClearIcon: false,
                                    underline: const Material(),
                                    hint: appLocalizations.choose,
                                    icon: const Icon(Icons.expand_more),
                                    onChanged: (value) {},
                                    doneButton:
                                        MaterialLocalizations.of(context)
                                            .saveButtonLabel,
                                    closeButton:
                                        MaterialLocalizations.of(context)
                                            .closeButtonLabel,
                                    items: const <DropdownMenuItem<String>>[
                                      DropdownMenuItem(
                                        value: '1',
                                        child: ListTile(
                                          leading: CircleAvatar(),
                                          title: Text('Consultant'),
                                          subtitle: Text('Consultant'),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: '2',
                                        child: ListTile(
                                          leading: CircleAvatar(),
                                          title: Text('Consultant'),
                                          subtitle: Text('Consultant'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //TODO: Implement consultant search
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.date,
                                child: _buildDateTimeRangePicker(),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.review,
                                child: _buildReviews(),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.consultantResponse,
                                child: _buildConsultantResponse(),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.appointments,
                                child: _buildAppointments(),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.favorite,
                                child: _buildFavourite(),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.consultationPrice,
                                child: _buildPriceSlider(1000),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.paymentStatusSearch,
                                child: _buildPaymentStatus(),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.paymentEvaluation,
                                child: _buildPaymentEvaluation(),
                              ),
                              10.emptyHeight,
                              _Item(
                                title: appLocalizations.paymentStatusSearch,
                                child: _buildPaymentType(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35.width),
                          child: _Item(
                            title: appLocalizations.consultationNumberTitle,
                            child: TextField(
                              controller: _numberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                suffixIcon: 'search'.imageIcon,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

            case SearchError:
              state as SearchError;
              return ReloadWidget(
                title: state.message,
                buttonText: appLocalizations.getReload(''),
                onPressed: () => context.read<SearchCubit>().fetch(context),
              );

            default:
              return const Material();
          }
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _isViewBottom,
        builder: (context, value, child) {
          if (!value) {
            return const Material();
          }
          return BottomAppBar(
            elevation: 2.0,
            padding: EdgeInsets.only(
              right: 35.width,
              left: 35.width,
              top: 16.height,
            ),
            child: ElevatedButton(
              onPressed: () {
                final filter = ConsultationsFilter(
                  mainMajorId: _mainMajorId,
                  subMajorId: _subMajorId,
                  status: _status
                      .where((element) => element.isSelected)
                      .map((e) => e.status)
                      .toList(),
                  dateRange: _dateRange,
                  responseTypes: _responseTypes
                      .where((element) => element.isSelected)
                      .map((e) => e.type)
                      .toList(),
                  isPaid: _payment[0] == _payment[1] ? null : _payment[0],
                );
                Navigator.pushNamed(
                  context,
                  Routes.consultationsResults,
                  arguments: filter,
                );
              },
              child: Text(appLocalizations.search),
            ),
          );
        },
      ),
    );
  }

  StatefulBuilder _buildPaymentType() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _paymentType[0],
            title: Text(appLocalizations.specifiedByConsultant),
            onChanged: (value) => setState(() => _paymentType[0] = value!),
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _paymentType[1],
            title: Text(appLocalizations.specificCeiling),
            onChanged: (value) => setState(() => _paymentType[1] = value!),
          ),
        ],
      ),
    );
  }

  StatefulBuilder _buildPaymentEvaluation() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _paymentEvaluation[0],
            title: Text(appLocalizations.evaluatedByUser),
            onChanged: (value) =>
                setState(() => _paymentEvaluation[0] = value!),
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _paymentEvaluation[1],
            title: Text(appLocalizations.evaluatedByConsultant),
            onChanged: (value) =>
                setState(() => _paymentEvaluation[1] = value!),
          ),
        ],
      ),
    );
  }

  StatefulBuilder _buildPaymentStatus() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _payment[0],
            title: Text(appLocalizations.paid),
            onChanged: (value) => setState(() => _payment[0] = value!),
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _payment[1],
            title: Text(appLocalizations.notPaid),
            onChanged: (value) => setState(() => _payment[1] = value!),
          ),
        ],
      ),
    );
  }

  StatefulBuilder _buildPriceSlider(num maxPrice) {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RangeSlider(
            max: maxPrice.toDouble(),
            divisions: maxPrice.toInt(),
            values: rangeValues,
            onChanged: (value) => setState(() {
              rangeValues = value;
              _startPrice.text = value.start.toInt().toString();
              _endPrice.text = value.end.toInt().toString();
            }),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appLocalizations.from),
                    2.emptyHeight,
                    TextField(
                      inputFormatters: [
                        LimitRange(0, maxPrice.toInt()),
                      ],
                      controller: _startPrice,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 6.height,
                          horizontal: 9.width,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        suffixIcon: Center(
                          widthFactor: 1.0,
                          child: Text(appLocalizations.sar),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _startPrice.text = '0';
                        }
                        final number = double.tryParse(value) ?? 0.0;
                        setState(() =>
                            rangeValues = RangeValues(number, rangeValues.end));
                      },
                    ),
                  ],
                ),
              ),
              50.emptyWidth,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appLocalizations.to),
                    2.emptyHeight,
                    TextField(
                      inputFormatters: [
                        LimitRange(0, maxPrice.toInt()),
                      ],
                      controller: _endPrice,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 6.height,
                          horizontal: 9.width,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        suffixIcon: Center(
                          widthFactor: 1.0,
                          child: Text(appLocalizations.sar),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _endPrice.text = '0';
                        }
                        final number = double.tryParse(value) ?? 0.0;
                        setState(() => rangeValues =
                            RangeValues(rangeValues.start, number));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  StatefulBuilder _buildFavourite() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        dense: true,
        value: _isFavourite,
        title: Text(appLocalizations.favorite),
        onChanged: (value) => setState(() => _isFavourite = value!),
      ),
    );
  }

  StatefulBuilder _buildAppointments() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _appointments[0],
            title: Text(appLocalizations.dateChange),
            onChanged: (value) => setState(() => _appointments[0] = value!),
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _appointments[1],
            title: Text(appLocalizations.consultantAppointments),
            onChanged: (value) => setState(() => _appointments[1] = value!),
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _appointments[2],
            title: Text(appLocalizations.notIncludedAppointments),
            onChanged: (value) => setState(() => _appointments[2] = value!),
          ),
        ],
      ),
    );
  }

  StatefulBuilder _buildConsultantResponse() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: _responseTypes
            .map((e) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  value: e.isSelected,
                  title: Text(
                    appLocalizations.getConsultantResponseType(e.type),
                  ),
                  onChanged: (value) => setState(() => e.isSelected = value!),
                ))
            .toList(),
      ),
    );
  }

  StatefulBuilder _buildReviews() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _reviews[0].isSelected,
            title: Text(appLocalizations.unreviewed),
            onChanged: (value) =>
                setState(() => _reviews[0].isSelected = value!),
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _reviews[1].isSelected,
            title: Text(appLocalizations.reviewed),
            onChanged: (value) =>
                setState(() => _reviews[1].isSelected = value!),
          ),
          RatingBar(
            glow: false,
            ratingWidget: RatingWidget(
              full: const Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              half: const Icon(
                color: Colors.amber,
                Icons.star_half_rounded,
              ),
              empty: const Icon(
                color: Colors.amber,
                Icons.star_outline_rounded,
              ),
            ),
            onRatingUpdate: (value) => _reviewsCount = value,
          ),
        ],
      ),
    );
  }

  StatefulBuilder _buildDateTimeRangePicker() => StatefulBuilder(
        builder: (context, setState) => TextField(
          readOnly: true,
          controller: _dateRangeController,
          enableInteractiveSelection: false,
          decoration: const InputDecoration(
            isDense: true,
            prefixIcon: Icon(Icons.calendar_month_rounded),
            prefixIconColor: BrandColors.orange,
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
              setState(() {
                _dateRange = range;
                _dateRangeController.text = range.text;
              });
            }
          },
        ),
      );

  StatefulBuilder _buildStatusSelection() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: _status
            .map((e) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  value: e.isSelected,
                  title: Text(
                      appLocalizations.getConsultationStatus(e.status, false)),
                  onChanged: (value) => setState(() => e.isSelected = value!),
                ))
            .toList(),
      ),
    );
  }

  Material _buildMajorsDropDown(List<Major> majors, {isMain = true}) {
    final appLocalizations = AppLocalizations.of(context);

    return Material(
      color: BrandColors.snowWhite,
      borderRadius: BorderRadius.circular(12.0),
      child: ButtonTheme(
        alignedDropdown: true,
        child: StatefulBuilder(
          builder: (context, setState) => DropdownButton<int>(
            value: isMain ? _mainMajorId : _subMajorId,
            isExpanded: true,
            menuMaxHeight: 300.height,
            hint: Text(appLocalizations.choose),
            underline: const Material(),
            borderRadius: BorderRadius.circular(12.0),
            icon: const Icon(Icons.expand_more_rounded),
            items: majors
                .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
                .toList(),
            onChanged: (value) => setState(() {
              if (isMain) {
                _mainMajorId = value;
                return;
              }
              _subMajorId = value;
            }),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: BrandColors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        8.emptyHeight,
        child,
      ],
    );
  }
}
