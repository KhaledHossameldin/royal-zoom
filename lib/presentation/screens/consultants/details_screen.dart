import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:share_plus/share_plus.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/numbers.dart';
import '../../../../constants/routes.dart';
import '../../../constants/fonts.dart';
import '../../../data/models/consultants/consultant.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/countries.dart';
import '../../../../utilities/extensions.dart';
import '../../widgets/brand_back_button.dart';

class ConsultantDetailsScreen extends StatefulWidget {
  const ConsultantDetailsScreen({super.key, required this.consultant});

  final Consultant consultant;

  @override
  State<ConsultantDetailsScreen> createState() =>
      _ConsultantDetailsScreenState();
}

class _ConsultantDetailsScreenState extends State<ConsultantDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      appBar: AppBar(
        leading: const BrandBackButton(),
        title: Text(appLocalizations.consultantDetails),
        actions: [
          IconButton(
            onPressed: () {},
            icon: 'heart'.svg,
            tooltip: appLocalizations.like,
          ),
          IconButton(
            onPressed: () => Share.share(
              widget.consultant.previewName ?? appLocalizations.none,
            ),
            icon: 'share'.svg,
            tooltip: appLocalizations.share,
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              Routes.consultantReport,
            ),
            icon: 'report'.svg,
            tooltip: appLocalizations.report,
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              27.width,
              81.height,
              27.width,
              bottomViewPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      _Header(consultant: widget.consultant),
                      8.emptyHeight,
                      const _SocialRow(),
                      const _StatusRow(),
                      MaterialButton(
                        onPressed: () {},
                        minWidth: double.infinity,
                        textColor: Colors.white,
                        shape: const StadiumBorder(),
                        color: BrandColors.orange,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            'consultant_times'.svg,
                            5.emptyWidth,
                            Text(appLocalizations.consultantTimes),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        minWidth: double.infinity,
                        textColor: Colors.white,
                        shape: const StadiumBorder(),
                        color: BrandColors.darkGreen,
                        child: Text(appLocalizations.consult),
                      ),
                      16.emptyHeight,
                      Placeholder(fallbackHeight: 163.height),
                      19.emptyHeight,
                      const _AbstractRow(),
                    ],
                  ),
                  _HeaderImage(consultant: widget.consultant),
                ],
              ),
            ),
          ),
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 27.width),
              sliver: SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: _StickyTabBar(appLocalizations, _controller),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _controller,
          children: const [_BiographyTab(), _PublishedConsultations()],
        ),
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  @override
  Widget build(BuildContext context) => Card(
        elevation: 0.0,
        color: Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: 'linkedin'.svg,
            ),
            IconButton(
              onPressed: () {},
              icon: 'twitter'.svg,
            ),
            IconButton(
              onPressed: () {},
              icon: 'facebook'.svg,
            ),
            IconButton(
              onPressed: () {},
              icon: 'instagram'.svg,
            ),
            IconButton(
              onPressed: () {},
              icon: 'whatsapp'.svg,
            ),
            IconButton(
              onPressed: () {},
              icon: 'youtube'.svg,
            ),
          ],
        ),
      );
}

class _PublishedConsultations extends StatelessWidget {
  const _PublishedConsultations();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView.separated(
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 27.height),
        padding: EdgeInsets.symmetric(
          vertical: 10.height,
          horizontal: 15.width,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey, width: 1.0),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: BrandColors.darkGreen,
                backgroundImage: 'royake'.png.image,
              ),
              title: const Text('قانون'),
              subtitle: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'جنايات',
                      style: textTheme.labelSmall!.copyWith(
                        color: BrandColors.orange,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' | ${DateFormat('dd/MM/yyyy').add_jms().format(DateTime.now())}',
                      style: textTheme.labelSmall!.copyWith(
                        color: BrandColors.mediumGray,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: RatingBar(
                itemSize: 15.0,
                initialRating: 4,
                ignoreGestures: true,
                ratingWidget: RatingWidget(
                  half: const Material(),
                  full: const Icon(Icons.star, color: Colors.amber),
                  empty: const Icon(Icons.star, color: Colors.grey),
                ),
                onRatingUpdate: (value) {},
              ),
            ),
            const Divider(),
            Text(
              'و سأعرض مثال حي لهذا، من منا لم يتحمل جهد بدني شاق إلا من أجل الحصول على ميزة أو فائدة؟ ولكن من لديه الحق أن ينتقد شخص ما أراد أن يشعر بالسعادة التي لا تشوبها عواقب أليمة أو آخر أراد أن يتجنب الألم الذي ربما تنجم عنه بعض المتعة ؟ علي الجانب الآخر نشجب ونستنكر هؤلاء الرجال المفتونون بنشوة اللحظة الهائمون في رغباتهم فلا يدركون ما يعقبها من الألم والأسي المحتم، واللوم كذلك يشمل هؤلاء الذين أخفقوا في واجباتهم نتيجة لضعف إرادتهم فيتساوي مع هؤلاء الذين يتجنبون وينأون عن تحمل الكدح والألم.',
              style: textTheme.bodySmall!.copyWith(
                color: BrandColors.darkGray,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => 10.emptyHeight,
      itemCount: 5,
    );
  }
}

class _BiographyTab extends StatelessWidget {
  const _BiographyTab();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 30.width,
        right: 30.width,
        bottom: bottomViewPadding,
      ),
      child: Column(
        children: [
          _BiographyItem(
            title: 'المؤهلات',
            subtitle: 'بكالوريوس إدارة الأعمال',
            text: 'جامعة الملك فهد',
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '2016 - ',
                    style: textTheme.labelSmall!.copyWith(
                      color: BrandColors.darkGray,
                    ),
                  ),
                  TextSpan(
                    text: '85%',
                    style: textTheme.labelSmall!.copyWith(
                      color: BrandColors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          _BiographyItem(
            title: 'الخبرات',
            subtitle: 'المدير المالي',
            text: 'بيبسيكو للمواد الغذائية',
            child: Text(
              '02/2022 - 09/2020',
              style: textTheme.labelSmall!.copyWith(
                color: BrandColors.orange,
              ),
            ),
          ),
          const Divider(),
          _BiographyItem(
            title: 'الدورات التي حصلت عليها',
            subtitle: 'إدارة المشاريع',
            text: 'Google',
            child: Text(
              '٣٥ ساعة',
              style: textTheme.labelSmall!.copyWith(
                color: BrandColors.orange,
              ),
            ),
          ),
          const Divider(),
          _BiographyItem(
            title: 'المهارات',
            subtitle: 'Microsoft Office',
            child: Text(
              'متقدم',
              style: textTheme.labelSmall!.copyWith(
                color: Colors.green,
              ),
            ),
          ),
          const Divider(),
          _BiographyItem(
            title: 'المشاريع',
            subtitle: 'مشروع إنشاء مركز حسابات',
            text: 'مؤسسة رؤياك',
            child: Text(
              '٣٥ ساعة',
              style: textTheme.labelSmall!.copyWith(
                color: BrandColors.orange,
              ),
            ),
          ),
          const Divider(),
          const _BiographyItem(
            title: 'المؤلفات والبحوث',
            subtitle: 'اسم المؤلف أو البحث',
          ),
          const Divider(),
          const _BiographyItem(
            title: 'براءات الاختراع',
            subtitle: 'اسم براءة الاختراع',
          ),
          const Divider(),
          const _BiographyItem(
            title: 'المشاركات',
            subtitle: 'اسم المشاركة',
          ),
          const Divider(),
          _BiographyItem(
            title: 'دورات قدمها',
            subtitle: 'اسم الدورة',
            child: Text(
              '٥٦ ساعة',
              style: textTheme.labelSmall!.copyWith(
                color: BrandColors.orange,
              ),
            ),
          ),
          const Divider(),
          const _BiographyItem(
            title: 'شهادات الشكر والتقدير',
            subtitle: 'اسم شهادات الشكر والتقدير',
          ),
          const Divider(),
          const _BiographyItem(title: 'التطوع', subtitle: 'اسم التطوع'),
        ],
      ),
    );
  }
}

class _BiographyItem extends StatelessWidget {
  const _BiographyItem({
    required this.title,
    required this.subtitle,
    this.text,
    this.child,
  });

  final String title;
  final String subtitle;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.bodyMedium!.copyWith(
              color: BrandColors.black,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 5.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                if (text != null)
                  Text(
                    text!,
                    style: textTheme.labelSmall!.copyWith(
                      color: BrandColors.mediumGray,
                    ),
                  ),
                if (child != null) child!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AbstractRow extends StatelessWidget {
  const _AbstractRow();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(child: SizedBox(width: 7.width)),
              WidgetSpan(child: 'info'.svg),
              TextSpan(
                text: appLocalizations.abstract,
                style: textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        10.emptyHeight,
        Text(
          'و سأعرض مثال حي لهذا، من منا لم يتحمل جهد بدني شاق إلا من أجل الحصول على ميزة أو فائدة؟ ولكن من لديه الحق أن ينتقد شخص ما أراد أن يشعر بالسعادة التي لا تشوبها عواقب أليمة أو آخر أراد أن يتجنب الألم الذي ربما تنجم عنه بعض المتعة ؟ علي الجانب الآخر نشجب ونستنكر هؤلاء الرجال المفتونون بنشوة اللحظة الهائمون في رغباتهم فلا يدركون ما يعقبها من الألم والأسي المحتم، واللوم كذلك يشمل هؤلاء الذين أخفقوا في واجباتهم نتيجة لضعف إرادتهم فيتساوي مع هؤلاء الذين يتجنبون وينأون عن تحمل الكدح والألم . من المفترض أن نفرق بين هذه الحالات بكل سهولة ومرونة. في ذاك الوقت عندما تكون قدرتنا علي الاختيار غير مقيدة بشرط وعندما لا نجد ما يمنعنا أن نفعل الأفضل فها نحن نرحب بالسرور والسعادة ونتجنب كل ما يبعث إلينا الألم. في بعض الأحيان ونظراً للالتزامات التي يفرضها علينا الواجب والعمل سنتنازل غالباً ونرفض الشعور بالسرور ونقبل ما يجلبه إلينا الأسى. الإنسان الحكيم عليه أن يمسك زمام الأمور ويختار إما أن يرفض مصادر السعادة من أجل ما هو أكثر أهمية أو يتحمل الألم من أجل ألا يتحمل ما هو أسوأ.',
          style: textTheme.labelSmall!.copyWith(
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        _buildItem(textTheme, 'consultations_count', 1234567),
        _buildItem(textTheme, 'likes', 1234567),
        _buildItem(textTheme, 'views', 1234567),
      ],
    );
  }

  Expanded _buildItem(TextTheme textTheme, String image, int count) => Expanded(
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 9.width,
              horizontal: 9.width,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image.png,
                7.emptyWidth,
                Text(
                  NumberFormat.compact().format(count),
                  style: textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _HeaderImage extends StatelessWidget {
  const _HeaderImage({required this.consultant});

  final Consultant consultant;

  @override
  Widget build(BuildContext context) => Positioned(
        left: 0,
        right: 0,
        top: -66,
        child: Container(
          width: 112.width,
          height: 112.height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: consultant.image.isNotEmpty
                  ? NetworkImage(consultant.image)
                  : 'royake'.png.image,
            ),
          ),
        ),
      );
}

// ignore: must_be_immutable
class _Header extends StatelessWidget {
  _Header({required this.consultant});

  final Consultant consultant;
  bool _isShowPrices = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.height,
          horizontal: 10.width,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFirstRow(appLocalizations, textTheme),
            7.emptyHeight,
            _buildSecondRow(appLocalizations, textTheme),
            10.emptyHeight,
            _buildThirdRow(appLocalizations, textTheme),
            8.emptyHeight,
            _buildFourthRow(appLocalizations, textTheme),
          ],
        ),
      ),
    );
  }

  StatefulBuilder _buildFourthRow(
    AppLocalizations appLocalizations,
    TextTheme textTheme,
  ) =>
      StatefulBuilder(
        builder: (context, setState) {
          final majors = RichText(
            text: TextSpan(
              style: textTheme.bodySmall!.copyWith(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.normal,
              ),
              children: [
                TextSpan(
                  text:
                      '${appLocalizations.getMajor(false)} :\nقضايا الاعتداء الجسدي, قضايا الاعتداء المالي , قضايا الاعتداء الجسدي قضايا الاعتداء المالي',
                ),
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.width),
                    child: MaterialButton(
                      onPressed: () => setState(() => _isShowPrices = true),
                      elevation: 0.0,
                      height: 23.height,
                      highlightElevation: 0.0,
                      shape: const StadiumBorder(),
                      textColor: BrandColors.orange,
                      color: BrandColors.orange.withOpacity(0.2),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text(
                        appLocalizations.showPrices,
                        style: const TextStyle(fontSize: 10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
          final prices = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: TextButton.icon(
                  onPressed: () => setState(() => _isShowPrices = false),
                  icon: const Icon(Icons.expand_less, size: 20.0),
                  label: Text(
                    appLocalizations.majorPricePerHour,
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Column(
                children: consultant.majors
                    .map((e) => RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${e.terms} :',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: BrandColors.black,
                                  fontFamily: Fonts.main,
                                ),
                              ),
                              TextSpan(
                                text: ' ${e.pricePerHour.round()} ',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: BrandColors.orange,
                                  fontFamily: Fonts.main,
                                ),
                              ),
                              TextSpan(
                                text: appLocalizations.sarH,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: BrandColors.black,
                                  fontFamily: Fonts.main,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          );
          return AnimatedCrossFade(
            firstChild: majors,
            secondChild: prices,
            duration: kTabScrollDuration,
            alignment: AlignmentDirectional.topStart,
            crossFadeState: _isShowPrices
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          );
        },
      );

  Row _buildThirdRow(AppLocalizations appLocalizations, TextTheme textTheme) =>
      Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${appLocalizations.answerDuration} :',
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                WidgetSpan(child: SizedBox(width: 15.width)),
                TextSpan(
                  text: ' ساعة ونصف',
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${appLocalizations.experienceYears} :',
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                WidgetSpan(child: SizedBox(width: 15.width)),
                TextSpan(
                  text: ' ٥',
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Align _buildSecondRow(
    AppLocalizations appLocalizations,
    TextTheme textTheme,
  ) =>
      Align(
        alignment: Alignment.center,
        child: Wrap(
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              consultant.previewName ?? appLocalizations.none,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Builder(
              builder: (context) {
                if (consultant.country == null) {
                  return const Material();
                }
                final country = countries.firstWhere((element) =>
                    element.dialCode == consultant.country!.dialCode);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.width),
                  child: Text(country.flag),
                );
              },
            ),
          ],
        ),
      );

  Row _buildFirstRow(AppLocalizations appLocalizations, TextTheme textTheme) =>
      Row(
        children: [
          SizedBox(
            width: 120.width,
            child: Text(
              consultant.previewName ?? appLocalizations.none,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall!.copyWith(
                fontSize: 13.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const Spacer(),
          RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 11.0,
                color: Colors.grey,
                fontFamily: Fonts.main,
              ),
              children: [
                TextSpan(text: (0.78 * 10).toStringAsFixed(1)),
                WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    child: ShaderMask(
                      blendMode: BlendMode.srcATop,
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          stops: const [0, 0.78, 0.78],
                          colors: [
                            Colors.amber,
                            Colors.amber,
                            Colors.amber.withOpacity(0),
                          ],
                        ).createShader(bounds);
                      },
                      child: SizedBox(
                        width: 20.width,
                        height: 20.height,
                        child: Icon(
                          Icons.star,
                          size: 20.width,
                          color: Colors.grey[300],
                        ),
                      ),
                    )),
                TextSpan(text: '465 ${appLocalizations.review}'),
              ],
            ),
          ),
        ],
      );
}

class _StickyTabBar extends SliverPersistentHeaderDelegate {
  _StickyTabBar(this.appLocalizations, this.controller);

  final AppLocalizations appLocalizations;
  final TabController controller;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16.height),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TabBar(
            controller: controller,
            indicator: BoxDecoration(
              color: BrandColors.orange,
              borderRadius: BorderRadius.circular(10.0),
            ),
            tabs: [
              Tab(text: appLocalizations.biography),
              Tab(text: appLocalizations.publishedConsultations),
            ],
          ),
        ),
      );

  @override
  double get maxExtent => Numbers.consultantTabBarHeight;

  @override
  double get minExtent => Numbers.consultantTabBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
