import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../constants/routes.dart';
import '../../../../../cubits/appointments/appointments_cubit.dart';
import '../../../../../data/enums/chat_resource_type.dart';
import '../../../../../localization/app_localizations.dart';
import '../../../../../utilities/extensions.dart';
import '../../../../widgets/reload_widget.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    context.read<AppointmentsCubit>().fetch(context);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.appointments)),
      body: BlocBuilder<AppointmentsCubit, AppointmentsState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case AppointmentsLoading:
              return const Center(child: CircularProgressIndicator());

            case AppointmentsLoaded:
              final appointments = (state as AppointmentsLoaded).appointments;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 31.width,
                      vertical: 16.height,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: appLocalizations.search,
                              hintStyle: textTheme.bodyLarge!.copyWith(
                                color: BrandColors.indigoBlue,
                              ),
                              suffixIcon: 'search'.imageIcon,
                            ),
                            onSubmitted: (value) {},
                          ),
                        ),
                        10.emptyWidth,
                        FloatingActionButton(
                          heroTag: 'filter-fab',
                          elevation: 0.0,
                          highlightElevation: 0.0,
                          tooltip: appLocalizations.filter,
                          backgroundColor: BrandColors.snowWhite,
                          onPressed: () => Navigator.pushNamed(
                            context,
                            Routes.appointmentsFilter,
                            arguments: context.read<AppointmentsCubit>(),
                          ),
                          child: 'filter'.buildSVG(color: BrandColors.darkGray),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 31.width,
                        vertical: 28.height,
                      ),
                      itemCount: appointments.length,
                      separatorBuilder: (context, index) => 19.emptyHeight,
                      itemBuilder: (context, index) => Card(
                        child: Column(children: [
                          ListTile(
                            title: Text(DateFormat.yMd('en').format(
                              appointments[index].appointmentDate,
                            )),
                            subtitle: Text(DateFormat.jm().format(
                              appointments[index].appointmentDate,
                            )),
                            trailing:
                                Text(appointments[index].appointmentStatus),
                          ),
                          const Divider(),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: appointments[index]
                                      .consultant
                                      .image
                                      .isNotEmpty
                                  ? NetworkImage(
                                      appointments[index].consultant.image,
                                    )
                                  : 'royake'.png.image,
                            ),
                            title: Text(
                              appointments[index].consultant.previewName ??
                                  appLocalizations.none,
                            ),
                            subtitle: Text(
                              appointments[index]
                                  .consultant
                                  .consultantPreviewName,
                            ),
                            trailing: IconButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                Routes.chatDetails,
                                arguments: {
                                  'id': appointments[index].id,
                                  'type': ChatResourceType.consultation,
                                  'account': appointments[index].consultant,
                                },
                              ),
                              icon: 'chat'.svg,
                            ),
                            onTap: () => Navigator.pushNamed(
                              context,
                              Routes.consultantDetails,
                              arguments: appointments[index].consultantId,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              );

            case AppointmentsError:
              return ReloadWidget(
                title: (state as AppointmentsError).message,
                buttonText: appLocalizations.getReload(''),
                onPressed: () =>
                    context.read<AppointmentsCubit>().fetch(context),
              );

            default:
              return const Material();
          }
        },
      ),
    );
  }
}
