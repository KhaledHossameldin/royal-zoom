import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../constants/brand_colors.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/favorite_consultations/favorite_consultations_cubit.dart';
import '../../../../data/enums/consultation_content_type.dart';
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

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _favoriteConsultantId = ValueNotifier<int?>(null);

  @override
  void initState() {
    context.read<FavoriteConsultationsCubit>().fetch(context);
    super.initState();
  }

  @override
  void dispose() {
    _favoriteConsultantId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              child: TabBarView(children: [
                BlocBuilder<FavoriteConsultationsCubit,
                    FavoriteConsultationsState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case FavoriteConsultationsLoading:
                        return const Center(child: CircularProgressIndicator());

                      case FavoriteConsultationsLoaded:
                        final consultations = groupBy(
                            (state as FavoriteConsultationsLoaded)
                                .consultations,
                            (item) => item.favoriteCategoryId);
                        return ListView.separated(
                          itemCount: consultations.length,
                          separatorBuilder: (context, index) => 16.emptyHeight,
                          itemBuilder: (context, index) {
                            final category =
                                consultations.keys.elementAt(index);
                            final categoryConsultants =
                                consultations[category]!;
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
                                      const Text(
                                        'title',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          color: BrandColors.darkGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                  12.emptyHeight,
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: categoryConsultants.length,
                                    separatorBuilder: (context, index) =>
                                        13.emptyHeight,
                                    itemBuilder: (context, index) =>
                                        _ConsultationItem(
                                      consultation: categoryConsultants[index]
                                          .consultation,
                                      favoriteConsultationId:
                                          _favoriteConsultantId,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );

                      case FavoriteConsultationsError:
                        return ReloadWidget(
                          title: (state as FavoriteConsultationsError).message,
                          buttonText: appLocalizations.getReload(''),
                          onPressed: () => context
                              .read<FavoriteConsultationsCubit>()
                              .fetch(context),
                        );

                      default:
                        return const Material();
                    }
                  },
                ),
                const Text('data2'),
              ]),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          heroTag: 'add-category-fab',
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
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

    return Card(
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
                                favoriteConsultationId.value = consultation.id;
                                try {
                                  await Repository.instance
                                      .favoriteConsultation(
                                    context,
                                    id: consultation.id,
                                  );
                                  if (!context.mounted) return;
                                  BlocProvider.of<FavoriteConsultationsCubit>(
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
                        return const Text('لا يمكن تشغيل الصوت');
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
