import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../constants/brand_colors.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/favorite_consultants/favorite_consultants_cubit.dart';
import '../../../../cubits/favorite_consultations/favorite_consultations_cubit.dart';
import '../../../../data/enums/consultation_content_type.dart';
import '../../../../data/models/consultants/consultant.dart';
import '../../../../data/models/consultations/consultation.dart';
import '../../../../data/services/repository.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/reload_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  final _favoriteConsultationId = ValueNotifier<int?>(null);
  final _favoriteConsultantId = ValueNotifier<int?>(null);
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    Future.wait([
      context.read<FavoriteConsultationsCubit>().fetch(context),
      context.read<FavoriteConsultantsCubit>().fetch(context),
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _favoriteConsultationId.dispose();
    _favoriteConsultantId.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.favorite),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 245.width,
                  padding: EdgeInsets.symmetric(vertical: 17.height),
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: appLocalizations.consultations),
                      Tab(text: appLocalizations.consultants),
                    ],
                    labelStyle: const TextStyle(
                      fontSize: 15.0,
                      fontFamily: Fonts.main,
                    ),
                  ),
                ),
                FloatingActionButton.small(
                  heroTag: 'category-fab',
                  elevation: 0,
                  highlightElevation: 0,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(
                    Icons.category_outlined,
                    color: BrandColors.darkGray,
                    size: 20.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              ConsultationsTab(
                favoriteConsultationId: _favoriteConsultationId,
              ),
              BlocBuilder<FavoriteConsultantsCubit, FavoriteConsultantsState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case FavoriteConsultantsLoading:
                      return const Center(child: CircularProgressIndicator());

                    case FavoriteConsultantsLoaded:
                      final consultants = groupBy(
                        (state as FavoriteConsultantsLoaded).consultants,
                        (item) => item.favoriteCategoryId,
                      );
                      return RefreshIndicator(
                        onRefresh: () async => context
                            .read<FavoriteConsultantsCubit>()
                            .fetch(context),
                        child: ListView.separated(
                          itemCount: consultants.length,
                          separatorBuilder: (context, index) => 16.emptyHeight,
                          itemBuilder: (context, index) {
                            final category = consultants.keys.elementAt(index);
                            final categoryConsultants = consultants[category]!;
                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 14.width,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 14.height,
                                horizontal: 13.width,
                              ),
                              decoration: BoxDecoration(
                                color: BrandColors.snowWhite,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.category,
                                        color: BrandColors.darkGray,
                                        size: 16.0,
                                      ),
                                      8.emptyWidth,
                                      Text(
                                        appLocalizations.noCategoryConsultant,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          color: BrandColors.darkGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                  12.emptyHeight,
                                  ListView.separated(
                                    key:
                                        const PageStorageKey('favorite_screen'),
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: categoryConsultants.length,
                                    separatorBuilder: (context, index) =>
                                        13.emptyHeight,
                                    itemBuilder: (context, index) =>
                                        _ConsultantItem(
                                      consultant:
                                          categoryConsultants[index].consultant,
                                      favoriteConsultantId:
                                          _favoriteConsultantId,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );

                    case FavoriteConsultantsError:
                      return ReloadWidget(
                        title: (state as FavoriteConsultantsError).message,
                        buttonText: appLocalizations.getReload(''),
                        onPressed: () => context
                            .read<FavoriteConsultantsCubit>()
                            .fetch(context),
                      );

                    default:
                      return const Material();
                  }
                },
              ),
            ]),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'add-category-fab',
        child: const Icon(Icons.add),
        onPressed: () {
          final controller = TextEditingController();
          bool isLoading = false;
          showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                actionsPadding: const EdgeInsets.all(16.0),
                title: Text(
                  appLocalizations.addFavorite,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: BrandColors.orange,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                content: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: appLocalizations.favoriteName,
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                double.infinity,
                                50.height,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 13.0,
                                fontFamily: Fonts.main,
                              )),
                          onPressed: () async {
                            if (controller.text.isEmpty) {
                              Navigator.pop(context);
                              return;
                            }
                            setState(() => isLoading = true);
                            try {
                              Repository.instance.addFavoriteCategory(
                                context,
                                name: controller.text,
                                type: _tabController.index == 0
                                    ? 'consultation'
                                    : 'consultant',
                              );
                            } catch (e) {
                              '$e'.showSnackbar(context,
                                  color: BrandColors.red);
                            }
                            Navigator.pop(context);
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(appLocalizations.add),
                        ),
                      ),
                      8.emptyWidth,
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: BrandColors.darkGreen,
                            backgroundColor:
                                BrandColors.darkGreen.withOpacity(0.1),
                            side:
                                const BorderSide(color: BrandColors.darkGreen),
                            minimumSize: Size(
                              double.infinity,
                              50.height,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: Fonts.main,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(appLocalizations.cancel),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ConsultationsTab extends StatelessWidget {
  const ConsultationsTab({
    super.key,
    required ValueNotifier<int?> favoriteConsultationId,
  }) : _favoriteConsultantId = favoriteConsultationId;

  final ValueNotifier<int?> _favoriteConsultantId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return BlocBuilder<FavoriteConsultationsCubit, FavoriteConsultationsState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case FavoriteConsultationsLoading:
            return const Center(child: CircularProgressIndicator());

          case FavoriteConsultationsLoaded:
            final consultations = groupBy(
                (state as FavoriteConsultationsLoaded).consultations,
                (item) => item.favoriteCategoryId);
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<FavoriteConsultationsCubit>().fetch(context),
              child: ListView.separated(
                key: const PageStorageKey('favorite_screen_1'),
                itemCount: consultations.length,
                separatorBuilder: (context, index) => 16.emptyHeight,
                itemBuilder: (context, index) {
                  final category = consultations.keys.elementAt(index);
                  final categoryConsultants = consultations[category]!;
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 14.width,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 14.height,
                      horizontal: 13.width,
                    ),
                    decoration: BoxDecoration(
                      color: BrandColors.snowWhite,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.category,
                              color: BrandColors.darkGray,
                              size: 16.0,
                            ),
                            8.emptyWidth,
                            Text(
                              appLocalizations.noCategoryConsultation,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                color: BrandColors.darkGreen,
                              ),
                            ),
                          ],
                        ),
                        12.emptyHeight,
                        ListView.separated(
                          key: const PageStorageKey('favorite_screen_2'),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: categoryConsultants.length,
                          separatorBuilder: (context, index) => 13.emptyHeight,
                          itemBuilder: (context, index) => _ConsultationItem(
                            consultation:
                                categoryConsultants[index].consultation,
                            favoriteConsultationId: _favoriteConsultantId,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );

          case FavoriteConsultationsError:
            return ReloadWidget(
              title: (state as FavoriteConsultationsError).message,
              buttonText: appLocalizations.getReload(''),
              onPressed: () =>
                  context.read<FavoriteConsultationsCubit>().fetch(context),
            );

          default:
            return const Material();
        }
      },
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

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: consultation.isHideNameFromConsultants
            ? null
            : () => Navigator.pushNamed(
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
            if (consultation.isHideNameFromConsultants) {
              return Row(
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
              );
            }
            return Column(
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
                        Row(
                          children: [
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    BrandColors.gray.withOpacity(0.2),
                                minimumSize: Size(0, 23.height),
                                textStyle: const TextStyle(
                                  fontSize: 8.0,
                                  fontFamily: Fonts.main,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text(
                                      'Choose',
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Builder(builder: (_) {
                                      final cubit = context
                                          .read<FavoriteConsultationsCubit>();
                                      final categories = (cubit.state
                                              as FavoriteConsultationsLoaded)
                                          .categories;
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: categories
                                            .map((e) => ListTile(
                                                  title: Text(e.name),
                                                  onTap: () async {
                                                    try {
                                                      await Repository.instance
                                                          .favoriteConsultation(
                                                        context,
                                                        id: consultation.id,
                                                        category: e.id,
                                                      );
                                                      if (!context.mounted) {
                                                        return;
                                                      }
                                                      cubit.fetch(context);
                                                    } catch (e) {
                                                      '$e'.showSnackbar(
                                                        context,
                                                        color: BrandColors.red,
                                                      );
                                                    }
                                                    Navigator.pop(context);
                                                  },
                                                ))
                                            .toList(),
                                      );
                                    }),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.category, size: 12.0),
                              label: Text(appLocalizations.addClassification),
                            ),
                            12.emptyWidth,
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
                                      BlocProvider.of<
                                                  FavoriteConsultationsCubit>(
                                              context)
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
                                            consultation.isPaid)
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
                        consultation.contentType == ConsultationContentType.text
                            ? 10.0
                            : 50.0),
                  ),
                  child: Builder(
                    builder: (context) {
                      if (consultation.contentType ==
                          ConsultationContentType.text) {
                        return Text(consultation.content);
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
                              stream: consultation.audioPlayer!.positionStream,
                              builder: (context, snapshot) => Directionality(
                                textDirection: TextDirection.ltr,
                                child: LinearProgressIndicator(
                                  color: BrandColors.darkGreen,
                                  backgroundColor: Colors.grey,
                                  value: (snapshot.data ?? Duration.zero)
                                          .inSeconds /
                                      consultation
                                          .audioPlayer!.duration!.inSeconds,
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
    );
  }
}

class _ConsultantItem extends StatelessWidget {
  const _ConsultantItem({
    required this.consultant,
    required this.favoriteConsultantId,
  });

  final Consultant consultant;
  final ValueNotifier<int?> favoriteConsultantId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: () => Navigator.pushNamed(
        context,
        Routes.consultantDetails,
        arguments: consultant.id,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: BrandColors.gray.withOpacity(0.3)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12.height,
          horizontal: 18.width,
        ),
        child: Column(
          children: [
            ListTile(
              isThreeLine: true,
              leading: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: BrandColors.orange),
                ),
                child: Container(
                  width: 76.width,
                  height: 76.height,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: consultant.image.isNotEmpty
                          ? NetworkImage(consultant.image)
                          : 'royake'.png.image,
                    ),
                  ),
                ),
              ),
              title: Row(
                children: [
                  Text(consultant.previewName ?? appLocalizations.none),
                  6.emptyWidth,
                  if (consultant.major != null && consultant.major!.isVerified)
                    SizedBox.square(
                      dimension: 16.width,
                      child: 'verified'.png,
                    ),
                  const Expanded(child: Material()),
                  ValueListenableBuilder(
                    valueListenable: favoriteConsultantId,
                    builder: (context, value, child) {
                      if (value == consultant.id) {
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
                          favoriteConsultantId.value = consultant.id;
                          try {
                            await Repository.instance.favoriteConsultant(
                              context,
                              id: consultant.id,
                            );
                            if (!context.mounted) return;
                            BlocProvider.of<FavoriteConsultantsCubit>(context)
                                .toggleFavorite(consultant.id);
                            favoriteConsultantId.value = null;
                          } catch (e) {
                            if (!context.mounted) return;
                            '$e'.showSnackbar(
                              context,
                              color: BrandColors.red,
                            );
                            favoriteConsultantId.value = null;
                          }
                        },
                        child: Icon(consultant.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_outline),
                      );
                    },
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(consultant.previewName ?? appLocalizations.none),
                  Row(
                    children: [
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
                      16.emptyWidth,
                      Text(
                        '${60.0.round()} ${appLocalizations.sarH}',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.width),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: BrandColors.darkGreen,
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                    fontFamily: Fonts.main,
                  ),
                  minimumSize: const Size(double.infinity, 34.0),
                ),
                child: Text(appLocalizations.sendCounsultationTitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
