import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/consultants/consultants_cubit.dart';
import '../../../../data/models/consultant.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/reload_widget.dart';

class ConsultantsScreen extends StatefulWidget {
  const ConsultantsScreen({super.key});

  @override
  State<ConsultantsScreen> createState() => _ConsultantsScreenState();
}

class _ConsultantsScreenState extends State<ConsultantsScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    context.read<ConsultantsCubit>().fetch(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return BlocBuilder<ConsultantsCubit, ConsultantsState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ConsultantsLoading:
            return const Center(child: CircularProgressIndicator());

          case ConsultantsEmpty:
            return ReloadWidget(
              title: appLocalizations.consultantsEmpty,
              buttonText: appLocalizations.getReload(
                appLocalizations.consultations,
              ),
              onPressed: () => context.read<ConsultantsCubit>().fetch(context),
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
                  _SearchTextField(controller: _controller),
                  _ConsultantsGridView(consultants: consultants),
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
              onPressed: () => context.read<ConsultantsCubit>().fetch(context),
            );

          default:
            return const Material();
        }
      },
    );
  }
}

class _ConsultantsGridView extends StatelessWidget {
  const _ConsultantsGridView({
    required this.consultants,
  });

  final List<Consultant> consultants;

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

    return SliverPadding(
      padding: EdgeInsets.only(
        left: 27.width,
        right: 27.width,
        top: 10.height,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: appLocalizations.searchConsultants,
                hintStyle: textTheme.bodyLarge!.copyWith(
                  color: BrandColors.indigoBlue,
                ),
                suffixIcon: 'search'.imageIcon,
              ),
            )),
            10.emptyWidth,
            FloatingActionButton(
              elevation: 0.0,
              highlightElevation: 0.0,
              backgroundColor: BrandColors.darkGreen,
              tooltip: appLocalizations.filter,
              onPressed: () => Navigator.pushNamed(context, Routes.filter),
              child: 'filter'.svg,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsultantItem extends StatelessWidget {
  const _ConsultantItem({required this.consultant});

  final Consultant consultant;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return GridTile(
      footer: MaterialButton(
        elevation: 0.0,
        height: 28.height,
        highlightElevation: 0.0,
        color: BrandColors.darkGreen,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
          ),
        ),
        onPressed: () {},
        child: Text(
          appLocalizations.consult,
          style: textTheme.labelSmall!.copyWith(color: Colors.white),
        ),
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
                arguments: consultant,
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
                  19.width,
                  13.height,
                ),
                decoration: const BoxDecoration(
                  gradient: BrandColors.blackTransparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar(
                      itemSize: 12.0,
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
                    2.emptyHeight,
                    Text(
                      consultant.previewName ?? appLocalizations.none,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    2.emptyHeight,
                    Text(
                      consultant.previewName ?? appLocalizations.none,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
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
