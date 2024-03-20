import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../cubits/home/home_cubit.dart';
import '../../../../data/enums/consultation_content_type.dart';
import '../../../../data/models/consultations/consultation.dart';
import '../../../../data/models/home_statistics.dart';
import '../../../../data/services/repository.dart';
import '../../../../data/sources/local/shared_prefs.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/notifications_button.dart';
import '../../../widgets/reload_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.index});

  final ValueNotifier<int> index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _favoriteConsultationId = ValueNotifier<int?>(null);

  @override
  void initState() {
    context.read<HomeCubit>().fetch(context);
    super.initState();
  }

  @override
  void dispose() {
    _favoriteConsultationId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = DIManager.findDep<SharedPrefs>().getUser()!;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: BrandColors.snowWhite,
            backgroundImage: user.image.isNotEmpty
                ? NetworkImage(user.image)
                : 'royake'.png.image,
          ),
          title: Text(
            user.previewName ?? appLocalizations.none,
            style: const TextStyle(fontSize: 12.0),
          ),
          subtitle: GestureDetector(
            onTap: () {},
            child: Text(
              appLocalizations.dataCompletion,
              style: const TextStyle(
                fontSize: 8.0,
                color: BrandColors.orange,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        actions: const [
          NotificationsButton(),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoading:
              return const Center(child: CircularProgressIndicator());

            case HomeLoaded:
              final statistics = (state as HomeLoaded).statistics;
              final consultations = state.consultations;
              return RefreshIndicator(
                onRefresh: () async => context.read<HomeCubit>().fetch(context),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    _GridView(appLocalizations, statistics: statistics),
                    _LatestConsultationsHeader(index: widget.index),
                    SliverToBoxAdapter(child: 24.emptyHeight),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 250.height,
                        child: ListView.separated(
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 27.width),
                          itemCount: consultations.length,
                          separatorBuilder: (context, index) => 16.emptyWidth,
                          itemBuilder: (context, index) => _ConsultationItem(
                            consultation: consultations[index],
                            favoriteConsultationId: _favoriteConsultationId,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: 24.emptyHeight),
                  ],
                ),
              );

            case HomeError:
              return ReloadWidget(
                title: (state as HomeError).message,
                buttonText: appLocalizations.getReload(''),
                onPressed: () => context.read<HomeCubit>().fetch(context),
              );

            default:
              return const Material();
          }
        },
      ),
    );
  }
}

class _ConsultationItem extends StatelessWidget {
  const _ConsultationItem({
    required this.consultation,
    required this.favoriteConsultationId,
  });

  final Consultation consultation;
  final ValueNotifier<int?> favoriteConsultationId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    if (consultation.isHideNameFromConsultants) {
      return Center(
        child: SizedBox(
          width: 330.width,
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.height,
                horizontal: 18.width,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${appLocalizations.consultationNumber}${consultation.id}',
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: BrandColors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    appLocalizations.getConsultationStatus(
                      consultation.status,
                      consultation.isHideNameFromConsultants,
                    ),
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: BrandColors.gray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: 330.width,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () => Navigator.pushNamed(
            context,
            Routes.consultationDetails,
            arguments: {
              'id': consultation.id,
              'player': consultation.audioPlayer,
            },
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.height,
              horizontal: 18.width,
            ),
            child: Builder(builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    isThreeLine: true,
                    leading: Builder(builder: (context) {
                      final consultant = consultation.consultant;
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: BrandColors.orange),
                        ),
                        child: Container(
                          width: 60.width,
                          height: 60.height,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.0),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: consultant != null &&
                                      consultant.image.isNotEmpty
                                  ? NetworkImage(consultant.image)
                                  : 'royake'.png.image,
                            ),
                          ),
                        ),
                      );
                    }),
                    title: Builder(builder: (context) {
                      final consultant = consultation.consultant;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            consultant != null && consultant.previewName != null
                                ? consultant.previewName!
                                : appLocalizations.none,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: BrandColors.darkGray,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: favoriteConsultationId,
                            builder: (context, value, child) {
                              if (value == consultation.id) {
                                return SizedBox(
                                  width: 16.width,
                                  height: 16.height,
                                  child: const CircularProgressIndicator(
                                    color: BrandColors.gray,
                                    strokeWidth: 2.0,
                                  ),
                                );
                              }
                              return GestureDetector(
                                onTap: () async {
                                  favoriteConsultationId.value =
                                      consultation.id;
                                  try {
                                    await Repository.instance
                                        .favoriteConsultation(
                                      context,
                                      id: consultation.id,
                                    );
                                    if (!context.mounted) return;
                                    BlocProvider.of<HomeCubit>(context)
                                        .toggleFavorite(consultation.id);
                                    favoriteConsultationId.value = null;
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    '$e'.showSnackbar(
                                      context,
                                      color: BrandColors.red,
                                    );
                                    favoriteConsultationId.value = null;
                                  }
                                },
                                child: Icon(consultation.isFavourite
                                    ? Icons.favorite
                                    : Icons.favorite_outline),
                              );
                            },
                          ),
                        ],
                      );
                    }),
                    subtitle: Column(
                      children: [
                        Builder(builder: (context) {
                          return SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: 8.width,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Text(
                                  consultation.appointmentDate != null
                                      ? DateFormat('d/MM/y')
                                          .add_jm()
                                          .format(consultation.appointmentDate!)
                                      : appLocalizations.none,
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  appLocalizations.getConsultationStatus(
                                    consultation.status,
                                    consultation.isHideNameFromConsultants,
                                  ),
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    color: consultation.status.color,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        Builder(builder: (context) {
                          const textStyle = TextStyle(fontSize: 11.0);
                          return SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: 8.width,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${appLocalizations.consultationNumber}${consultation.id}',
                                  style: textStyle,
                                ),
                                Text(
                                  consultation.maximumPrice != null
                                      ? appLocalizations
                                          .getConsultationPaymentStatus(
                                          consultation.maximumPrice!,
                                          consultation.isPaid,
                                        )
                                      : appLocalizations.none,
                                  style: textStyle,
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 11.height,
                      horizontal: 14.width,
                    ),
                    decoration: BoxDecoration(
                      color: BrandColors.snowWhite,
                      borderRadius: BorderRadius.circular(
                          consultation.contentType ==
                                  ConsultationContentType.text
                              ? 10.0
                              : 50.0),
                    ),
                    child: Builder(
                      builder: (context) {
                        if (consultation.contentType ==
                            ConsultationContentType.text) {
                          return Text(
                            consultation.content,
                            maxLines: 2,
                          );
                        }
                        if (consultation.audioPlayer == null) {
                          return Text(appLocalizations.cannotPlayAudio);
                        }

                        return Row(
                          children: [
                            Text(
                              consultation.audioPlayer!.duration!.audioTime,
                              style: const TextStyle(
                                fontSize: 9.0,
                                color: BrandColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.emptyWidth,
                            Expanded(
                              child: StreamBuilder(
                                stream:
                                    consultation.audioPlayer!.positionStream,
                                builder: (context, snapshot) => Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: LinearProgressIndicator(
                                    color: BrandColors.darkGreen,
                                    backgroundColor: Colors.grey,
                                    value: (snapshot.data ?? Duration.zero)
                                            .inSeconds /
                                        max(
                                            consultation.audioPlayer!.duration!
                                                .inSeconds,
                                            1),
                                  ),
                                ),
                              ),
                            ),
                            8.emptyWidth,
                            FloatingActionButton.small(
                              elevation: 0.0,
                              backgroundColor: BrandColors.darkGreen,
                              heroTag: 'id-${consultation.id}',
                              child: const Icon(Icons.play_arrow_rounded),
                              onPressed: () async {
                                await consultation.audioPlayer!
                                    .seek(Duration.zero);
                                consultation.audioPlayer!.play();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _LatestConsultationsHeader extends StatelessWidget {
  const _LatestConsultationsHeader({required this.index});

  final ValueNotifier<int> index;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 27.width),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appLocalizations.latestConsultations,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            TextButton(
              onPressed: () => index.value = 1,
              child: Row(
                children: [
                  Text(appLocalizations.viewAll),
                  const Icon(Icons.keyboard_double_arrow_left_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridView extends StatelessWidget {
  const _GridView(this.appLocalizations, {required this.statistics});

  final AppLocalizations appLocalizations;
  final HomeStatistics statistics;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 34.height,
        horizontal: 27.width,
      ),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        childAspectRatio: 180 / 90,
        children: [
          _buildItem(
            image: 'consultation',
            title: statistics.consultationsAll.toString(),
            subtitle: appLocalizations.allConsultations,
          ),
          _buildItem(
            image: 'consultation',
            title: statistics.consultationsUnderReview.toString(),
            subtitle: appLocalizations.underReviewConsultations,
          ),
          _buildItem(
            image: 'consultation',
            title: statistics.consultationsScheduled.toString(),
            subtitle: appLocalizations.scheduledConsultations,
          ),
          _buildItem(
            image: 'consultation',
            title: statistics.consultationsPending.toString(),
            subtitle: appLocalizations.pendingConsultations,
          ),
          _buildItem(
            image: 'consultation',
            title: statistics.consultationsUpcoming.toString(),
            subtitle: appLocalizations.upcomingConsultations,
          ),
          _buildItem(
            image: 'consultation',
            title: statistics.consultationsPendingPayment.toString(),
            subtitle: appLocalizations.pendingPaymentConsultations,
          ),
          _buildItem(
            image: 'consultation',
            title: statistics.consultationsRequiredAmount.toString(),
            subtitle: appLocalizations.requiredAmountConsultations,
            isCurrency: true,
          ),
        ],
      ),
    );
  }

  Card _buildItem({
    required String image,
    required String title,
    required String subtitle,
    bool isCurrency = false,
  }) {
    return Card(
      child: Center(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: image.svg,
          title: Text.rich(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            TextSpan(children: [
              TextSpan(text: title),
              if (isCurrency)
                TextSpan(
                  text: ' ${appLocalizations.sar}',
                  style: const TextStyle(fontSize: 9.0),
                ),
            ]),
            style: const TextStyle(fontSize: 16.0),
          ),
          subtitle: Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 8.0),
          ),
        ),
      ),
    );
  }
}
