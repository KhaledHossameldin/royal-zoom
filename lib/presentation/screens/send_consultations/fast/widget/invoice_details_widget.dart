import 'package:flutter/material.dart';

import '../../../../../core/constants/app_style.dart';

class InvoiceDetailsWidget extends StatelessWidget {
  const InvoiceDetailsWidget(this.title, this.amount, this.color,
      {this.isBold = false, super.key});
  final String title;
  final num amount;
  final Color color;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyle.titleStyle.copyWith(
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
        Text(
          '$amount ر.س',
          style: AppStyle.titleStyle.copyWith(
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
