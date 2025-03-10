import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../constants/brand_colors.dart';
import '../../../constants/routes.dart';
import '../../../cubits/consultations/consultations_cubit.dart';
import '../../../data/enums/consultation_content_type.dart';
import '../../../data/models/consultations/consultation.dart';
import '../../../data/services/repository.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../../widgets/reload_widget.dart';
import '../../widgets/voice_record_widget.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  final _controller = TextEditingController();
  final _favoriteConsultationId = ValueNotifier<int?>(null);

  @override
  void initState() {
    context.read<ConsultationsCubit>().fetch(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _favoriteConsultationId.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    context.read<ConsultationsCubit>().clearFilters();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.consultations),
      ),
      body: BlocBuilder<ConsultationsCubit, ConsultationsState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ConsultationsLoading:
              return const Center(child: CircularProgressIndicator());

            case ConsultationsEmpty:
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 27.width,
                      right: 27.width,
                      top: 10.height,
                    ),
                    child: _SearchTextField(controller: _controller),
                  ),
                  Expanded(
                    child: ReloadWidget(
                      title: appLocalizations.consultationsEmpty,
                      buttonText: appLocalizations.getReload(
                        appLocalizations.consultations,
                      ),
                      onPressed: () =>
                          context.read<ConsultationsCubit>().fetch(context),
                    ),
                  ),
                ],
              );

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
                child: RefreshIndicator(
                  onRefresh: () =>
                      context.read<ConsultationsCubit>().fetch(context),
                  child: CustomScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      _SliverSearchTextField(controller: _controller),
                      _ConsultationsListView(
                        consultations: consultations,
                        favoriteConsultantId: _favoriteConsultationId,
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
                ),
              );

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

class _SearchTextField extends StatelessWidget {
  const _SearchTextField({required TextEditingController controller})
      : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: appLocalizations.searchConsultations,
            hintStyle: textTheme.bodyLarge!.copyWith(
              color: BrandColors.indigoBlue,
              fontSize: 14.0,
            ),
            suffixIcon: 'search'.imageIcon,
          ),
          onSubmitted: (value) {
            final cubit = context.read<ConsultationsCubit>();
            cubit.applyFilters(searchText: value);
            cubit.fetch(context);
          },
        )),
        10.emptyWidth,
        FloatingActionButton(
          heroTag: 'filter-fab',
          elevation: 0.0,
          highlightElevation: 0.0,
          tooltip: appLocalizations.filter,
          backgroundColor: BrandColors.snowWhite,
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              Routes.consultationsFilter,
              arguments: context.read<ConsultationsCubit>(),
            );
            if (context.mounted) {
              context.read<ConsultationsCubit>().fetch(context);
            }
          },
          child: 'filter'.buildSVG(color: BrandColors.indigoBlue),
        ),
      ],
    );
  }
}

class _SliverSearchTextField extends StatelessWidget {
  const _SliverSearchTextField({required TextEditingController controller})
      : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: EdgeInsets.only(
          left: 27.width,
          right: 27.width,
          top: 10.height,
        ),
        sliver: SliverToBoxAdapter(
          child: _SearchTextField(controller: _controller),
        ),
      );
}

class _ConsultationsListView extends StatelessWidget {
  const _ConsultationsListView({
    required this.consultations,
    required this.favoriteConsultantId,
  });

  final List<Consultation> consultations;
  final ValueNotifier<int?> favoriteConsultantId;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 10.height,
        horizontal: 27.width,
      ),
      sliver: SliverList.separated(
        key: const PageStorageKey('consultation_screen'),
        itemCount: consultations.length,
        separatorBuilder: (context, index) => 16.emptyHeight,
        itemBuilder: (context, index) => _ConsultationItem(
          consultation: consultations[index],
          favoriteConsultationId: favoriteConsultantId,
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
                      // if (consultation.audioPlayer == null) {
                      //   return Text(appLocalizations.cannotPlayAudio);
                      // }
                      return VoiceRecordWidget(
                        audioUri: consultation.content,
                        height: 50.height,
                        width: 0.screenWidth * 0.4,
                      );
                      // return Row(
                      //   children: [
                      //     Text(
                      //       consultation.audioPlayer!.duration!.audioTime,
                      //       style: const TextStyle(
                      //         fontSize: 9.0,
                      //         color: BrandColors.black,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     8.emptyWidth,
                      //     Expanded(
                      //       child: StreamBuilder(
                      //         stream: consultation.audioPlayer!.positionStream,
                      //         builder: (context, snapshot) => Directionality(
                      //           textDirection: TextDirection.ltr,
                      //           child: LinearProgressIndicator(
                      //             color: BrandColors.darkGreen,
                      //             backgroundColor: Colors.grey,
                      //             value: (snapshot.data ?? Duration.zero)
                      //                     .inSeconds /
                      //                 consultation
                      //                     .audioPlayer!.duration!.inSeconds,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     8.emptyWidth,
                      //     FloatingActionButton.small(
                      //       elevation: 0.0,
                      //       backgroundColor: BrandColors.darkGreen,
                      //       heroTag: 'id-${consultation.id}',
                      //       child: const Icon(Icons.play_arrow_rounded),
                      //       onPressed: () async {
                      //         await consultation.audioPlayer!
                      //             .seek(Duration.zero);
                      //         consultation.audioPlayer!.play();
                      //       },
                      //     ),
                      //   ],
                      // );
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
