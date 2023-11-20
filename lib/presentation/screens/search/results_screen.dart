import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../constants/brand_colors.dart';
import '../../../cubits/consultations/consultations_cubit.dart';
import '../../../data/enums/consultation_content_type.dart';
import '../../../data/models/consultations/consultation.dart';
import '../../../data/models/consultations/consultations_filter.dart';
import '../../../data/services/repository.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../../widgets/reload_widget.dart';

class ConsultationsResultsScreen extends StatefulWidget {
  const ConsultationsResultsScreen({super.key});

  @override
  State<ConsultationsResultsScreen> createState() =>
      _ConsultationsResultsScreenState();
}

class _ConsultationsResultsScreenState
    extends State<ConsultationsResultsScreen> {
  final _favoriteConsultantId = ValueNotifier<int?>(null);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final filter =
          ModalRoute.of(context)!.settings.arguments as ConsultationsFilter;
      final cubit = context.read<ConsultationsCubit>();
      cubit.applyFilters(filter: filter);
      cubit.fetch(context);
    });
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

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.searchResults)),
      body: BlocBuilder<ConsultationsCubit, ConsultationsState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ConsultationsLoading:
              return const Center(child: CircularProgressIndicator());

            case ConsultationsLoaded:
              final consultations =
                  (state as ConsultationsLoaded).consultations;
              return Scrollbar(
                notificationPredicate: (notification) {
                  if (!state.canFetchMore || state.hasEndedScrolling) {
                    return false;
                  }
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent) {
                    context.read<ConsultationsCubit>().fetchMore(context);
                  }
                  return false;
                },
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.height,
                        horizontal: 27.width,
                      ),
                      sliver: SliverList.separated(
                        itemCount: consultations.length,
                        separatorBuilder: (context, index) => 16.emptyHeight,
                        itemBuilder: (context, index) => _ConsultationItem(
                          consultation: consultations[index],
                          favoriteConsultationId: _favoriteConsultantId,
                        ),
                      ),
                    ),
                    if (state.canFetchMore)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 16.height),
                        sliver: const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                  ],
                ),
              );

            case ConsultationsEmpty:
              return Center(child: Text(appLocalizations.consultationsEmpty));

            case ConsultationsError:
              return ReloadWidget(
                title: (state as ConsultationsError).message,
                buttonText: appLocalizations.getReload(
                  appLocalizations.consultations,
                ),
                onPressed: () =>
                    context.read<ConsultationsCubit>().fetch(context),
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

    return Card(
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
                          image:
                              consultant != null && consultant.image.isNotEmpty
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
                                await Repository.instance.favoriteConsultation(
                                  context,
                                  id: consultation.id,
                                );
                                if (!context.mounted) return;
                                BlocProvider.of<ConsultationsCubit>(context)
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
                                color: BrandColors.orange,
                                backgroundColor: Colors.grey,
                                value:
                                    (snapshot.data ?? Duration.zero).inSeconds /
                                        consultation
                                            .audioPlayer!.duration!.inSeconds,
                              ),
                            ),
                          ),
                        ),
                        8.emptyWidth,
                        FloatingActionButton.small(
                          elevation: 0.0,
                          heroTag: 'id-${consultation.id}',
                          child: const Icon(Icons.play_arrow_rounded),
                          onPressed: () async {
                            await consultation.audioPlayer!.seek(Duration.zero);
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
    );
  }
}
