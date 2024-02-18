import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../utilities/extensions.dart';

class MajorTabScreen extends StatelessWidget {
  const MajorTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.width),
              side: BorderSide(
                width: 0.3.width,
                color: BrandColors.gray,
              )),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 10.width, vertical: 12.height),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('type'),
                    Text('order number'),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('date'),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 4.height, horizontal: 4.width),
                      decoration: BoxDecoration(
                          color: BrandColors.snowWhite,
                          borderRadius: BorderRadius.circular(5.width)),
                      child: const Text(
                        'status',
                        style: TextStyle(color: BrandColors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => 8.emptyHeight,
      itemCount: 3,
    );
  }
}
