import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:just_audio/just_audio.dart';

import '../../../constants/brand_colors.dart';
import '../../../constants/fonts.dart';
import '../../../constants/routes.dart';
import '../../../cubits/cancel_consultation/cancel_consultation_cubit.dart';
import '../../../cubits/accept_date_change/accept_date_change_cubit.dart';
import '../../../cubits/send_comment/send_comment_cubit.dart';
import '../../../cubits/show_consultation/show_consultation_cubit.dart';
import '../../../data/enums/chat_resource_type.dart';
import '../../../data/enums/consultation_content_type.dart';
import '../../../data/enums/consultation_status.dart';
import '../../../data/models/consultations/consultation.dart';
import '../../../data/models/consultations/details.dart';
import '../../../data/services/repository.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../../widgets/brand_back_button.dart';
import '../../widgets/reload_widget.dart';
import '../../widgets/voice_record_widget.dart';

class ConsultationDetailsScreen extends StatefulWidget {
  const ConsultationDetailsScreen({
    super.key,
    required this.id,
    required this.player,
  });

  final int id;
  final AudioPlayer? player;

  @override
  State<ConsultationDetailsScreen> createState() =>
      _ConsultationDetailsScreenState();
}

class _ConsultationDetailsScreenState extends State<ConsultationDetailsScreen> {
  final _favoriteConsultationId = ValueNotifier<int?>(null);

  final _commentController = TextEditingController();

  late int rating;
  bool isVisible = false;

  @override
  void initState() {
    BlocProvider.of<ShowConsultationCubit>(context)
        .fetch(context, id: widget.id, player: widget.player);
    super.initState();
  }

  @override
  void dispose() {
    _favoriteConsultationId.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.consultationDetails),
        leading: const BrandBackButton(
          toHome: true,
        ),
      ),
      body: BlocConsumer<ShowConsultationCubit, ShowConsultationState>(
        listener: (context, state) {
          if (state is ShowConsultationLoaded) {
            rating = state.consultation.ratingAverage.toInt();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ShowConsultationLoading:
              return const Center(child: CircularProgressIndicator());

            case ShowConsultationLoaded:
              final consultation =
                  (state as ShowConsultationLoaded).consultation;
              return CustomScrollView(slivers: [
                SliverToBoxAdapter(child: 24.emptyHeight),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.height,
                    horizontal: 27.width,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _Header(
                      id: consultation.id,
                      majorName: consultation.major.name,
                      isFavourite: consultation.isFavourite,
                      date: consultation.appointmentDate,
                      favoriteConsultationId: _favoriteConsultationId,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.height,
                    horizontal: 27.width,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _Item(
                      title: appLocalizations.consultationDetails,
                      child: _Details(consultation: consultation),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.height,
                    horizontal: 27.width,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _Item(
                      title: appLocalizations.consultation,
                      child: _Content(
                        type: consultation.contentType,
                        content: consultation.content,
                        player: consultation.audioPlayer,
                      ),
                    ),
                  ),
                ),
                if (consultation.attachments != null)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4.height,
                      horizontal: 27.width,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.height),
                        child: _Item(
                          title: appLocalizations.attachments,
                          child: const Material(),
                        ),
                      ),
                    ),
                  ),
                if (consultation.attachments != null)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4.height,
                      horizontal: 27.width,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 176 / 51,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: BrandColors.orange.withOpacity(0.5),
                            ),
                          ),
                          leading: 'file'.svg,
                          title: Text(
                            consultation.attachments![index].file!
                                .split('/')
                                .last,
                            style: const TextStyle(fontSize: 9),
                          ),
                        ),
                        childCount: consultation.attachments!.length,
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.height,
                    horizontal: 27.width,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Builder(
                      builder: (context) {
                        if (consultation.consultant == null) {
                          return const Material();
                        }
                        final consultant = consultation.consultant!;
                        return _Item(
                          title: appLocalizations.consultant,
                          child: ListTile(
                            isThreeLine: true,
                            dense: true,
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: BrandColors.gray),
                            ),
                            onTap: consultant.username != null
                                ? () => Navigator.pushNamed(
                                      context,
                                      Routes.consultantDetails,
                                      arguments: consultant.username!,
                                    )
                                : null,
                            leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade600),
                              ),
                              child: Container(
                                width: 76.width,
                                height: 76.height,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 2.0),
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
                                Text(consultant.previewName ??
                                    appLocalizations.none),
                                6.emptyWidth,
                                if (consultant.major != null &&
                                    consultant.major!.isVerified)
                                  SizedBox.square(
                                    dimension: 16.width,
                                    child: 'verified'.png,
                                  ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(consultant.previewName ??
                                    appLocalizations.none),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    appLocalizations.termsOfUse,
                                    style: const TextStyle(
                                        color: BrandColors.orange),
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                Routes.chatDetails,
                                arguments: {
                                  'id': consultation.id,
                                  'type': ChatResourceType.consultation,
                                  'account': consultant,
                                },
                              ),
                              icon: 'chat'.svg,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.height,
                    horizontal: 27.width,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Builder(
                      builder: (context) {
                        if (consultation.status ==
                            ConsultationStatus.requestToChangetime) {
                          return _Item(
                            title: appLocalizations.responseAfterChangeTime,
                            child:
                                _ChangeDateSection(consultation: consultation),
                          );
                        }
                        if (consultation.status == ConsultationStatus.pending ||
                            consultation.status ==
                                ConsultationStatus.scehduled) {
                          return _CancelButton(consultationId: consultation.id);
                        }
                        if (consultation.status ==
                                ConsultationStatus.answeredByConsultant ||
                            consultation.status == ConsultationStatus.ended) {
                          return _buildEndedSection(consultation);
                        }
                        if (consultation.status == ConsultationStatus.draft) {
                          return Column(
                            children: [
                              _CancelButton(consultationId: consultation.id),
                              16.emptyHeight,
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      BrandColors.orange.withOpacity(0.2),
                                  foregroundColor: BrandColors.orange,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                ),
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  Routes.editConsultationContent,
                                  arguments: consultation,
                                ).then((value) {
                                  context.read<ShowConsultationCubit>().fetch(
                                      context,
                                      id: widget.id,
                                      player: widget.player);
                                }),
                                icon: const Icon(Icons.edit),
                                label: Text(appLocalizations.edit),
                              ),
                            ],
                          );
                        }
                        return const Material();
                      },
                    ),
                  ),
                ),
              ]);

            case ShowConsultationError:
              return ReloadWidget(
                title: (state as ShowConsultationError).message,
                buttonText: appLocalizations.getReload(
                  appLocalizations.consultation,
                ),
                onPressed: () => context
                    .read<ShowConsultationCubit>()
                    .fetch(context, id: widget.id, player: widget.player),
              );

            default:
              return const Material();
          }
        },
      ),
    );
  }

  Column _buildEndedSection(ConsultationDetails consultation) {
    final appLocalizations = AppLocalizations.of(context);
    return Column(
      children: [
        _Item(
          title: appLocalizations.consultationReview,
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              children: [
                RatingBar(
                  initialRating: consultation.ratingAverage.toDouble(),
                  glow: false,
                  tapOnlyMode: true,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    half: const Material(),
                    empty: const Icon(
                      Icons.star_rounded,
                      color: BrandColors.gray,
                    ),
                  ),
                  onRatingUpdate: (value) async {
                    try {
                      await Repository.instance.rateConsultation(
                        context,
                        id: consultation.id,
                        rate: value.toInt(),
                      );
                      setState(() {
                        rating = value.toInt();
                      });
                    } catch (e) {
                      if (!context.mounted) {
                        return;
                      }
                      '$e'.showSnackbar(
                        context,
                        color: BrandColors.red,
                      );
                    }
                  },
                ),
                Text(
                  '($rating/5)',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                StatefulBuilder(
                  builder: (context, setState) => CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    enabled: !isVisible,
                    title: Text(
                      appLocalizations.visibilityConsultationTitle,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    subtitle: Text(
                      appLocalizations.visibilityConsultationSubtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0,
                      ),
                    ),
                    value: isVisible,
                    onChanged: (value) => setState(() => isVisible = value!),
                  ),
                ),
              ],
            ),
          ),
        ),
        _Item(
          title: appLocalizations.comments,
          child: Column(children: [
            8.emptyHeight,
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: appLocalizations.typeComment,
              ),
            ),
            16.emptyHeight,
            BlocConsumer<SendCommentCubit, SendCommentState>(
              listener: (context, state) {
                if (state is SendCommentLoaded) {
                  appLocalizations.commentSuccess.showSnackbar(
                    context,
                    color: BrandColors.green,
                  );
                  return;
                }
                if (state is SendCommentError) {
                  state.message.showSnackbar(
                    context,
                    color: BrandColors.red,
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () => context.read<SendCommentCubit>().send(
                        context,
                        id: consultation.id,
                        comment: _commentController.text,
                      ),
                  child: state is SendCommentLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(appLocalizations.sendComment),
                );
              },
            )
          ]),
        ),
      ],
    );
  }
}

class _ChangeDateSection extends StatelessWidget {
  const _ChangeDateSection({required this.consultation});

  final ConsultationDetails consultation;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      children: [
        SizedBox(
          width: 150.width,
          child: 'date_change'.lottie,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.height,
            horizontal: 16.width,
          ),
          decoration: BoxDecoration(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(29.0),
          ),
          child: Text(
            '${appLocalizations.requestChangeTimeTo} ${DateFormat('dd/MM/yyy').add_jm().format(DateTime.now())}',
          ),
        ),
        12.emptyHeight,
        if (consultation.appointmentDate != null)
          Column(
            children: [
              Text(DateFormat('dd/MM/yyy')
                  .add_jm()
                  .format(consultation.appointmentDate!)),
              12.emptyHeight,
            ],
          ),
        BlocConsumer<DateChangeCubit, DateChangeState>(
          listenWhen: (prev, current) => prev is DateChangeAccepting,
          listener: (context, state) {
            if (state is DateChangeAccepted) {
              Navigator.pop(context);
              return;
            }
            if (state is DateChangeError) {
              state.message.showSnackbar(context, color: BrandColors.red);
              return;
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                final id = consultation.assignedRequest!.id;
                context.read<DateChangeCubit>().accept(context, id: id);
              },
              child: state is DateChangeAccepting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      appLocalizations.acceptDateChange,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            );
          },
        ),
        12.emptyHeight,
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: BrandColors.darkGreen,
                  backgroundColor: BrandColors.darkGreen.withOpacity(0.1),
                  side: const BorderSide(
                    color: BrandColors.darkGreen,
                  ),
                ),
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.editTimeChoose,
                  arguments: consultation,
                ),
                child: Text(
                  appLocalizations.changeTime,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        12.emptyHeight,
        Row(
          children: [
            Expanded(
              child: BlocConsumer<DateChangeCubit, DateChangeState>(
                listenWhen: (prev, current) => prev is DateChangeRejecting,
                listener: (context, state) {
                  if (state is DateChangeRejected) {
                    Navigator.pop(context);
                    return;
                  }
                  if (state is DateChangeError) {
                    state.message.showSnackbar(
                      context,
                      color: BrandColors.red,
                    );
                    return;
                  }
                },
                builder: (context, state) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: BrandColors.darkGreen,
                      backgroundColor: BrandColors.darkGreen.withOpacity(0.1),
                      side: const BorderSide(
                        color: BrandColors.darkGreen,
                      ),
                    ),
                    onPressed: () {
                      final id = consultation.assignedRequest!.id;
                      context.read<DateChangeCubit>().reject(context, id: id);
                    },
                    child: state is DateChangeRejecting
                        ? const CircularProgressIndicator()
                        : Text(
                            appLocalizations.decline,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ),
            12.emptyWidth,
            Expanded(
              child: _CancelButton(consultationId: consultation.id),
            ),
          ],
        ),
      ],
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.consultationId});

  final int consultationId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return BlocConsumer<CancelConsultationCubit, CancelConsultationState>(
      listener: (context, state) {
        if (state is CancelConsultationCanceled) {
          Navigator.pop(context);
          return;
        }
        if (state is CancelConsultationError) {
          state.message.showSnackbar(
            context,
            color: BrandColors.red,
          );
          return;
        }
      },
      builder: (context, state) {
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
          onPressed: state is CancelConsultationCancelling
              ? null
              : () {
                  context
                      .read<CancelConsultationCubit>()
                      .cancel(context, id: consultationId);
                },
          child: state is CancelConsultationCancelling
              ? const CircularProgressIndicator()
              : Text(
                  appLocalizations.cancelConsultation,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.type,
    required this.content,
    required this.player,
  });

  final ConsultationContentType type;
  final String content;
  final AudioPlayer? player;

  @override
  Widget build(BuildContext context) {
    // final appLocalizations = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.height),
      child: Builder(
        builder: (context) {
          if (type == ConsultationContentType.text) {
            return Text(content);
          }
          // if (player == null) {
          //   return Text(appLocalizations.cannotPlayAudio);
          // }
          return VoiceRecordWidget(
            audioUri: content,
            height: 50.height,
            width: 0.screenWidth,
          );

          // return Container(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 12.width,
          //     vertical: 8.height,
          //   ),
          //   decoration: BoxDecoration(
          //     color: BrandColors.snowWhite,
          //     borderRadius: BorderRadius.circular(29.0),
          //   ),
          //   child: Row(
          //     children: [
          //       Text(
          //         player!.duration!.audioTime,
          //         style: const TextStyle(
          //           fontSize: 9.0,
          //           color: BrandColors.black,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       8.emptyWidth,
          //       Expanded(
          //         child: StreamBuilder(
          //           stream: player!.positionStream,
          //           builder: (context, snapshot) => Directionality(
          //             textDirection: TextDirection.ltr,
          //             child: LinearProgressIndicator(
          //               color: BrandColors.darkGreen,
          //               backgroundColor: Colors.grey,
          //               value: (snapshot.data ?? Duration.zero).inSeconds /
          //                   max(player!.duration!.inSeconds, 1),
          //             ),
          //           ),
          //         ),
          //       ),
          //       8.emptyWidth,
          //       FloatingActionButton.small(
          //         elevation: 0.0,
          //         backgroundColor: BrandColors.darkGreen,
          //         heroTag: 'consultation-details',
          //         child: const Icon(Icons.play_arrow_rounded),
          //         onPressed: () async {
          //           await player!.seek(Duration.zero);
          //           player!.play();
          //         },
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.consultation});

  final Consultation consultation;

  final textStyle = const TextStyle(
    fontSize: 12.0,
    color: BrandColors.black,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: '${appLocalizations.consultationStatus}: ',
                style: const TextStyle(color: BrandColors.indigoBlue),
              ),
              TextSpan(
                text: appLocalizations.getConsultationStatus(
                    consultation.status,
                    consultation.isHideNameFromConsultants),
              ),
            ]),
            style: textStyle.copyWith(
              color: consultation.status.color,
            ),
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(text: appLocalizations.consultationNumber),
              TextSpan(
                text: '${consultation.id}',
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
            style: textStyle,
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(text: '${appLocalizations.responseTime}: '),
              TextSpan(
                text: '٢ يوم',
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
            style: textStyle,
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: '${appLocalizations.consultationPrice}: ',
              ),
              TextSpan(
                text: '${consultation.maximumPrice}',
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
            style: textStyle,
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: '${appLocalizations.paymentStatusSearch}: ',
              ),
              TextSpan(
                text: consultation.isPaid
                    ? appLocalizations.paid
                    : appLocalizations.notPaid,
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: Fonts.main,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.darkGreen,
                ),
              ),
              16.emptyWidth,
              const Expanded(child: Divider()),
            ],
          ),
          child,
        ],
      );
}

class _Header extends StatelessWidget {
  const _Header({
    required this.id,
    required this.majorName,
    required this.isFavourite,
    required this.date,
    required this.favoriteConsultationId,
  });

  final int id;
  final String majorName;
  final bool isFavourite;
  final DateTime? date;
  final ValueNotifier<int?> favoriteConsultationId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 35.width,
        backgroundColor: BrandColors.darkGreen,
      ),
      title: const Text('قانون'),
      subtitle: Text.rich(TextSpan(
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: BrandColors.mediumGray,
        ),
        children: [
          TextSpan(
              text: majorName,
              style: const TextStyle(
                color: BrandColors.orange,
              )),
          const TextSpan(text: ' | '),
          TextSpan(
              text: date != null
                  ? DateFormat('dd/MM/yyy').add_jm().format(date!)
                  : appLocalizations.none),
        ],
      )),
      trailing: ValueListenableBuilder(
        valueListenable: favoriteConsultationId,
        builder: (context, value, child) => TextButton.icon(
          onPressed: () async {
            favoriteConsultationId.value = id;
            try {
              await Repository.instance.favoriteConsultation(context, id: id);
              if (!context.mounted) return;
              BlocProvider.of<ShowConsultationCubit>(context).toggleFavorite();
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
          icon: value == id
              ? SizedBox.square(
                  dimension: 16.width,
                  child: const CircularProgressIndicator(
                    color: BrandColors.gray,
                    strokeWidth: 2.0,
                  ),
                )
              : Icon(
                  size: 15.0,
                  isFavourite ? Icons.favorite : Icons.favorite_outline,
                ),
          label: Text(
            appLocalizations.favorite,
            style: const TextStyle(fontSize: 10.0),
          ),
        ),
      ),
      // trailing: TextButton.icon(
      //   onPressed: () {},
      //   icon: Icon(
      //     isFavourite ? Icons.favorite : Icons.favorite_outline,
      //     size: 15.0,
      //   ),
      //   label: Text(
      //     appLocalizations.favorite,
      //     style: const TextStyle(fontSize: 10.0),
      //   ),
      // ),
    );
  }
}
