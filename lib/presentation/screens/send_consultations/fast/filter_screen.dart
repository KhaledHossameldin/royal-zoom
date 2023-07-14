import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../cubits/consultants/consultants_cubit.dart';
import '../../../../cubits/filter/filter_cubit.dart';
import '../../../../data/models/authentication/city.dart';
import '../../../../data/models/major.dart';
import '../../../../data/services/repository.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/countries.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/reload_widget.dart';

class SendConsultantionFilterScreen extends StatefulWidget {
  const SendConsultantionFilterScreen({super.key, required this.maxPrice});

  final num maxPrice;

  @override
  State<SendConsultantionFilterScreen> createState() =>
      _SendConsultantionFilterScreenState();
}

class _SendConsultantionFilterScreenState
    extends State<SendConsultantionFilterScreen> {
  bool isFavouriteOnly = false;

  int? majorId;

  late RangeValues rangeValues = RangeValues(0, widget.maxPrice.toDouble());

  final _start = TextEditingController(text: '0');
  late final _end =
      TextEditingController(text: widget.maxPrice.toInt().toString());
  final reviews = [];

  @override
  void initState() {
    final country = countries.firstWhere((element) =>
        element.code == Repository.instance.currentLocation.isoCountryCode);
    context
        .read<ConsultantsFilterCubit>()
        .fetch(context, countryId: country.id);
    super.initState();
  }

  @override
  void dispose() {
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(appLocalizations.filter),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ConsultantsCubit>().clearFilter();
              context.read<ConsultantsCubit>().fetch(context);
              Navigator.pop(context, majorId);
            },
            child: Text(appLocalizations.reset),
          ),
        ],
      ),
      body: BlocBuilder<ConsultantsFilterCubit, ConsultantsFilterState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case FilterLoading:
              state as FilterLoading;
              if (state.countries == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _buildBody(state);
              }

            case ConsultantsFilterLoaded:
              state as ConsultantsFilterLoaded;
              return _buildBody(state);

            case ConsultantsFilterError:
              state as ConsultantsFilterError;
              if (state.countries == null) {
                return ReloadWidget(
                  title: state.message,
                  buttonText:
                      appLocalizations.getReload(appLocalizations.filter),
                  onPressed: () =>
                      context.read<ConsultantsFilterCubit>().fetch(context),
                );
              } else {
                return _buildBody(state);
              }

            default:
              return const Material();
          }
        },
      ),
    );
  }

  SingleChildScrollView _buildBody(ConsultantsFilterState state) {
    final appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 34.width,
      ),
      child: Column(
        children: [
          Builder(builder: (context) {
            if (state is FilterLoading) {
              return const CircularProgressIndicator();
            } else if (state is ConsultantsFilterError) {
              return Text(state.message);
            } else {
              return _buildCities((state as ConsultantsFilterLoaded).cities);
            }
          }),
          15.emptyHeight,
          _buildVerifiedCheckBox(),
          15.emptyHeight,
          _buildPriceSlider(),
          15.emptyHeight,
          _buildMajors(state.majors!),
          15.emptyHeight,
          StatefulBuilder(
            builder: (context, setState) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appLocalizations.review),
                Wrap(
                  spacing: 10.width,
                  children: [
                    _buildReviewChip(setState, index: 0),
                    _buildReviewChip(setState, index: 1),
                    _buildReviewChip(setState, index: 2),
                    _buildReviewChip(setState, index: 3),
                    _buildReviewChip(setState, index: 4),
                    _buildReviewChip(setState, index: 5),
                  ],
                ),
              ],
            ),
          ),
          15.emptyHeight,
          StatefulBuilder(
            builder: (context, setState) => CheckboxListTile(
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(appLocalizations.favorite),
              value: isFavouriteOnly,
              onChanged: (value) => setState(() => isFavouriteOnly = value!),
            ),
          ),
          15.emptyHeight,
          ElevatedButton(
            onPressed: () {
              context.read<ConsultantsCubit>().fetch(context);
              Navigator.pop(context, majorId);
            },
            child: Text(appLocalizations.viewResults),
          ),
        ],
      ),
    );
  }

  ChoiceChip _buildReviewChip(StateSetter setState, {required int index}) {
    final appLocalizations = AppLocalizations.of(context);

    bool isSelected = reviews.contains(index);

    return ChoiceChip(
      label: Text(appLocalizations.getStars(index)),
      selected: isSelected,
      onSelected: (value) {
        setState(() {
          if (isSelected) {
            reviews.remove(index);
            return;
          }
          reviews.add(index);
        });
      },
    );
  }

  StatefulBuilder _buildPriceSlider() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.pricePerHour),
          RangeSlider(
            max: widget.maxPrice.toDouble(),
            divisions: widget.maxPrice.toInt(),
            values: rangeValues,
            onChanged: (value) => setState(() {
              rangeValues = value;
              _start.text = value.start.toInt().toString();
              _end.text = value.end.toInt().toString();
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
                        LimitRange(0, widget.maxPrice.toInt()),
                      ],
                      controller: _start,
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
                          _start.text = '0';
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
                        LimitRange(0, widget.maxPrice.toInt()),
                      ],
                      controller: _end,
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
                          _end.text = '0';
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

  StatefulBuilder _buildMajors(List<Major> majors) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final consultantsCubit = context.read<ConsultantsCubit>();

    return StatefulBuilder(
      builder: (context, setState) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.getMajor(true)),
          8.emptyHeight,
          Material(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(12.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<int>(
                value: consultantsCubit.majorId,
                isExpanded: true,
                menuMaxHeight: 300.height,
                hint: Text(appLocalizations.choose),
                underline: const Material(),
                borderRadius: BorderRadius.circular(12.0),
                icon: const Icon(Icons.expand_more_rounded),
                style: textTheme.bodySmall!.copyWith(
                  color: BrandColors.darkBlue,
                ),
                items: majors
                    .map((item) => DropdownMenuItem<int>(
                        value: item.id, child: Text(item.name)))
                    .toList(),
                onChanged: (value) {
                  majorId = value;
                  setState(() => consultantsCubit.applyFilter(majorId: value));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  StatefulBuilder _buildVerifiedCheckBox() {
    final appLocalizations = AppLocalizations.of(context);
    final cubit = context.read<ConsultantsCubit>();

    return StatefulBuilder(
      builder: (context, setState) => CheckboxListTile(
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(appLocalizations.viewVerifiedOnly),
        value: cubit.verifiedOnly,
        onChanged: (value) =>
            setState(() => cubit.applyFilter(verifiedOnly: value)),
      ),
    );
  }

  StatefulBuilder _buildCities(List<City>? cities) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final cubit = context.read<ConsultantsCubit>();

    return StatefulBuilder(
      builder: (context, setState) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.city),
          8.emptyHeight,
          Material(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(12.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<int>(
                value: cubit.cityId,
                isExpanded: true,
                menuMaxHeight: 300.height,
                hint: Text(appLocalizations.choose),
                underline: const Material(),
                borderRadius: BorderRadius.circular(12.0),
                icon: const Icon(Icons.expand_more_rounded),
                style: textTheme.bodySmall!.copyWith(
                  color: BrandColors.darkBlue,
                ),
                items: cities
                    ?.map((item) => DropdownMenuItem<int>(
                        value: item.id, child: Text(item.name)))
                    .toList(),
                onChanged: (value) => setState(
                  () => cubit.applyFilter(cityId: value),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LimitRange extends TextInputFormatter {
  LimitRange(
    this.minRange,
    this.maxRange,
  ) : assert(minRange < maxRange);

  final int minRange;
  final int maxRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.tryParse(newValue.text) ?? 0;
    if (value < minRange) {
      return TextEditingValue(text: minRange.toString());
    } else if (value > maxRange) {
      return TextEditingValue(text: maxRange.toString());
    }
    return newValue;
  }
}
