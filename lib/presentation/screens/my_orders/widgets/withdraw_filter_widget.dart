import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../localization/localizor.dart';
import '../../../../utilities/extensions.dart';
import '../cubit/my_orders_cubit.dart';

class WithdrawFilterWidget extends StatefulWidget {
  const WithdrawFilterWidget({super.key});

  @override
  State<WithdrawFilterWidget> createState() => _WithdrawFilterWidgetState();
}

class _WithdrawFilterWidgetState extends State<WithdrawFilterWidget> {
  bool hasFilters = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              Localizor.translator.sortBy,
              style: AppStyle.smallTitleStyle,
            ),
            if (hasFilters)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.width, vertical: 4.height),
                child: InkWell(
                  onTap: () {
                    DIManager.findDep<MyOrdersCubit>().applyWithdrawFilters(
                      forceNull: true,
                    );
                    setState(() {
                      hasFilters = false;
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                      Text('ازاله الفلترة')
                    ],
                  ),
                ),
              ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                showSortBottomSheet();
              },
              child: Row(
                children: [
                  FloatingActionButton(
                      heroTag: 'filter-fab',
                      elevation: 0,
                      highlightElevation: 0,
                      backgroundColor: BrandColors.snowWhite,
                      onPressed: null,
                      child: 'filter'.buildSVG(color: BrandColors.darkGray)),
                  5.emptyWidth,
                  const Text('الاقدمية')
                ],
              ),
            ),
            20.emptyWidth,
            InkWell(
              onTap: () {
                _buildDateTimeRangePicker();
              },
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: 'sort-fab',
                    elevation: 0,
                    highlightElevation: 0,
                    backgroundColor: BrandColors.snowWhite,
                    onPressed: null,
                    child: 'filter'.buildSVG(color: BrandColors.darkGray),
                  ),
                  5.emptyWidth,
                  Text(Localizor.translator.hisotry)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showSortBottomSheet() {
    final bottom = MediaQuery.of(context).viewPadding.bottom;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(29.0)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(40.width, 20.height, 40.width, bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Localizor.translator.sortBy,
              style: const TextStyle(
                fontSize: 16.0,
                color: BrandColors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text(
                Localizor.translator.descendingOrder,
                style: const TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                DIManager.findDep<MyOrdersCubit>()
                    .applyWithdrawFilters(sort: 'desc');
                setState(() {
                  hasFilters = true;
                });

                DIManager.findNavigator().pop();
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                Localizor.translator.ascendingOrder,
                style: const TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                setState(() {
                  hasFilters = true;
                });
                DIManager.findDep<MyOrdersCubit>()
                    .applyWithdrawFilters(sort: 'asc');
                DIManager.findNavigator().pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _buildDateTimeRangePicker() {
    showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((range) {
      if (range != null) {
        setState(() {
          hasFilters = true;
        });
        var start = DateFormat('yyyy-MM-dd').format(range.start);
        var end = DateFormat('yyyy-MM-dd').format(range.end);
        DIManager.findDep<MyOrdersCubit>()
            .applyWithdrawFilters(startDate: start, endDate: end);
      }
    });
  }
}
