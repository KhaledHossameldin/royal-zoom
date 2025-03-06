import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/brand_colors.dart';
import '../../../core/di/di_manager.dart';
import '../../../core/states/base_fail_state.dart';
import '../../../core/states/base_success_state.dart';
import '../../../core/states/base_wait_state.dart';
import '../../../data/models/consultants/verify_major_request_body.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import 'cubit/major_and_experience_cubit.dart';
import 'cubit/major_and_experience_state.dart';

class VerifyMajorScreen extends StatefulWidget {
  const VerifyMajorScreen({super.key, required this.majorId});

  final int majorId;

  @override
  State<VerifyMajorScreen> createState() => _VerifyMajorScreenState();
}

class _VerifyMajorScreenState extends State<VerifyMajorScreen> {
  final ValueNotifier<List<PlatformFile>> attachments = ValueNotifier([]);
  final ValueNotifier<PlatformFile?> resume = ValueNotifier(null);
  final ValueNotifier<PlatformFile?> identityProof = ValueNotifier(null);
  final ValueNotifier<bool> acceptPolicies = ValueNotifier(false);
  final ValueNotifier<bool> acceptPaidConsultations = ValueNotifier(false);
  final cubit = DIManager.findDep<MajorAndExperienceCubit>();

  @override
  void dispose() {
    attachments.dispose();
    resume.dispose();
    identityProof.dispose();
    acceptPolicies.dispose();
    acceptPaidConsultations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.majorAndExperience)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 21.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.verificationRequest,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: BrandColors.darkBlackGreen,
              ),
            ),
            20.emptyHeight,
            ValueListenableBuilder(
              valueListenable: resume,
              builder: (context, value, child) => _BrowseWidget(
                appLocalizations: appLocalizations,
                title: appLocalizations.resume,
                file: value,
                onTap: () async {
                  final file = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc', 'docx'],
                  );
                  resume.value = file?.files.single;
                },
                onDeleteFile: () => resume.value = null,
              ),
            ),
            16.emptyHeight,
            ValueListenableBuilder(
              valueListenable: identityProof,
              builder: (context, value, child) => _BrowseWidget(
                appLocalizations: appLocalizations,
                title: appLocalizations.identityProof,
                file: value,
                onTap: () async {
                  final file = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc', 'docx'],
                  );
                  identityProof.value = file?.files.single;
                },
                onDeleteFile: () => identityProof.value = null,
              ),
            ),
            16.emptyHeight,
            ValueListenableBuilder(
              valueListenable: attachments,
              builder: (context, value, child) => _BrowseWidget(
                appLocalizations: appLocalizations,
                title: appLocalizations.otherFiles,
                files: value,
                onTap: () async {
                  final files = await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc', 'docx'],
                  );
                  attachments.value = files?.files ?? [];
                },
                onDeleteFileFromFiles: (file) {
                  final files = [...value];
                  files.removeWhere((element) => element.name == file.name);
                  attachments.value = files;
                },
              ),
            ),
            16.emptyHeight,
            ValueListenableBuilder<bool>(
              valueListenable: acceptPaidConsultations,
              builder: (context, value, child) => CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                value: value,
                title: Text(appLocalizations.verificationAcceptReceive),
                onChanged: (value) =>
                    acceptPaidConsultations.value = value ?? false,
              ),
            ),
            16.emptyHeight,
            ValueListenableBuilder<bool>(
              valueListenable: acceptPolicies,
              builder: (context, value, child) => CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                value: value,
                title: Text(appLocalizations.verificationAcceptPolicies),
                onChanged: (value) => acceptPolicies.value = value ?? false,
              ),
            ),
            24.emptyHeight,
            BlocConsumer<MajorAndExperienceCubit, MajorAndExperienceState>(
              bloc: cubit,
              listener: (context, state) {
                if (state.verifyMajorState is BaseFailState) {
                  ((state.verifyMajorState as BaseFailState).error?.message ??
                          '')
                      .showSnackbar(
                    context,
                    color: BrandColors.red,
                  );
                }
                if (state is BaseSuccessState) {
                  Navigator.pop(context, true);
                  return;
                }
              },
              builder: (context, state) {
                return IgnorePointer(
                  ignoring: state.verifyMajorState is BaseLoadingState,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!acceptPolicies.value) {
                        appLocalizations.mustAcceptPolicies.showSnackbar(
                          context,
                          color: BrandColors.red,
                        );
                        return;
                      }
                      if (resume.value == null) {
                        appLocalizations.mustUploadResume.showSnackbar(
                          context,
                          color: BrandColors.red,
                        );
                        return;
                      }
                      if (identityProof.value == null) {
                        appLocalizations.mustUploadIdentityProof.showSnackbar(
                          context,
                          color: BrandColors.red,
                        );
                        return;
                      }
                      cubit.verifyMajor(
                        body: VerifyRequestBody(
                          majorId: widget.majorId,
                          resume: resume.value!.path!,
                          identityProof: identityProof.value!.path!,
                          attachments:
                              attachments.value.map((e) => e.path!).toList(),
                          isAcceptPaidConsultations:
                              acceptPaidConsultations.value,
                        ),
                      );
                    },
                    child: Builder(builder: (context) {
                      if (state.verifyMajorState is BaseLoadingState) {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }
                      return Text(appLocalizations.sendRequest);
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BrowseWidget extends StatelessWidget {
  const _BrowseWidget({
    required this.appLocalizations,
    required this.onTap,
    required this.title,
    this.file,
    this.onDeleteFile,
    this.files = const [],
    this.onDeleteFileFromFiles,
  }) : assert((file == null || onDeleteFile != null) &&
            (files.length == 0 || onDeleteFileFromFiles != null));

  final AppLocalizations appLocalizations;
  final VoidCallback onTap;
  final String title;
  final PlatformFile? file;
  final VoidCallback? onDeleteFile;
  final List<PlatformFile> files;
  final void Function(PlatformFile)? onDeleteFileFromFiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: BrandColors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        8.emptyHeight,
        if (file != null)
          Column(children: [
            Chip(
              label: Text(file!.name),
              onDeleted: onDeleteFile,
            ),
            8.emptyHeight,
          ]),
        if (files.isNotEmpty)
          Wrap(
            children: files
                .map(
                  (e) => Chip(
                    label: Text(e.name),
                    onDeleted: () {
                      onDeleteFileFromFiles!(e);
                    },
                  ),
                )
                .toList(),
          ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: DottedBorder(
            borderType: BorderType.RRect,
            color: BrandColors.orange.withOpacity(0.25),
            radius: const Radius.circular(8),
            padding: EdgeInsets.zero,
            strokeCap: StrokeCap.butt,
            dashPattern: const [16, 16],
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.height),
              decoration: BoxDecoration(
                color: BrandColors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Text(
                appLocalizations.browse,
                style: const TextStyle(
                  fontSize: 12,
                  color: BrandColors.orange,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
