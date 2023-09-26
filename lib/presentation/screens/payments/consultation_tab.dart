import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants/brand_colors.dart';
import '../../../constants/routes.dart';
import '../../../cubits/invoice/invoice_cubit.dart';
import '../../../data/enums/invoice_type.dart';
import '../../../data/enums/sort.dart';
import '../../../data/models/invoices/invoice.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../../widgets/reload_widget.dart';

class ConsultationTab extends StatefulWidget {
  const ConsultationTab({super.key});

  @override
  State<ConsultationTab> createState() => _ConsultationTabState();
}

class _ConsultationTabState extends State<ConsultationTab> {
  final _controller = TextEditingController();

  @override
  void initState() {
    final cubit = context.read<InvoiceCubit>();
    cubit.clear();
    cubit.fetch(context, type: InvoiceType.consultation);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<InvoiceCubit, InvoiceState>(
      listener: (context, state) {
        if (state is InvoiceLoaded) {}
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case InvoiceLoading:
            return const Center(child: CircularProgressIndicator());

          case InvoiceLoaded:
            final invoices = (state as InvoiceLoaded).invoices;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.width),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            isDense: true,
                            suffixIcon: 'search'.imageIcon,
                            hintText: appLocalizations.search,
                          ),
                          onSubmitted: (value) {
                            final cubit = context.read<InvoiceCubit>();
                            cubit.applyFilters(searchText: value);
                            cubit.fetch(context);
                          },
                        ),
                      ),
                      8.emptyWidth,
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
                      5.emptyWidth,
                      FloatingActionButton(
                        heroTag: 'sort-fab',
                        elevation: 0,
                        highlightElevation: 0,
                        backgroundColor: BrandColors.snowWhite,
                        onPressed: () => showSortBottomSheet(appLocalizations),
                        child: 'filter'.buildSVG(color: BrandColors.darkGray),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.height,
                      horizontal: 16.width,
                    ),
                    itemCount: invoices.length,
                    separatorBuilder: (context, index) => 12.emptyHeight,
                    itemBuilder: (context, index) =>
                        _Item(invoice: invoices[index]),
                  ),
                ),
              ],
            );

          case InvoiceError:
            return ReloadWidget(
              title: (state as InvoiceError).message,
              buttonText: appLocalizations.getReload(''),
              onPressed: () => context
                  .read<InvoiceCubit>()
                  .fetch(context, type: InvoiceType.consultation),
            );

          default:
            return const Material();
        }
      },
    );
  }

  void showSortBottomSheet(AppLocalizations appLocalizations) {
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
              onTap: () => sort(sort: Sort.descending),
            ),
            const Divider(),
            ListTile(
              title: Text(
                appLocalizations.ascendingOrder,
                style: const TextStyle(fontSize: 16.0),
              ),
              onTap: () => sort(sort: Sort.ascending),
            ),
          ],
        ),
      ),
    );
  }

  void sort({required Sort sort}) {
    final cubit = context.read<InvoiceCubit>();
    cubit.applyFilters(sort: sort);
    cubit.fetch(context);
    Navigator.pop(context);
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
              const Expanded(child: Material()),
              Expanded(
                child: _buildStatus(appLocalizations),
              ),
            ]),
            const Divider(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  const VerticalDivider(),
                  Text.rich(
                    TextSpan(children: [
                      if (invoice.lastDate != null)
                        TextSpan(text: appLocalizations.transferDate),
                      const TextSpan(text: ': '),
                      TextSpan(
                        text: DateFormat.yMMMd()
                            .add_jm()
                            .format(invoice.lastDate!),
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
            ),
            8.emptyHeight,
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(children: [
                      if (invoice.lastDate != null)
                        TextSpan(text: appLocalizations.price),
                      const TextSpan(text: ': '),
                      TextSpan(
                        text: NumberFormat.currency(
                          decimalDigits: 0,
                          name: appLocalizations.sar,
                        ).format(invoice.amount),
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
                  const VerticalDivider(),
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
                  const VerticalDivider(),
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
