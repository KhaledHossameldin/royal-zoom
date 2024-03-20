import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/authentication/authentication_bloc.dart';
import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../cubits/invoice/invoice_cubit.dart';
import '../../../../data/enums/invoice_type.dart';
import '../../../../data/enums/sort.dart';
import '../../../../data/models/invoices/invoice.dart';
import '../../../../data/sources/local/shared_prefs.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/gradient_progress_bar.dart';
import '../../../widgets/reload_widget.dart';

class PaymentsTab extends StatefulWidget {
  const PaymentsTab({super.key});

  @override
  State<PaymentsTab> createState() => _PaymentsTabState();
}

class _PaymentsTabState extends State<PaymentsTab> {
  @override
  void initState() {
    context.read<InvoiceCubit>().fetch(context, type: InvoiceType.walletCharge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case InvoiceLoading:
            return const Center(child: CircularProgressIndicator());

          case InvoiceLoaded:
            state as InvoiceLoaded;
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const _HeaderCard(),
                SliverToBoxAdapter(child: 22.emptyHeight),
                _TotalPayments(statistics: state.statistics),
                SliverToBoxAdapter(child: Divider(height: 32.height)),
                if (state.invoices.isNotEmpty)
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 27.width),
                      sliver: SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: _StickySearch(context, appLocalizations),
                      ),
                    ),
                  ),
              ],
              body: state.invoices.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async => context
                          .read<InvoiceCubit>()
                          .fetch(context, type: InvoiceType.walletCharge),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.height,
                          horizontal: 16.width,
                        ),
                        itemCount: state.invoices.length,
                        separatorBuilder: (context, index) => 16.emptyHeight,
                        itemBuilder: (context, index) =>
                            _Item(invoice: state.invoices[index]),
                      ),
                    )
                  : Center(child: Text(appLocalizations.invoicesEmpty)),
            );

          case InvoiceError:
            return ReloadWidget(
              title: (state as InvoiceError).message,
              buttonText: appLocalizations.getReload(''),
              onPressed: () => context
                  .read<InvoiceCubit>()
                  .fetch(context, type: InvoiceType.walletCharge),
            );

          default:
            return const Material();
        }
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.invoice});

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.height,
            horizontal: 12.width,
          ),
          child: Column(children: [
            Row(children: [
              Expanded(child: _buildHeader(appLocalizations)),
              Expanded(
                child: Center(
                  child: Text(
                    NumberFormat.currency(
                      decimalDigits: 0,
                      name: appLocalizations.sar,
                    ).format(invoice.amount),
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: BrandColors.green,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _buildStatus(appLocalizations),
              ),
            ]),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(children: [
                    if (invoice.lastDate != null)
                      TextSpan(text: appLocalizations.transferDate),
                    const TextSpan(text: ': '),
                    TextSpan(
                      text:
                          DateFormat.yMMMd().add_jm().format(invoice.lastDate!),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text.rich(
                  TextSpan(children: [
                    if (invoice.lastDate != null)
                      TextSpan(text: appLocalizations.invoiceNumber),
                    const TextSpan(text: ': '),
                    TextSpan(
                      text: invoice.id.toString(),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            8.emptyHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(children: [
                    if (invoice.lastDate != null)
                      TextSpan(text: appLocalizations.paymentMethod),
                    const TextSpan(text: ': '),
                    TextSpan(
                      text: appLocalizations
                          .getPaymentMethod(invoice.paymentMethod),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text.rich(
                  TextSpan(children: [
                    if (invoice.lastDate != null)
                      TextSpan(text: appLocalizations.transferReceipt),
                    const TextSpan(text: ': '),
                    WidgetSpan(
                        child: 'normal_consultation'.buidImageIcon(
                      color: BrandColors.orange,
                    )),
                  ]),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Container _buildStatus(AppLocalizations appLocalizations) {
    String text = '';
    Color color = BrandColors.orange;
    if (invoice.cancelledAt != null) {
      text = appLocalizations.cancelled;
      color = BrandColors.red;
    } else if (invoice.refundedAt != null) {
      text = appLocalizations.refunded;
      color = BrandColors.gray;
    } else if (invoice.paidAt != null) {
      text = appLocalizations.completed;
      color = BrandColors.green;
    } else {
      text = appLocalizations.hold;
    }
    return Container(
      height: 35.height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: 5.height,
        horizontal: 13.width,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 13.0, color: color),
      ),
    );
  }

  ListTile _buildHeader(AppLocalizations appLocalizations) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 42.width,
          height: 42.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 0.5,
              color: Colors.grey.shade300,
            ),
            image: DecorationImage(
              image: 'royake'.png.image,
            ),
          ),
        ),
        title: FittedBox(
          child: Text(
            invoice.amount > 0
                ? appLocalizations.addCredit
                : appLocalizations.refund,
            style: const TextStyle(fontSize: 12.0),
          ),
        ),
        subtitle: FittedBox(
          fit: BoxFit.none,
          child: Text(
            appLocalizations.getPaymentMethod(invoice.paymentMethod),
            style: const TextStyle(fontSize: 11.0, color: Colors.grey),
          ),
        ),
      );
}

class _StickySearch extends SliverPersistentHeaderDelegate {
  _StickySearch(this.screenContext, this.appLocalizations);

  final AppLocalizations appLocalizations;
  final BuildContext screenContext;

  void sort(BuildContext context, {required Sort sort}) {
    final cubit = screenContext.read<InvoiceCubit>();
    cubit.applyFilters(sort: sort);
    cubit.fetch(context);
    Navigator.pop(context);
  }

  void showSortBottomSheet(BuildContext context) {
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
              appLocalizations.sortBy,
              style: const TextStyle(
                fontSize: 16.0,
                color: BrandColors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text(
                appLocalizations.descendingOrder,
                style: const TextStyle(fontSize: 16.0),
              ),
              onTap: () => sort(context, sort: Sort.descending),
            ),
            const Divider(),
            ListTile(
              title: Text(
                appLocalizations.ascendingOrder,
                style: const TextStyle(fontSize: 16.0),
              ),
              onTap: () => sort(context, sort: Sort.ascending),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appLocalizations.totalPayments,
          style: const TextStyle(fontSize: 16.0, color: BrandColors.darkGreen),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'filter-fab',
              elevation: 0,
              highlightElevation: 0,
              backgroundColor: BrandColors.snowWhite,
              child: 'filter'.buildSVG(color: BrandColors.darkGray),
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.paymentsFilter,
                arguments: {
                  'price': 100,
                  'cubit': context.read<InvoiceCubit>(),
                },
              ),
            ),
            FloatingActionButton(
              heroTag: 'sort-fab',
              elevation: 0,
              highlightElevation: 0,
              backgroundColor: BrandColors.snowWhite,
              child: 'filter'.buildSVG(color: BrandColors.darkGray),
              onPressed: () => showSortBottomSheet(context),
            ),
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => kTextTabBarHeight;

  @override
  double get minExtent => kTextTabBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _TotalPayments extends StatelessWidget {
  const _TotalPayments({required this.statistics});

  final int statistics;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 27.width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: BrandColors.gray),
        ),
        child: Column(
          children: [
            12.emptyHeight,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.width),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.totalPayments,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: BrandColors.darkGreen,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(name: appLocalizations.sar)
                        .format(10000),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: BrandColors.orange,
                    ),
                  ),
                ],
              ),
            ),
            16.emptyHeight,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.width),
              child: GradientProgressBar(progress: statistics),
            ),
            32.emptyHeight,
            SizedBox(
              height: 100.height,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.green,
                      dotData: const FlDotData(show: false),
                      spots: [
                        const FlSpot(2023, 50),
                        const FlSpot(2022, 20),
                        const FlSpot(2021, 90),
                        const FlSpot(2020, 40),
                        const FlSpot(2019, 60),
                      ],
                    ),
                    LineChartBarData(
                      color: Colors.red,
                      dotData: const FlDotData(show: false),
                      spots: [
                        const FlSpot(2023, 10),
                        const FlSpot(2022, 15),
                        const FlSpot(2021, 50),
                        const FlSpot(2020, 25),
                        const FlSpot(2019, 25),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    final user = DIManager.findDep<SharedPrefs>().getUser()!;
    final appLocalizations = AppLocalizations.of(context);

    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 27.width),
        padding: EdgeInsets.symmetric(
          vertical: 12.height,
          horizontal: 12.width,
        ),
        decoration: BoxDecoration(
          color: Colors.green.shade900,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.walletBalance,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                PopupMenuButton<String>(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onSelected: (value) {},
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(appLocalizations.refundRequest),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              NumberFormat.currency(name: appLocalizations.sar)
                  .format(user.walletBalance),
              style: const TextStyle(
                fontSize: 24.0,
                color: BrandColors.orange,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Text(
              '+ 0،8٪ من الأسبوع الماضي',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
            31.emptyHeight,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.width),
              child: Row(children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 43.height),
                      backgroundColor: Colors.white,
                      foregroundColor: BrandColors.darkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(Routes.addBalanceToWalletScreen);
                    },
                    icon: 'add_credit'.svg,
                    label: FittedBox(
                      child: Text(appLocalizations.addCredit),
                    ),
                  ),
                ),
                24.emptyWidth,
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 43.height),
                      backgroundColor: Colors.white,
                      foregroundColor: BrandColors.darkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {},
                    icon: Container(
                      width: 25.98.width,
                      height: 25.98.height,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: BrandColors.darkGreen,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: 'transfer_credit'.svg,
                    ),
                    label: FittedBox(
                      child: Text(appLocalizations.transferCredit),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
