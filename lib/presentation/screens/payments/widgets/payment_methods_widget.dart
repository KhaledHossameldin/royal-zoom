import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../utilities/extensions.dart';

class PaymentMethodsWidget extends StatefulWidget {
  const PaymentMethodsWidget({super.key, required this.onSelectedPayment});

  final Function(int paymentMethod) onSelectedPayment;

  @override
  State<PaymentMethodsWidget> createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {
  final methods = ['visa', 'master'];
  var isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: ((context, index) => 20.emptyHeight),
      itemBuilder: (context, index) => _buildItem(index),
      itemCount: 2,
    );
  }

  Widget _buildItem(int index) {
    return Card(
      color: BrandColors.lightGray,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.width,
          vertical: 16.height,
        ),
        child: ListTile(
          leading: methods[index].buildSVG(color: BrandColors.snowWhite),
          title: Text(methods[index]),
          trailing: Transform.scale(
            scale: 1.3,
            child: Radio(
              value: index,
              groupValue: isSelected,
              onChanged: (value) {
                setState(
                  () {
                    isSelected = value!;
                    widget.onSelectedPayment(isSelected);
                  },
                );
              },
            ),
          ),
          onTap: () {
            setState(
              () {
                isSelected = index;
                widget.onSelectedPayment(isSelected);
              },
            );
          },
        ),
      ),
    );
  }
}
