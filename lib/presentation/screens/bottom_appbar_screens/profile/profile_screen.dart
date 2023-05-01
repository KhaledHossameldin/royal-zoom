import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../localization/app_localizations.dart';
import '../../../../../utilities/extensions.dart';
import '../../../../blocs/authentication/authentication_bloc.dart';
import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../widgets/border_painter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final materialLocalizations = MaterialLocalizations.of(context);

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
            20.emptyHeight,
            _Item(
              icon: 'about-application',
              color: Colors.black,
              title: appLocalizations.aboutApplication,
              heroTag: appLocalizations.aboutApplication,
              onTap: () => Navigator.pushNamed(context, Routes.about),
            ),
            _Item(
              icon: 'terms-and-conditions',
              color: BrandColors.red,
              title: appLocalizations.termsOfUseTitle,
              heroTag: appLocalizations.termsOfUseTitle,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.termsAndConditions,
                arguments: true,
              ),
            ),
            _Item(
              icon: 'privacy-policy',
              color: BrandColors.lightBlue,
              title: appLocalizations.privacyPolicy,
              heroTag: appLocalizations.privacyPolicy,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.privacyPolicy,
                arguments: true,
              ),
            ),
            Builder(builder: (context) {
              final user = context.read<AuthenticationBloc>().user;
              return _Item(
                icon: 'contact-us',
                color: BrandColors.purple,
                title: appLocalizations.contactUs,
                heroTag: appLocalizations.contactUs,
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.contactUs,
                  arguments: user == null,
                ),
              );
            }),
            _Item(
              icon: 'share-application',
              color: BrandColors.orange,
              title: appLocalizations.shareWithFriends,
              heroTag: appLocalizations.shareWithFriends,
              onTap: () => Share.share('royake'),
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
    required this.heroTag,
    required this.color,
    required this.onTap,
  });

  final String icon;
  final String title;
  final String heroTag;
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
            child: icon.svg,
          ),
          title: Hero(
            tag: heroTag,
            child: Text(
              title,
              style: const TextStyle(fontSize: 15.0),
            ),
            flightShuttleBuilder: (
              flightContext,
              animation,
              flightDirection,
              fromHeroContext,
              toHeroContext,
            ) {
              return DefaultTextStyle(
                style: DefaultTextStyle.of(toHeroContext).style,
                child: toHeroContext.widget,
              );
            },
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

    return Card(
      child: InkWell(
        onTap: () {
          final user = context.read<AuthenticationBloc>().user;
          if (user == null) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (route) => false,
            );
            return;
          }
        },
        borderRadius: BorderRadius.circular(10.0),
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
                      image: 'guest'.png.image,
                    ),
                  ),
                ),
              ),
              14.emptyWidth,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appLocalizations.guest),
                    TextButton(
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
                    ),
                  ],
                ),
              ),
              CustomPaint(
                painter: BorderPainter(
                  stroke: 4.width,
                  padding: 12.width,
                  progress: 0.6,
                ),
                child: Text(NumberFormat.percentPattern().format(0.6)),
              ),
              12.emptyWidth,
            ],
          ),
        ),
      ),
    );
  }
}
