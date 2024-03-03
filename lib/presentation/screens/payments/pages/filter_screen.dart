import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../cubits/invoice/invoice_cubit.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';

class PaymentsFilterScreen extends StatefulWidget {
  const PaymentsFilterScreen({super.key, required this.maxPrice});

  final num maxPrice;

  @override
  State<PaymentsFilterScreen> createState() => _PaymentsFilterScreenState();
}

class _PaymentsFilterScreenState extends State<PaymentsFilterScreen> {
  DateTimeRange? _dateRange;

  late RangeValues rangeValues = RangeValues(0, widget.maxPrice.toDouble());
  final _dateRangeController = TextEditingController();
  final _start = TextEditingController(text: '0');
  late final _end =
      TextEditingController(text: widget.maxPrice.toInt().toString());

  @override
  void initState() {
    context.read<InvoiceCubit>().clear();
    super.initState();
  }

  @override
  void dispose() {
    _dateRangeController.dispose();
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 9.height,
          horizontal: 34.width,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildPriceSlider(),
            // 14.emptyHeight,
            _buildDateTimeRangePicker(),
            14.emptyHeight,
            ElevatedButton(
              onPressed: () {
                final cubit = context.read<InvoiceCubit>();
                cubit.applyFilters(dateRange: _dateRange);
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

  StatefulBuilder _buildDateTimeRangePicker() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.date,
            style: const TextStyle(
              fontSize: 16.0,
              color: BrandColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          8.emptyHeight,
          TextField(
            readOnly: true,
            controller: _dateRangeController,
            enableInteractiveSelection: false,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
        ],
      ),
    );
  }

  StatefulBuilder _buildPriceSlider() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.price,
            style: const TextStyle(
              fontSize: 16.0,
              color: BrandColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
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
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
