import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/numbers.dart';
import '../../../../constants/routes.dart';
import '../../../../data/models/consultant.dart';
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
                      12.emptyHeight,
                      const _StatusRow(),
                      16.emptyHeight,
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
                initialRating: Random().nextInt(5).toDouble(),
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
        _buildItem(textTheme, 'consultations_count', Random().nextInt(1000000)),
        _buildItem(textTheme, 'likes', Random().nextInt(1000000)),
        _buildItem(textTheme, 'views', Random().nextInt(1000000)),
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

class _Header extends StatelessWidget {
  const _Header({required this.consultant});

  final Consultant consultant;

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

  Column _buildFourthRow(
    AppLocalizations appLocalizations,
    TextTheme textTheme,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${appLocalizations.speaks} :',
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                WidgetSpan(child: SizedBox(width: 15.width)),
                TextSpan(
                  text: 'الانكليزية',
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          5.emptyHeight,
          Text(
            '${appLocalizations.getMajor(false)} :',
            style: textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade800,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'قضايا الاعتداء الجسدي, قضايا الاعتداء المالي , قضايا الاعتداء الجسدي قضايا الاعتداء المالي',
            style: textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade800,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      );

  Row _buildThirdRow(AppLocalizations appLocalizations, TextTheme textTheme) =>
      Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${appLocalizations.speaks} :',
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                WidgetSpan(child: SizedBox(width: 15.width)),
                TextSpan(
                  text: ' العربية',
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
          RatingBar(
            itemSize: 15.0,
            initialRating: Random().nextInt(5).toDouble(),
            ignoreGestures: true,
            ratingWidget: RatingWidget(
              half: const Material(),
              full: const Icon(Icons.star, color: Colors.amber),
              empty: Icon(
                Icons.star,
                color: Colors.amber.withOpacity(0.4),
              ),
            ),
            onRatingUpdate: (value) {},
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
