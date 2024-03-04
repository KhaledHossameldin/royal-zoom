import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../localization/localizor.dart';
import '../../../../utilities/extensions.dart';

class AmountToPayWidget extends StatefulWidget {
  const AmountToPayWidget({super.key, required this.onChooseAmount});
  final Function(num amount) onChooseAmount;

  @override
  State<AmountToPayWidget> createState() => AmountToPayWidgetState();
}

class AmountToPayWidgetState extends State<AmountToPayWidget> {
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _amountController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.width)),
            ),
            fillColor: Colors.transparent,
            suffix: Text(Localizor.translator.sarShort),
            suffixStyle: const TextStyle(color: BrandColors.orange),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (value) {
            Logger().d(value);
            widget.onChooseAmount(num.parse(value));
          },
        ),
        12.emptyHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAmountItem(50),
            _buildAmountItem(100),
            _buildAmountItem(150),
            _buildAmountItem(500),
          ],
        )
      ],
    );
  }

  Widget _buildAmountItem(num amount) {
    return InkWell(
      onTap: () {
        _amountController.setText(amount.toString());
        widget.onChooseAmount(amount);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11.width, vertical: 6.height),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.width,
            color: BrandColors.gray,
          ),
          borderRadius: BorderRadius.circular(10.width),
        ),
        child: Text('$amount ${Localizor.translator.sarShort}'),
      ),
    );
  }
}
