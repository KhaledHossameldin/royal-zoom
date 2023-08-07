import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:just_audio/just_audio.dart';

import '../../../constants/brand_colors.dart';
import '../../../constants/fonts.dart';
import '../../../constants/routes.dart';
import '../../../cubits/show_consultation/show_consultation_cubit.dart';
import '../../../data/enums/consultation_content_type.dart';
import '../../../data/models/consultations/consultation.dart';
import '../../../data/models/consultations/details.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../../widgets/brand_back_button.dart';
import '../../widgets/reload_widget.dart';

class ConsultationDetailsScreen extends StatefulWidget {
  const ConsultationDetailsScreen({super.key, required this.id});

  final int id;

  @override
  State<ConsultationDetailsScreen> createState() =>
      _ConsultationDetailsScreenState();
}

class _ConsultationDetailsScreenState extends State<ConsultationDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<ShowConsultationCubit>(context)
        .fetch(context, id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.consultationDetails),
          leading: const BrandBackButton(),
        ),
        body: BlocBuilder<ShowConsultationCubit, ShowConsultationState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case ShowConsultationLoading:
                return const Center(child: CircularProgressIndicator());

              case ShowConsultationLoaded:
                final consultation =
                    (state as ShowConsultationLoaded).consultation;
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: 21.height,
                    horizontal: 27.width,
                  ),
                  child: Column(
                    children: [
                      _Header(
                        majorName: consultation.major.name,
                        date: consultation.appointmentDate,
                        isFavourite: consultation.isFavourite,
                      ),
                      _Item(
                        title: appLocalizations.consultationDetails,
                        child: _Details(consultation: consultation),
                      ),
                      8.emptyHeight,
                      _Item(
                        title: appLocalizations.consultation,
                        child: _Content(
                          type: consultation.contentType,
                          content: consultation.content,
                          player: consultation.audioPlayer,
                        ),
                      ),
                      Builder(
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
                              onTap: () => Navigator.pushNamed(
                                context,
                                Routes.consultantDetails,
                                arguments: consultant,
                              ),
                              leading: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.grey.shade600),
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
                            ),
                          );
                        },
                      ),
                      8.emptyHeight,
                      _Item(
                        title: appLocalizations.responseAfterChangeTime,
                        child: _ChangeDateSection(consultation: consultation),
                      ),
                    ],
                  ),
                );

              case ShowConsultationError:
                return ReloadWidget(
                  title: (state as ShowConsultationError).message,
                  buttonText: appLocalizations.getReload(
                    appLocalizations.consultation,
                  ),
                  onPressed: () => context
                      .read<ShowConsultationCubit>()
                      .fetch(context, id: widget.id),
                );

              default:
                return const Material();
            }
          },
        ));
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
          child: 'date_change'.lottieOneTime,
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
        ElevatedButton(
          onPressed: () {},
          child: Text(
            appLocalizations.acceptDateChange,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
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
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: BrandColors.darkGreen,
                  backgroundColor: BrandColors.darkGreen.withOpacity(0.1),
                  side: const BorderSide(
                    color: BrandColors.darkGreen,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  appLocalizations.decline,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            12.emptyWidth,
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
                onPressed: () {},
                child: Text(
                  appLocalizations.cancelConsultation,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.height),
      child: Builder(
        builder: (context) {
          if (type == ConsultationContentType.text) {
            return Text(content);
          }
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.width,
              vertical: 8.height,
            ),
            decoration: BoxDecoration(
              color: BrandColors.snowWhite,
              borderRadius: BorderRadius.circular(29.0),
            ),
            child: Row(
              children: [
                Text(
                  player!.duration!.audioTime,
                  style: const TextStyle(
                    fontSize: 9.0,
                    color: BrandColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.emptyWidth,
                Expanded(
                  child: StreamBuilder(
                    stream: player!.positionStream,
                    builder: (context, snapshot) => Directionality(
                      textDirection: TextDirection.ltr,
                      child: LinearProgressIndicator(
                        color: BrandColors.darkGreen,
                        backgroundColor: Colors.grey,
                        value: (snapshot.data ?? Duration.zero).inSeconds /
                            player!.duration!.inSeconds,
                      ),
                    ),
                  ),
                ),
                8.emptyWidth,
                FloatingActionButton.small(
                  elevation: 0.0,
                  backgroundColor: BrandColors.darkGreen,
                  heroTag: 'consultation-details',
                  child: const Icon(Icons.play_arrow_rounded),
                  onPressed: () async {
                    await player!.seek(Duration.zero);
                    player!.play();
                  },
                ),
              ],
            ),
          );
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
    required this.majorName,
    required this.isFavourite,
    required this.date,
  });

  final String majorName;
  final bool isFavourite;
  final DateTime? date;

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
      trailing: TextButton.icon(
        onPressed: () {},
        icon: Icon(
          isFavourite ? Icons.favorite : Icons.favorite_outline,
          size: 15.0,
        ),
        label: Text(
          appLocalizations.favorite,
          style: const TextStyle(fontSize: 10.0),
        ),
      ),
    );
  }
}
