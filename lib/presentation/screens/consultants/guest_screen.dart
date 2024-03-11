import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/consultants/consultants_cubit.dart';
import '../../../data/models/consultants/consultant.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../data/services/repository.dart';
import '../../widgets/app_bar_logo.dart';
import '../../widgets/reload_widget.dart';
import '../../widgets/notifications_button.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  final _controller = TextEditingController();
  final _favoriteConsultantId = ValueNotifier<int?>(null);

  @override
  void initState() {
    context.read<ConsultantsCubit>().fetch(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _favoriteConsultantId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    // final user = BlocProvider.of<AuthenticationBloc>(context).user;

    return Scaffold(
      appBar: //user == null?
          AppBar(
        leadingWidth: 100.0,
        leading: const AppBarLogo(),
        actions: const [NotificationsButton()],
      ),
      // : null,
      body: BlocBuilder<ConsultantsCubit, ConsultantsState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ConsultantsLoading:
              return const Center(child: CircularProgressIndicator());

            case ConsultantsEmpty:
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
                      title: appLocalizations.consultantsEmpty,
                      buttonText: appLocalizations.getReload(
                        appLocalizations.consultations,
                      ),
                      onPressed: () =>
                          context.read<ConsultantsCubit>().fetch(context),
                    ),
                  ),
                ],
              );

            case ConsultantsLoaded:
              final consultants = (state as ConsultantsLoaded).consultants;

              return Scrollbar(
                notificationPredicate: (notification) {
                  if (!state.canFetchMore || state.hasEndedScrolling) {
                    return false;
                  }
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent) {
                    context.read<ConsultantsCubit>().fetchMore(context);
                  }
                  return false;
                },
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    _SliverSearchTextField(controller: _controller),
                    _ConsultantsGridView(
                      consultants: consultants,
                      favoriteConsultantId: _favoriteConsultantId,
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

            case ConsultantsError:
              return ReloadWidget(
                title: (state as ConsultantsError).message,
                buttonText: appLocalizations.getReload(
                  appLocalizations.consultations,
                ),
                onPressed: () =>
                    context.read<ConsultantsCubit>().fetch(context),
              );

            default:
              return const Material();
          }
        },
      ),
    );
  }
}

class _ConsultantsGridView extends StatelessWidget {
  const _ConsultantsGridView({
    required this.consultants,
    required this.favoriteConsultantId,
  });

  final List<Consultant> consultants;
  final ValueNotifier<int?> favoriteConsultantId;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 10.height,
        horizontal: 27.width,
      ),
      sliver: SliverGrid.builder(
        itemCount: consultants.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.width,
          mainAxisSpacing: 10.height,
          childAspectRatio: 0.867,
        ),
        itemBuilder: (context, index) => _ConsultantItem(
          consultant: consultants[index],
          favoriteConsultantId: favoriteConsultantId,
        ),
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
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: appLocalizations.searchConsultants,
            hintStyle: textTheme.bodyLarge!.copyWith(
              color: BrandColors.indigoBlue,
            ),
            suffixIcon: 'search'.imageIcon,
          ),
          onSubmitted: (value) {
            final cubit = context.read<ConsultantsCubit>();
            cubit.applyFilter(searchKey: value);
            cubit.fetch(context);
          },
        )),
        10.emptyWidth,
        FloatingActionButton(
          heroTag: 'filter-fab',
          elevation: 0.0,
          highlightElevation: 0.0,
          tooltip: appLocalizations.filter,
          backgroundColor: BrandColors.darkGreen,
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.consultantFilter,
            arguments: context.read<ConsultantsCubit>(),
          ),
          child: 'filter'.svg,
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

class _ConsultantItem extends StatelessWidget {
  const _ConsultantItem({
    required this.consultant,
    required this.favoriteConsultantId,
  });

  final Consultant consultant;
  final ValueNotifier<int?> favoriteConsultantId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return GridTile(
      footer: Row(
        children: [
          Expanded(
            child: MaterialButton(
              elevation: 0.0,
              height: 28.height,
              highlightElevation: 0.0,
              color: BrandColors.darkGreen,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10.0),
                ),
              ),
              onPressed: () {},
              child: Text(
                appLocalizations.consult,
                style: textTheme.labelSmall!.copyWith(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: favoriteConsultantId,
              builder: (context, value, child) => MaterialButton(
                elevation: 0.0,
                height: 28.height,
                highlightElevation: 0.0,
                color: BrandColors.gray,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10.0),
                  ),
                ),
                onPressed: () async {
                  favoriteConsultantId.value = consultant.id;
                  try {
                    await Repository.instance
                        .favoriteConsultant(context, id: consultant.id);
                    if (!context.mounted) return;
                    BlocProvider.of<ConsultantsCubit>(context)
                        .toggleFavorite(consultant.id);
                    favoriteConsultantId.value = null;
                  } catch (e) {
                    if (!context.mounted) return;
                    '$e'.showSnackbar(context, color: BrandColors.red);
                    favoriteConsultantId.value = null;
                  }
                },
                child: value != consultant.id
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            consultant.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            size: 11.0,
                          ),
                          3.emptyWidth,
                          Text(
                            appLocalizations.favorite,
                            style: textTheme.labelSmall!.copyWith(
                              color: BrandColors.darkGreen,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 16.height,
                        width: 16.width,
                        child: const CircularProgressIndicator(
                          color: BrandColors.darkGreen,
                          strokeWidth: 2.0,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
      child: Stack(
        children: [
          Ink(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20.0),
                bottom: Radius.circular(10.0),
              ),
              image: DecorationImage(
                alignment: consultant.image.isNotEmpty
                    ? Alignment.topCenter
                    : Alignment.center,
                fit: consultant.image.isNotEmpty
                    ? BoxFit.cover
                    : BoxFit.fitWidth,
                image: consultant.image.isNotEmpty
                    ? NetworkImage(consultant.image)
                    : 'royake'.png.image,
              ),
            ),
            child: InkWell(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20.0),
                bottom: Radius.circular(10.0),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                Routes.consultantDetails,
                arguments: consultant.id,
              ),
            ),
          ),
          Positioned(
            bottom: 28.height,
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                width: 200.width,
                padding: EdgeInsetsDirectional.fromSTEB(
                  19.width,
                  68.height,
                  30.width,
                  13.height,
                ),
                decoration: const BoxDecoration(
                  gradient: BrandColors.blackTransparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          consultant.consultantPreviewName,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        if (consultant.major != null &&
                            consultant.major!.isVerified)
                          Row(
                            children: [
                              5.emptyWidth,
                              SizedBox.square(
                                dimension: 10.width,
                                child: 'verified'.png,
                              ),
                            ],
                          ),
                        if (consultant.major != null &&
                            consultant.major!.isActive)
                          Row(
                            children: [
                              5.emptyWidth,
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 5.width,
                              ),
                            ],
                          ),
                      ],
                    ),
                    2.emptyHeight,
                    Text(
                      consultant.settings != null
                          ? consultant.settings!.shortBrief ??
                              appLocalizations.none
                          : appLocalizations.none,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    2.emptyHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar(
                          itemSize: 11.0,
                          initialRating: 3,
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
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text:
                                  '${consultant.major != null ? consultant.major!.pricePerHour.round() : appLocalizations.none} ',
                              style: const TextStyle(color: BrandColors.orange),
                            ),
                            TextSpan(text: appLocalizations.sarH),
                          ]),
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
