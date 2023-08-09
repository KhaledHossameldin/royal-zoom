import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/brand_colors.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.notifications)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 11.height,
          horizontal: 14.width,
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 11.height,
              horizontal: 14.width,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: BrandColors.orange),
                    ),
                    child: Container(
                      width: 46.width,
                      height: 46.height,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: 'royake'.png.image,
                          // image: consultant.image.isNotEmpty
                          //     ? NetworkImage(consultant.image)
                          //     : 'royake'.png.image,
                        ),
                      ),
                    ),
                  ),
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('name', style: TextStyle(fontSize: 14.0)),
                      Text('id', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'major',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: BrandColors.gray,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy')
                            .add_jms()
                            .format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: BrandColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 11.height,
                    horizontal: 14.width,
                  ),
                  decoration: BoxDecoration(
                    color: BrandColors.snowWhite,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'و سأعرض مثال حي لهذا، من منا لم يتحمل جهد بدني شاق إلا من أجل الحصول على ميزة أو فائدة؟ ولكن من لديه الحق أن ينتقد شخص ما أراد أن يشعر بالسعادة التي لا تشوبها عواقب أليمة أو آخر أراد أن يتجنب الألم الذي ربما تنجم عنه بعض المتعة ؟ … علي الجانب الآخر نشجب ونستنكر هؤلاء الرجال المفتونون',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: BrandColors.darkBlackGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.only(
          left: 34.width,
          right: 34.width,
          top: 24.height,
        ),
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: 'chat'.buildSVG(
            color: Colors.white,
            blendMode: BlendMode.srcATop,
          ),
          label: Text(appLocalizations.goToChat),
        ),
      ),
    );
  }
}
