import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/brand_colors.dart';
import '../../../constants/routes.dart';
import '../../../core/di/di_manager.dart';
import '../../../core/states/base_fail_state.dart';
import '../../../core/states/base_success_state.dart';
import '../../../core/states/base_wait_state.dart';
import '../../../domain/entities/consultant_major_entity.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import 'cubit/major_and_experience_cubit.dart';
import 'cubit/major_and_experience_state.dart';

class MajorAndExperienceScreen extends StatefulWidget {
  const MajorAndExperienceScreen({super.key});

  @override
  State<MajorAndExperienceScreen> createState() =>
      _MajorAndExperienceScreenState();
}

class _MajorAndExperienceScreenState extends State<MajorAndExperienceScreen> {
  final cubit = DIManager.findDep<MajorAndExperienceCubit>();
  @override
  void initState() {
    cubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.majorAndExperience)),
      body: BlocBuilder<MajorAndExperienceCubit, MajorAndExperienceState>(
        bloc: cubit,
        builder: (context, state) {
          final majorAndExperience = state.majorAndExperiencesState;
          if (majorAndExperience is BaseLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (majorAndExperience is BaseFailState) {
            return Center(
              child: Text(majorAndExperience.error!.message.toString()),
            );
          }
          if (majorAndExperience is BaseSuccessState) {
            final majors =
                majorAndExperience.data! as List<ConsultantMajorEntity>;
            log(majors.toString());
            return ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 24.height,
              ),
              itemCount: majors.length,
              separatorBuilder: (context, index) => 12.emptyHeight,
              itemBuilder: (context, index) => _Item(
                appLocalizations: appLocalizations,
                major: majors[index],
              ),
            );
          }
          return const Material();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'major-and-experience-fab',
        child: const Icon(Icons.add),
        onPressed: () async {
          final isRefresh = await Navigator.pushNamed<bool>(
            context,
            Routes.addMajor,
          );
          if (isRefresh ?? false) {
            cubit.fetch();
          }
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.appLocalizations,
    required this.major,
  });

  final AppLocalizations appLocalizations;
  final ConsultantMajorEntity major;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 21.width,
          vertical: 15.height,
        ),
        child: Column(children: [
          ListTile(
            dense: true,
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${appLocalizations.mainMajor} : '),
                  TextSpan(
                    text: major.major?.parent?.name ?? appLocalizations.none,
                    style: const TextStyle(
                      fontSize: 14,
                      color: BrandColors.darkBlackGreen,
                    ),
                  ),
                ],
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
            subtitle: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${appLocalizations.subMajor} : '),
                  TextSpan(
                    text: major.major?.name ?? appLocalizations.none,
                    style: const TextStyle(
                      fontSize: 14,
                      color: BrandColors.darkBlackGreen,
                    ),
                  ),
                ],
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            trailing: Text(
              major.isActive != 0
                  ? appLocalizations.activated
                  : appLocalizations.notActivated,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: major.isActive != 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            tileColor: BrandColors.snowWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            dense: true,
            title: RichText(
                text: TextSpan(
              children: [
                TextSpan(text: '${appLocalizations.verificationStatus} : '),
                WidgetSpan(
                  child: Builder(builder: (context) {
                    if (major.isVerified != 0) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox.square(
                            dimension: 24.width,
                            child: 'verified'.png,
                          ),
                          8.emptyWidth,
                          Text(
                            appLocalizations.verified,
                            style: const TextStyle(
                              fontSize: 12,
                              color: BrandColors.lightBlue,
                            ),
                          ),
                        ],
                      );
                    }
                    if (major.majorVerificationRequest != null) {
                      return Text(
                        appLocalizations.verifying,
                        style: const TextStyle(color: BrandColors.orange),
                      );
                    }
                    return TextButton.icon(
                      onPressed: major.isAvailableForVerification != 0
                          ? () => Navigator.pushNamed<bool>(
                                context,
                                Routes.verifyMajor,
                                arguments: major.id,
                              )
                          : null,
                      style: TextButton.styleFrom(
                        foregroundColor: BrandColors.darkGreen,
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Droid Arabic Kufi',
                        ),
                      ),
                      icon: const Icon(Icons.check_box_rounded),
                      label: Text(appLocalizations.verificationRequest),
                    );
                  }),
                  alignment: PlaceholderAlignment.middle,
                ),
              ],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontFamily: 'Droid Arabic Kufi',
              ),
            )),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: SwitchListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                appLocalizations.freeMajor,
                style: const TextStyle(fontSize: 12),
              ),
              value: major.isFree != 0,
              onChanged: (value) {},
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  color: BrandColors.orange,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline),
                  color: BrandColors.red,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
