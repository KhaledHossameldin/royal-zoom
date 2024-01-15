part of 'invoice_cubit.dart';

@immutable
class InvoiceState {
  const InvoiceState();
}

class InvoiceInitial extends InvoiceState {
  const InvoiceInitial();
}

class InvoiceLoading extends InvoiceState {
  const InvoiceLoading();
}

class InvoiceLoaded extends InvoiceState {
  final List<Invoice> invoices;
  final int statistics;
  const InvoiceLoaded({
    required this.invoices,
    required this.statistics,
  });
}

class InvoiceError extends InvoiceState {
  final String message;
  const InvoiceError(this.message);
}
