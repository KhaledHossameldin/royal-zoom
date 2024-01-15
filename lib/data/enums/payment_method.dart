enum PaymentMethod { wallet, visa, mastercard }

extension PaymentMethodExtension on PaymentMethod {
  int toMap() {
    if (this == PaymentMethod.wallet) {
      return 1;
    }
    if (this == PaymentMethod.visa) {
      return 2;
    }
    return 3;
  }
}

extension PaymentMethodInt on int {
  PaymentMethod paymentMethodFromMap() {
    if (this == 1) {
      return PaymentMethod.wallet;
    }
    if (this == 2) {
      return PaymentMethod.visa;
    }
    return PaymentMethod.mastercard;
  }
}
