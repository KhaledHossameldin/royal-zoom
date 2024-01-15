enum InvoiceType { consultation, walletCharge }

extension InvoiceTypeExtension on InvoiceType {
  String get text {
    if (this == InvoiceType.consultation) {
      return 'consultation';
    }
    return 'wallet_charge';
  }
}
