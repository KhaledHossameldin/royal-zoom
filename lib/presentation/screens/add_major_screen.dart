import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/brand_colors.dart';
import '../../constants/fonts.dart';
import '../../cubits/add_new_major/add_new_major_cubit.dart';
import '../../cubits/majors/majors_cubit.dart';
import '../../cubits/switch/switch_cubit.dart';
import '../../data/enums/user_type.dart';
import '../../data/models/major.dart';
import '../../localization/app_localizations.dart';
import '../../utilities/extensions.dart';

class AddMajorScreen extends StatefulWidget {
  const AddMajorScreen({super.key});

  @override
  State<AddMajorScreen> createState() => _AddMajorScreenState();
}

class _AddMajorScreenState extends State<AddMajorScreen> {
  Major? _mainMajor;
  Major? _subMajor;

  final _formKey = GlobalKey<FormState>();
  final _previewNameController = TextEditingController();
  final _yearsOfExperience = TextEditingController();
  final _pricePerHour = TextEditingController();
  final _requirements = TextEditingController();

  bool _isActivated = true;
  bool _isNotificationsActivated = true;

  final _inputDecoration = const InputDecoration(
    border: InputBorder.none,
    fillColor: Colors.transparent,
  );

  @override
  void initState() {
    context.read<MajorsCubit>().fetch(context);
    super.initState();
  }

  @override
  void dispose() {
    _previewNameController.dispose();
    _yearsOfExperience.dispose();
    _pricePerHour.dispose();
    _requirements.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final userType = (context.read<SwitchCubit>().state as SwitchLoaded).type;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(appLocalizations.majorAndExperience),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 21.height,
            horizontal: 16.width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.addNewMajor,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.darkBlackGreen,
                ),
              ),
              20.emptyHeight,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (userType != UserType.consultant)
                      Column(
                        children: [
                          TextFormField(
                            controller: _previewNameController,
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            validator: (value) {
                              if (value.isNullOrEmpty) {
                                return '${appLocalizations.mustEnter} ${appLocalizations.consultantPreviewName}';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: false,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: BrandColors.gray),
                              ),
                              hintText: appLocalizations.consultantPreviewName,
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: BrandColors.darkGray,
                              ),
                            ),
                          ),
                          12.emptyHeight,
                        ],
                      ),
                    BlocBuilder<MajorsCubit, MajorsState>(
                      builder: (context, state) {
                        if (state is MajorsLoading) {
                          return const CircularProgressIndicator();
                        }
                        final majors = (state as MajorsLoaded).majors;
                        return Theme(
                          data: Theme.of(context).copyWith(
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                          ),
                          child: _ItemContainer(
                            title: appLocalizations.mainMajor,
                            child: DropdownButtonFormField<Major>(
                              hint: Text(appLocalizations.choose),
                              menuMaxHeight: 300.height,
                              icon: const Icon(Icons.expand_more),
                              decoration: _inputDecoration,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: Fonts.main,
                                color: BrandColors.black,
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return '${appLocalizations.mustChoose} ${appLocalizations.mainMajor}';
                                }
                                return null;
                              },
                              items: majors
                                  .map(
                                    (major) => DropdownMenuItem(
                                      value: major,
                                      child: Text(major.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => _mainMajor = value,
                            ),
                          ),
                        );
                      },
                    ),
                    12.emptyHeight,
                    BlocBuilder<MajorsCubit, MajorsState>(
                      builder: (context, state) {
                        if (state is MajorsLoading) {
                          return const CircularProgressIndicator();
                        }
                        final majors = (state as MajorsLoaded).majors;
                        return Theme(
                          data: Theme.of(context).copyWith(
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                          ),
                          child: _ItemContainer(
                            title: appLocalizations.subMajor,
                            child: DropdownButtonFormField<Major>(
                              hint: Text(appLocalizations.choose),
                              menuMaxHeight: 300.height,
                              icon: const Icon(Icons.expand_more),
                              decoration: _inputDecoration,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: Fonts.main,
                                color: BrandColors.black,
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return '${appLocalizations.mustChoose} ${appLocalizations.subMajor}';
                                }
                                return null;
                              },
                              items: majors
                                  .map(
                                    (major) => DropdownMenuItem(
                                      value: major,
                                      child: Text(major.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => _subMajor = value,
                            ),
                          ),
                        );
                      },
                    ),
                    12.emptyHeight,
                    TextFormField(
                      controller: _yearsOfExperience,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isNullOrEmpty) {
                          return '${appLocalizations.mustEnter} ${appLocalizations.experienceYears}';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: BrandColors.gray),
                        ),
                        hintText: appLocalizations.experienceYears,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: BrandColors.darkGray,
                        ),
                      ),
                    ),
                    12.emptyHeight,
                    TextFormField(
                      controller: _pricePerHour,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isNullOrEmpty) {
                          return '${appLocalizations.mustEnter} ${appLocalizations.pricePerHour}';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: BrandColors.gray),
                        ),
                        hintText: appLocalizations.pricePerHour,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: BrandColors.darkGray,
                        ),
                      ),
                    ),
                    12.emptyHeight,
                    TextFormField(
                      maxLines: 3,
                      controller: _requirements,
                      keyboardType: TextInputType.multiline,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      validator: (value) {
                        if (value.isNullOrEmpty) {
                          return '${appLocalizations.mustEnter} ${appLocalizations.sendingConsultationRequirements}';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: BrandColors.gray),
                        ),
                        hintText:
                            appLocalizations.sendingConsultationRequirements,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: BrandColors.darkGray,
                        ),
                      ),
                    ),
                    12.emptyHeight,
                    StatefulBuilder(
                      builder: (context, setState) => CheckboxListTile(
                        title: Text(
                          appLocalizations.activated,
                          style: const TextStyle(fontSize: 14),
                        ),
                        value: _isActivated,
                        onChanged: (value) =>
                            setState(() => _isActivated = value ?? false),
                      ),
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => CheckboxListTile(
                        title: Text(
                          appLocalizations.activateNotifications,
                          style: const TextStyle(fontSize: 14),
                        ),
                        value: _isNotificationsActivated,
                        onChanged: (value) => setState(
                            () => _isNotificationsActivated = value ?? false),
                      ),
                    ),
                    12.emptyHeight,
                    BlocConsumer<AddNewMajorCubit, AddNewMajorState>(
                      listener: (context, state) {
                        if (state is AddNewMajorError) {
                          state.message.showSnackbar(
                            context,
                            color: Colors.red,
                          );
                        }
                        if (state is AddNewMajorLoaded) {
                          if (userType == UserType.consultant) {
                            Navigator.pop<bool>(context, true);
                            return;
                          }
                        }
                        print(state);
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is AddNewMajorLoading
                              ? null
                              : () {
                                  final isValid =
                                      _formKey.currentState?.validate() ??
                                          false;
                                  if (isValid) {
                                    context.read<AddNewMajorCubit>().add(
                                          context,
                                          majorId: _mainMajor!.id,
                                          isActive: _isActivated,
                                          yearsOfExperience:
                                              _yearsOfExperience.text,
                                          price: _pricePerHour.text,
                                          terms: _requirements.text,
                                          isNotificationsEnabled:
                                              _isNotificationsActivated,
                                          name: userType == UserType.consultant
                                              ? _previewNameController.text
                                              : null,
                                        );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BrandColors.darkGreen,
                          ),
                          child: state is AddNewMajorLoading
                              ? const CircularProgressIndicator()
                              : Text(appLocalizations.save),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemContainer extends StatelessWidget {
  const _ItemContainer({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.width,
        vertical: 12.height,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: BrandColors.gray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: BrandColors.darkGray,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
