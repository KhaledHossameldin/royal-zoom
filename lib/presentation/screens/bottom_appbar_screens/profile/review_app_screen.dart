import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/app_bar_logo.dart';
import '../../../widgets/brand_back_button.dart';

class ReviewAppScreen extends StatefulWidget {
  const ReviewAppScreen({super.key});

  @override
  State<ReviewAppScreen> createState() => _ReviewAppScreenState();
}

class _ReviewAppScreenState extends State<ReviewAppScreen> {
  final _controller = TextEditingController();

  int _rate = 5;
  bool _showName = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final bottom = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      appBar: AppBar(
        leading: const BrandBackButton(),
        title: Text(appLocalizations.reviewApplication),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(27.width, 52.height, 27.width, bottom),
            sliver: SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppBarLogo(padding: 140.width),
                  Text(
                    appLocalizations.appReviewTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26.0,
                      color: BrandColors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => Column(
                      children: [
                        Text(
                          appLocalizations.getRate(_rate),
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        10.emptyHeight,
                        RatingBar(
                          glow: false,
                          minRating: 1,
                          initialRating: 5,
                          updateOnDrag: true,
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star_rounded,
                                color: Colors.amber),
                            half: const Material(),
                            empty: Icon(
                              Icons.star_rounded,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          onRatingUpdate: (value) => setState(
                            () => _rate = value.toInt(),
                          ),
                        ),
                        10.emptyHeight,
                        Text(
                          '($_rate/5)',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocalizations.comment,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: BrandColors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextField(
                        maxLines: 3,
                        style: const TextStyle(fontSize: 16.0),
                        textInputAction: TextInputAction.newline,
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          hintText: appLocalizations.writeComment,
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => SwitchListTile.adaptive(
                      title: Text(
                        appLocalizations.showName,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      value: _showName,
                      onChanged: (value) => setState(() => _showName = value),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: Text(appLocalizations.send),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
