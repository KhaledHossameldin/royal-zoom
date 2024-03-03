import 'package:flutter/material.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../core/constants/app_style.dart';
import '../../../../../utilities/extensions.dart';

class DiscountWidget extends StatelessWidget {
  const DiscountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ادخل كود الخصم',
          style: AppStyle.smallTitleStyle,
        ),
        8.emptyHeight,
        Container(
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: BrandColors.lightGray,
          ),
          padding: EdgeInsetsDirectional.only(start: 17.width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '10%',
                style: AppStyle.defaultStyle,
              ),
              SizedBox(
                width: 107.width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text('تطبيق'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
