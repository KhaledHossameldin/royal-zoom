import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/invoice_type.dart';
import '../../data/enums/sort.dart';
import '../../data/models/invoices/invoicable/filter.dart';
import '../../data/models/invoices/invoice.dart';
import '../../data/services/repository.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(const InvoiceInitial());

  final repository = Repository.instance;

  InvoiceFilter _filter = InvoiceFilter();

  void clear() {
    _filter.searchText = '';
    _filter.dateRange = null;
  }

  void applyFilters({
    InvoiceType? type,
    DateTimeRange? dateRange,
    String? searchText,
    Sort? sort,
  }) =>
      _filter = _filter.copyWith(
        type: type,
        dateRange: dateRange,
        searchText: searchText,
        sort: sort,
      );

  Future<void> fetch(BuildContext context, {InvoiceType? type}) async {
    try {
      applyFilters(type: type);
      emit(const InvoiceLoading());
      final values = await Future.wait([
        repository.invoices(context,
            type: type ?? _filter.type, params: _filter.toMap()),
        repository.statistics(context),
      ]);
      emit(InvoiceLoaded(
        invoices: values[0] as List<Invoice>,
        statistics: values[1] as int,
      ));
    } catch (e) {
      emit(InvoiceError('$e'));
    }
  }
}
