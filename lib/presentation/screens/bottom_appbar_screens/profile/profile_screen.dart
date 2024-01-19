import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../localization/app_localizations.dart';
import '../../../../../utilities/extensions.dart';
import '../../../../blocs/authentication/authentication_bloc.dart';
import '../../../../constants/brand_colors.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/routes.dart';
import '../../../widgets/border_painter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final materialLocalizations = MaterialLocalizations.of(context);
    final user = context.read<AuthenticationBloc>().user;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.profile),
        actions: [
          IconButton(
            onPressed: () {},
            icon: 'search'.imageIcon,
            tooltip: materialLocalizations.searchFieldLabel,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 20.height,
          horizontal: 27.width,
        ),
        child: Column(
          children: [
            const _Header(),
            if (user != null)
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20.height),
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    Routes.addMajor,
                  ),
                  icon: const Icon(Icons.person_add_alt),
                  label: Text(appLocalizations.joinAsConsultant),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45.height),
                    textStyle: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.main,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            if (user != null)
              _Item(
                icon: 'search',
                color: BrandColors.lightBlue,
                title: appLocalizations.search,
                onTap: () => Navigator.pushNamed(context, Routes.search),
              ),
            if (user != null)
              _Item(
                icon: 'profile',
                color: BrandColors.orange,
                title: appLocalizations.profile,
                onTap: () => Navigator.pushNamed(context, Routes.profile),
              ),
            if (user != null)
              _Item(
                icon: 'consultants',
                color: BrandColors.red,
                title: appLocalizations.consultants,
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.consultantsProfile,
                ),
              ),
            if (user != null)
              _Item(
                icon: 'appointments',
                title: appLocalizations.appointments,
                color: BrandColors.green,
                onTap: () => Navigator.pushNamed(context, Routes.appointments),
              ),
            if (user != null)
              _Item(
                icon: 'heart-profile',
                title: appLocalizations.favorite,
                color: BrandColors.fuschia,
                onTap: () => Navigator.pushNamed(context, Routes.favorites),
              ),
            if (user != null)
              _Item(
                icon: 'wallet',
                color: BrandColors.purple,
                title: appLocalizations.payments,
                onTap: () => Navigator.pushNamed(context, Routes.payments),
              ),
            _Item(
              icon: 'about-application',
              color: Colors.black,
              title: appLocalizations.aboutApplication,
              onTap: () => Navigator.pushNamed(context, Routes.about),
            ),
            _Item(
              icon: 'terms-and-conditions',
              color: BrandColors.red,
              title: appLocalizations.termsOfUseTitle,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.termsAndConditions,
                arguments: user == null,
              ),
            ),
            _Item(
              icon: 'privacy-policy',
              color: BrandColors.lightBlue,
              title: appLocalizations.privacyPolicy,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.privacyPolicy,
                arguments: user == null,
              ),
            ),
            _Item(
              icon: 'contact-us',
              color: BrandColors.purple,
              title: appLocalizations.contactUs,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.contactUs,
                arguments: user == null,
              ),
            ),
            _Item(
              icon: 'share-application',
              color: BrandColors.orange,
              title: appLocalizations.shareWithFriends,
              onTap: () => Share.share('royake'),
            ),
            _Item(
              icon: 'rate',
              color: BrandColors.lightBlue,
              title: appLocalizations.reviewApplication,
              onTap: () => Navigator.pushNamed(context, Routes.reviewApp),
            ),
            if (user != null)
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationLoaded) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.login,
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) => Card(
                  child: ListTile(
                    splashColor: BrandColors.red.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    leading: Container(
                      width: 50.width,
                      height: 50.height,
                      padding: EdgeInsets.symmetric(
                        vertical: 14.height,
                        horizontal: 14.width,
                      ),
                      decoration: ShapeDecoration(
                        color: BrandColors.red.withOpacity(0.15),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                      ),
                      child: 'logout'.buildSVG(
                          color: BrandColors.red, blendMode: BlendMode.srcATop),
                    ),
                    title: state is AuthenticationLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: BrandColors.red),
                          )
                        : Text(
                            appLocalizations.logout,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                    onTap: () => context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogout(context)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  final String icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          splashColor: color.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          leading: Container(
            width: 50.width,
            height: 50.height,
            padding: EdgeInsets.symmetric(
              vertical: 14.height,
              horizontal: 14.width,
            ),
            decoration: ShapeDecoration(
              color: color.withOpacity(0.15),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
            ),
            child: icon.buildSVG(
              color: color,
              blendMode: BlendMode.srcATop,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 15.0),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    final user = context.read<AuthenticationBloc>().user;

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 13.height,
          horizontal: 17.width,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade600),
              ),
              child: Container(
                width: 87.width,
                height: 87.height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5.0),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: user == null
                        ? 'guest'.png.image
                        : user.data.image.isEmpty
                            ? 'royake'.png.image
                            : NetworkImage(user.data.image),
                  ),
                ),
              ),
            ),
            14.emptyWidth,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user == null
                      ? appLocalizations.guest
                      : user.data.previewName ?? appLocalizations.none),
                  user == null
                      ? TextButton(
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.login,
                            (route) => false,
                          ),
                          style: theme.textButtonTheme.style!.copyWith(
                            alignment: AlignmentDirectional.centerStart,
                            foregroundColor: MaterialStateProperty.resolveWith(
                              (states) => BrandColors.orange,
                            ),
                          ),
                          child: Text(
                            appLocalizations.login,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : Text(
                          user.data.email ??
                              user.data.phone ??
                              appLocalizations.none,
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
            ),
            CustomPaint(
              painter: BorderPainter(
                stroke: 4.width,
                padding: 12.width,
                progress: user != null ? user.data.progress : 0,
              ),
              child: Text(NumberFormat.percentPattern()
                  .format(user != null ? user.data.progress : 0)),
            ),
            12.emptyWidth,
          ],
        ),
      ),
    );
  }
}
