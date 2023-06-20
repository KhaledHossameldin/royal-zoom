import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/consultants/consultants_cubit.dart';
import '../../../../data/models/consultants/consultant.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/border_painter.dart';
import '../../../widgets/reload_widget.dart';

class ChooseConsultantScreen extends StatefulWidget {
  const ChooseConsultantScreen({super.key});

  @override
  State<ChooseConsultantScreen> createState() => _ChooseConsultantScreenState();
}

class _ChooseConsultantScreenState extends State<ChooseConsultantScreen> {
  final _controller = TextEditingController();
  final _showBottom = ValueNotifier<bool>(false);
  final _selected = ValueNotifier<int>(0);
  bool _isHideName = false;

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

    return Scaffold(
      backgroundColor: BrandColors.snowWhite,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 1.2,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              '${appLocalizations.send} ${appLocalizations.normalConsultation}',
            ),
            Text(
              '1 - ${appLocalizations.chooseConsultant}',
              style: const TextStyle(color: BrandColors.gray),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 27.width),
            child: CustomPaint(
              painter: BorderPainter(
                stroke: 3.0,
                padding: 8.width,
                progress: 0.33,
              ),
              child: const Center(
                child: Text.rich(
                  style: TextStyle(color: BrandColors.gray),
                  TextSpan(children: [
                    TextSpan(
                      text: '1',
                      style: TextStyle(color: BrandColors.orange),
                    ),
                    TextSpan(text: '/3'),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ConsultantsCubit, ConsultantsState>(
        listener: (context, state) {
          if (state is ConsultantsLoaded || state is ConsultantsEmpty) {
            _showBottom.value = true;
            return;
          }
          _showBottom.value = false;
        },
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
                    _SliverListView(
                      consultants: consultants,
                      selected: _selected,
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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  ValueListenableBuilder<bool> _buildBottomNavigationBar() {
    final appLocalizations = AppLocalizations.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: _showBottom,
      builder: (context, value, child) {
        if (!value) {
          return const Material();
        }
        return ColoredBox(
          color: BrandColors.snowWhite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.height,
                  horizontal: 27.width,
                ),
                child: StatefulBuilder(
                  builder: (context, setState) => Material(
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      value: _isHideName,
                      title: Text(appLocalizations.hideFromConsultant),
                      onChanged: (value) =>
                          setState(() => _isHideName = value!),
                    ),
                  ),
                ),
              ),
              BottomAppBar(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 27.width,
                    top: 24.height,
                    right: 27.width,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.grey.shade700,
                            backgroundColor: Colors.grey.shade100,
                          ),
                          child: Text(appLocalizations.cancel),
                        ),
                      ),
                      10.emptyWidth,
                      Expanded(
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: ValueListenableBuilder<int>(
                            valueListenable: _selected,
                            builder: (context, value, child) =>
                                ElevatedButton.icon(
                              onPressed: value <= 0 ? null : () {},
                              icon: const Icon(
                                Icons.keyboard_double_arrow_left_outlined,
                              ),
                              label: Text(appLocalizations.next),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SliverListView extends StatelessWidget {
  const _SliverListView({required this.consultants, required this.selected});

  final List<Consultant> consultants;
  final ValueNotifier<int> selected;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 10.height,
        horizontal: 27.width,
      ),
      sliver: SliverList.separated(
        itemCount: consultants.length,
        separatorBuilder: (context, index) => 10.emptyHeight,
        itemBuilder: (context, index) => _ConsultantItem(
          index: index,
          consultant: consultants[index],
          selected: selected,
        ),
      ),
    );
  }
}

class _ConsultantItem extends StatelessWidget {
  const _ConsultantItem({
    required this.index,
    required this.consultant,
    required this.selected,
  });

  final int index;
  final Consultant consultant;
  final ValueNotifier<int> selected;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return ListTile(
      isThreeLine: true,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: consultant.selected ? BrandColors.green : BrandColors.gray,
          width: consultant.selected ? 2.0 : 1.0,
        ),
      ),
      onTap: () {
        context.read<ConsultantsCubit>().toggleSelection(index);
        if (consultant.selected) {
          selected.value++;
        } else {
          selected.value--;
        }
      },
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
      title: Text(consultant.previewName ?? appLocalizations.none),
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
      trailing: CircleAvatar(
        backgroundColor:
            consultant.selected ? BrandColors.green : Colors.grey.shade400,
        child: const Icon(Icons.done, color: Colors.white),
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
          decoration: InputDecoration(
            fillColor: Colors.white,
            isDense: true,
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
          backgroundColor: Colors.white,
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.sendConsultationFilter,
          ),
          child: 'filter'.buildSVG(color: BrandColors.gray),
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
