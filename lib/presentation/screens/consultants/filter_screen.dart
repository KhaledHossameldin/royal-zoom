import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../cubits/filter/filter_cubit.dart';
import '../../../../data/models/authentication/city.dart';
import '../../../../data/models/authentication/country.dart';
import '../../../../data/models/major.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../cubits/consultants/consultants_cubit.dart';
import '../../widgets/reload_widget.dart';

class ConsultantsFilterScreen extends StatefulWidget {
  const ConsultantsFilterScreen({super.key});

  @override
  State<ConsultantsFilterScreen> createState() =>
      _ConsultantsFilterScreenState();
}

class _ConsultantsFilterScreenState extends State<ConsultantsFilterScreen> {
  final reviews = [];

  @override
  void initState() {
    context
        .read<ConsultantsFilterCubit>()
        .fetch(context, countryId: context.read<ConsultantsCubit>().countryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(appLocalizations.filter),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ConsultantsCubit>().clearFilter();
              context.read<ConsultantsCubit>().fetch(context);
              Navigator.pop(context);
            },
            child: Text(appLocalizations.reset),
          ),
        ],
      ),
      body: BlocBuilder<ConsultantsFilterCubit, ConsultantsFilterState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case FilterLoading:
              state as FilterLoading;
              if (state.countries == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _buildBody(state);
              }

            case ConsultantsFilterLoaded:
              state as ConsultantsFilterLoaded;
              return _buildBody(state);

            case ConsultantsFilterError:
              state as ConsultantsFilterError;
              if (state.countries == null) {
                return ReloadWidget(
                  title: state.message,
                  buttonText:
                      appLocalizations.getReload(appLocalizations.filter),
                  onPressed: () =>
                      context.read<ConsultantsFilterCubit>().fetch(context),
                );
              } else {
                return _buildBody(state);
              }

            default:
              return const Material();
          }
        },
      ),
    );
  }

  SingleChildScrollView _buildBody(ConsultantsFilterState state) {
    final appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 34.width,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMajors(state.majors!),
          10.emptyHeight,
          _buildCountries(state.countries!),
          10.emptyHeight,
          Builder(builder: (context) {
            if (state is FilterLoading) {
              return const CircularProgressIndicator();
            } else if (state is ConsultantsFilterError) {
              return Text(state.message);
            } else {
              return _buildCities((state as ConsultantsFilterLoaded).cities);
            }
          }),
          10.emptyHeight,
          _buildReviews(),
          20.emptyHeight,
          ElevatedButton(
            onPressed: () {
              context.read<ConsultantsCubit>().fetch(context);
              Navigator.pop(context);
            },
            child: Text(appLocalizations.viewResults),
          ),
        ],
      ),
    );
  }

  ChoiceChip _buildReviewChip(StateSetter setState, {required int index}) {
    final appLocalizations = AppLocalizations.of(context);

    bool isSelected = reviews.contains(index);

    return ChoiceChip(
      label: Text(appLocalizations.getStars(index)),
      selected: isSelected,
      onSelected: (value) {
        setState(() {
          if (isSelected) {
            reviews.remove(index);
            return;
          }
          reviews.add(index);
        });
      },
    );
  }

  StatefulBuilder _buildCities(List<City>? cities) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final cubit = context.read<ConsultantsCubit>();

    return StatefulBuilder(
      builder: (context, setState) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.city),
          8.emptyHeight,
          Material(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(12.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<int>(
                value: cubit.cityId,
                isExpanded: true,
                menuMaxHeight: 300.height,
                hint: Text(appLocalizations.choose),
                underline: const Material(),
                borderRadius: BorderRadius.circular(12.0),
                icon: const Icon(Icons.expand_more_rounded),
                style: textTheme.bodySmall!.copyWith(
                  color: BrandColors.darkBlue,
                ),
                items: cities
                    ?.map((item) => DropdownMenuItem<int>(
                        value: item.id, child: Text(item.name)))
                    .toList(),
                onChanged: (value) => setState(
                  () => cubit.applyFilter(cityId: value),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  StatefulBuilder _buildCountries(List<Country> countries) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final cubit = context.read<ConsultantsCubit>();

    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(appLocalizations.country),
          8.emptyHeight,
          Material(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(12.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<int>(
                value: cubit.countryId,
                isExpanded: true,
                menuMaxHeight: 300.height,
                hint: Text(appLocalizations.choose),
                underline: const Material(),
                borderRadius: BorderRadius.circular(12.0),
                icon: const Icon(Icons.expand_more_rounded),
                style: textTheme.bodySmall!.copyWith(
                  color: BrandColors.darkBlue,
                ),
                items: countries
                    .map((item) => DropdownMenuItem<int>(
                        value: item.id, child: Text(item.name)))
                    .toList(),
                onChanged: (value) {
                  cubit.applyFilter(countryId: value, cityId: null);
                  context
                      .read<ConsultantsFilterCubit>()
                      .fetchCities(context, countryId: value!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  StatefulBuilder _buildMajors(List<Major> majors) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final consultantsCubit = context.read<ConsultantsCubit>();

    return StatefulBuilder(
      builder: (context, setState) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.getMajor(true)),
          8.emptyHeight,
          Material(
            color: BrandColors.snowWhite,
            borderRadius: BorderRadius.circular(12.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<int>(
                value: consultantsCubit.majorId,
                isExpanded: true,
                menuMaxHeight: 300.height,
                hint: Text(appLocalizations.choose),
                underline: const Material(),
                borderRadius: BorderRadius.circular(12.0),
                icon: const Icon(Icons.expand_more_rounded),
                style: textTheme.bodySmall!.copyWith(
                  color: BrandColors.darkBlue,
                ),
                items: majors
                    .map((item) => DropdownMenuItem<int>(
                        value: item.id, child: Text(item.name)))
                    .toList(),
                onChanged: (value) => setState(
                  () => consultantsCubit.applyFilter(majorId: value),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  StatefulBuilder _buildReviews() {
    final appLocalizations = AppLocalizations.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.review),
          Wrap(
            spacing: 10.width,
            children: [
              _buildReviewChip(setState, index: 0),
              _buildReviewChip(setState, index: 1),
              _buildReviewChip(setState, index: 2),
              _buildReviewChip(setState, index: 3),
              _buildReviewChip(setState, index: 4),
              _buildReviewChip(setState, index: 5),
            ],
          ),
        ],
      ),
    );
  }
}
