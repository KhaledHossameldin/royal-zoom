import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/numbers.dart';
import '../../../../constants/routes.dart';
import '../../../blocs/authentication/authentication_bloc.dart';
import '../../../constants/fonts.dart';
import '../../../cubits/show_consultant/show_consultant_cubit.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/countries.dart';
import '../../../../utilities/extensions.dart';
import '../../../data/models/consultants/details.dart';
import '../../../data/models/consultations/consultation.dart';
import '../../widgets/brand_back_button.dart';
import '../../widgets/reload_widget.dart';

class ConsultantDetailsScreen extends StatefulWidget {
  const ConsultantDetailsScreen({super.key, required this.username});

  final String username;

  @override
  State<ConsultantDetailsScreen> createState() =>
      _ConsultantDetailsScreenState();
}

class _ConsultantDetailsScreenState extends State<ConsultantDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  VideoPlayerController? _videoController;

  final _consultantAppBar = ValueNotifier<Map<String, Object>?>(null);

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    context.read<ShowConsultantCubit>().fetch(
          context,
          username: widget.username,
        );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _consultantAppBar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().user;
    final appLocalizations = AppLocalizations.of(context);
    final bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kTextTabBarHeight),
        child: ValueListenableBuilder(
          valueListenable: _consultantAppBar,
          builder: (context, value, child) {
            if (value == null) {
              return AppBar(leading: const BrandBackButton());
            }
            return AppBar(
              leading: const BrandBackButton(),
              title: Text(value['name'].toString()),
              actions: [
                if (user != null)
                  IconButton(
                    onPressed: () {},
                    icon: 'heart'.svg,
                    tooltip: appLocalizations.like,
                  ),
                IconButton(
                  onPressed: () => Share.share(
                    'https://royake.wide-techno.com/consultants/${widget.username}',
                  ),
                  icon: 'share'.svg,
                  tooltip: appLocalizations.share,
                ),
                if (user != null)
                  IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      Routes.consultantReport,
                    ),
                    icon: 'report'.svg,
                    tooltip: appLocalizations.report,
                  ),
              ],
            );
          },
        ),
      ),
      body: BlocConsumer<ShowConsultantCubit, ShowConsultantState>(
        listener: (context, state) {
          if (state is ShowConsultantLoaded) {
            _consultantAppBar.value = {
              'id': state.consultant.id,
              'name': state.consultant.previewName ?? appLocalizations.none,
            };
            if (state.consultant.video != null) {
              try {
                _videoController = VideoPlayerController.networkUrl(
                    Uri.parse(state.consultant.video!.video))
                  ..initialize().then((value) => setState(() {}))
                  ..setVolume(0.0)
                  ..play();
              } catch (e) {
                _videoController = null;
              }
            }
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ShowConsultantLoading:
              return const Center(child: CircularProgressIndicator());

            case ShowConsultantLoaded:
              final consultant = (state as ShowConsultantLoaded).consultant;
              return NestedScrollView(
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
                              _Header(consultant: consultant),
                              8.emptyHeight,
                              // const _SocialRow(),
                              // const _StatusRow(),
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
                              if (state.consultant.video != null &&
                                  _videoController != null)
                                StatefulBuilder(
                                  builder: (context, setState) =>
                                      GestureDetector(
                                    onTap: () {
                                      if (_videoController!.value.isPlaying) {
                                        _videoController!.pause();
                                      } else {
                                        _videoController!.play();
                                      }
                                      setState(() {});
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 163.height,
                                      child: Stack(
                                        children: [
                                          VideoPlayer(_videoController!),
                                          if (!_videoController!
                                              .value.isPlaying)
                                            Center(
                                              child: FloatingActionButton(
                                                onPressed: null,
                                                elevation: 0,
                                                heroTag: 'play-video-tag',
                                                backgroundColor: Colors.black
                                                    .withOpacity(0.5),
                                                child: const Icon(
                                                    Icons.play_arrow_rounded),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (consultant.settings != null &&
                                  consultant.settings!.shortBrief != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      19.emptyHeight,
                                      _AbstractRow(
                                        consultant.settings!.shortBrief!,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          _HeaderImage(consultant: consultant),
                        ],
                      ),
                    ),
                  ),
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
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
                  children: [
                    _BiographyTab(consultant),
                    _PublishedConsultations(consultant.consultations),
                  ],
                ),
              );

            case ShowConsultantError:
              return ReloadWidget(
                title: (state as ShowConsultantError).message,
                buttonText: appLocalizations.getReload(''),
                onPressed: () => context
                    .read<ShowConsultantCubit>()
                    .fetch(context, username: widget.username),
              );

            default:
              return const Material();
          }
        },
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
  const _PublishedConsultations(this.consultations);

  final List<Consultation> consultations;

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
              title: Text(consultations[index].major.name),
              subtitle: RichText(
                text: TextSpan(
                  children: [
                    // TextSpan(
                    //   text: 'جنايات',
                    //   style: textTheme.labelSmall!.copyWith(
                    //     color: BrandColors.orange,
                    //   ),
                    // ),
                    if (consultations[index].appointmentDate != null)
                      TextSpan(
                        text:
                            ' | ${DateFormat('dd/MM/yyyy').add_jms().format(consultations[index].appointmentDate!)}',
                        style: textTheme.labelSmall!.copyWith(
                          color: BrandColors.mediumGray,
                        ),
                      ),
                  ],
                ),
              ),
              // trailing: RatingBar(
              //   itemSize: 15.0,
              //   initialRating: 4,
              //   ignoreGestures: true,
              //   ratingWidget: RatingWidget(
              //     half: const Material(),
              //     full: const Icon(Icons.star, color: Colors.amber),
              //     empty: const Icon(Icons.star, color: Colors.grey),
              //   ),
              //   onRatingUpdate: (value) {},
              // ),
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: Text(
                consultations[index].content,
                style: textTheme.bodySmall!.copyWith(
                  color: BrandColors.darkGray,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => 10.emptyHeight,
      itemCount: consultations.length,
    );
  }
}

class _BiographyTab extends StatelessWidget {
  const _BiographyTab(this.consultant);

  final ConsultantDetails consultant;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
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
          if (consultant.qualifications.isNotEmpty)
            Column(
              children: [
                _BiographyItem(
                  title: appLocalizations.qualifications,
                  child: Column(
                      children: consultant.qualifications
                          .map((e) => SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.name,
                                      style: textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      e.organization,
                                      style: textTheme.labelSmall!.copyWith(
                                        color: BrandColors.mediumGray,
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '${e.year} - ',
                                            style:
                                                textTheme.labelSmall!.copyWith(
                                              color: BrandColors.darkGray,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${e.degree}%',
                                            style:
                                                textTheme.labelSmall!.copyWith(
                                              color: BrandColors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList()),
                ),
                const Divider(),
              ],
            ),
          if (consultant.experiences.isNotEmpty)
            Column(
              children: [
                _BiographyItem(
                  title: appLocalizations.experiences,
                  child: Column(
                    children: consultant.experiences
                        .map((e) => SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name,
                                    style: textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    e.organization,
                                    style: textTheme.labelSmall!.copyWith(
                                      color: BrandColors.mediumGray,
                                    ),
                                  ),
                                  Text(
                                    '${DateFormat('MM/yyyy').format(e.startDate)} - ${DateFormat('MM/yyyy').format(e.endDate)}',
                                    style: textTheme.labelSmall!.copyWith(
                                      color: BrandColors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
              ],
            ),
          if (consultant.courses.isNotEmpty)
            Column(
              children: [
                _BiographyItem(
                  title: appLocalizations.courses,
                  child: Column(
                    children: consultant.courses
                        .map((e) => SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  12.emptyHeight,
                                  Text(
                                    e.name,
                                    style: textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    e.organization,
                                    style: textTheme.labelSmall!.copyWith(
                                      color: BrandColors.mediumGray,
                                    ),
                                  ),
                                  Text(
                                    '${e.hours} ${appLocalizations.hour}',
                                    style: textTheme.labelSmall!.copyWith(
                                      color: BrandColors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
              ],
            ),
          if (consultant.skills.isNotEmpty)
            Column(
              children: [
                _BiographyItem(
                  title: appLocalizations.skills,
                  child: Column(
                    children: consultant.skills
                        .map((e) => SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name,
                                    style: textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    appLocalizations.getLevel(e.level),
                                    style: textTheme.labelSmall!.copyWith(
                                      color: BrandColors.mediumGray,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
              ],
            ),
          if (consultant.projects.isNotEmpty)
            Column(
              children: [
                _BiographyItem(
                  title: appLocalizations.projects,
                  child: Column(
                    children: consultant.projects
                        .map((e) => SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name,
                                    style: textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    e.organization,
                                    style: textTheme.labelSmall!.copyWith(
                                      color: BrandColors.mediumGray,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
              ],
            ),
          if (consultant.researches.isNotEmpty)
            Column(
              children: [
                _BiographyItem(
                  title: appLocalizations.researches,
                  child: Column(
                    children: consultant.researches
                        .map((e) => SizedBox(
                              width: double.infinity,
                              child: Text(
                                e.name,
                                style: textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
              ],
            ),
          if (consultant.patents.isNotEmpty)
            Column(
              children: [
                _BiographyItem(
                  title: appLocalizations.patents,
                  child: Column(
                    children: consultant.patents
                        .map((e) => SizedBox(
                              width: double.infinity,
                              child: Text(
                                e.name,
                                style: textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
              ],
            ),
          if (consultant.languages.isNotEmpty)
            Column(
              children: [
                _BiographyItem(
                  title: appLocalizations.languages,
                  child: Column(
                    children: consultant.languages
                        .map((e) => SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name,
                                    style: textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    appLocalizations.getLevel(e.level),
                                    style: textTheme.labelSmall!.copyWith(
                                      color: BrandColors.mediumGray,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
              ],
            ),
          if (consultant.activities.isNotEmpty)
            Column(
              children: [
                _BiographyItem(
                  title: appLocalizations.activities,
                  child: Column(
                    children: consultant.activities
                        .map((e) => SizedBox(
                              width: double.infinity,
                              child: Text(
                                e.name,
                                style: textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
              ],
            ),
          if (consultant.certificates.isNotEmpty)
            Column(
              children: [
                _BiographyItem(
                  title: appLocalizations.certificates,
                  child: Column(
                    children: consultant.certificates
                        .map((e) => SizedBox(
                              width: double.infinity,
                              child: Text(
                                e.name,
                                style: textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
              ],
            ),
          if (consultant.volunteering.isNotEmpty)
            _BiographyItem(
              title: appLocalizations.volunteering,
              child: Column(
                children: consultant.volunteering
                    .map((e) => SizedBox(
                          width: double.infinity,
                          child: Text(
                            e.name,
                            style: textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _BiographyItem extends StatelessWidget {
  const _BiographyItem({required this.title, this.child});

  final String title;
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
  const _AbstractRow(this.shortBirief);

  final String shortBirief;

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
          shortBirief,
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

  final ConsultantDetails consultant;

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

  final ConsultantDetails consultant;
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
          final majors = Padding(
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
              if (consultant.major != null && consultant.majors != null)
                Column(
                  children: consultant.majors!
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
          Builder(builder: (context) {
            int sum = 0;
            return RichText(
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
                    // text: ' ٥',
                    text: consultant.experiences
                        .fold(
                            sum,
                            (previousValue, element) => sum += element.endDate
                                    .difference(element.startDate)
                                    .inDays ~/
                                365)
                        .toString(),
                    style: textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }),
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
                TextSpan(
                  text: consultant.ratingAverage!.toStringAsFixed(1),
                ),
                WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    child: ShaderMask(
                      blendMode: BlendMode.srcATop,
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          stops: [
                            0,
                            (consultant.ratingAverage! / 5).toDouble(),
                            (consultant.ratingAverage! / 5).toDouble(),
                          ],
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
