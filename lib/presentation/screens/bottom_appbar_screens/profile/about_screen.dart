import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/routes.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../data/sources/local/shared_prefs.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kTabScrollDuration,
    );
    _videoController = 'about'.video
      ..initialize().then((value) => setState(() {}))
      ..setLooping(true)
      ..setVolume(0.0)
      ..play();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final user = DIManager.findDep<SharedPrefs>().getUser();

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.aboutApplication),
        actions: user == null
            ? [
                TextButton.icon(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                    (route) => false,
                  ),
                  icon: 'profile'.svg,
                  label: Text(appLocalizations.register),
                ),
              ]
            : null,
      ),
      body: ListView(
        children: [
          const _Header(),
          const _HowWeWork(),
          _SolveProblems(
            videoController: _videoController,
            animationController: _animationController,
          ),
          const _CoreValues(),
          20.emptyHeight,
          'about_footer'.png,
          20.emptyHeight,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.ourTeam,
                  style: textTheme.bodySmall!.copyWith(
                    color: BrandColors.orange,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  appLocalizations.teamExperienceTitle,
                  style: textTheme.displayMedium,
                ),
                Text(
                  appLocalizations.teamExperienceSubtitle,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                15.emptyHeight,
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(247.width, 64.height),
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.main,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(appLocalizations.contactUs),
                      21.emptyWidth,
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CoreValues extends StatelessWidget {
  const _CoreValues();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.ourCoreValue, style: textTheme.displayMedium),
          20.emptyHeight,
          Text(
            appLocalizations.valuesShape,
            style: textTheme.bodyMedium!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          20.emptyHeight,
          _buildItem(
            textTheme,
            image: 'integrity',
            title: appLocalizations.integrityTitle,
            body: appLocalizations.integritySubtitle,
          ),
          20.emptyHeight,
          _buildItem(
            textTheme,
            image: 'cooperation',
            title: appLocalizations.cooperationTitle,
            body: appLocalizations.cooperationSubtitle,
          ),
          20.emptyHeight,
          _buildItem(
            textTheme,
            image: 'integration',
            title: appLocalizations.integrationTitle,
            body: appLocalizations.integrationSubtitle,
          ),
          20.emptyHeight,
          _buildItem(
            textTheme,
            image: 'trust',
            title: appLocalizations.trustTitle,
            body: appLocalizations.trustSubtitle,
          ),
        ],
      ),
    );
  }

  SizedBox _buildItem(
    TextTheme textTheme, {
    required String image,
    required String title,
    required String body,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox.square(
            dimension: 100.width,
            child: image.png,
          ),
          10.emptyHeight,
          Text(
            title,
            style: textTheme.titleLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          15.emptyHeight,
          Text(
            body,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _SolveProblems extends StatelessWidget {
  const _SolveProblems({
    required VideoPlayerController videoController,
    required AnimationController animationController,
  })  : _videoController = videoController,
        _animationController = animationController;

  final VideoPlayerController _videoController;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Stack(
      children: [
        _videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: Transform.scale(
                  scale: 2.1,
                  alignment: Alignment.topCenter,
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: VideoPlayer(_videoController),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
        Padding(
          padding: EdgeInsets.fromLTRB(
            26.width,
            80.height,
            26.width,
            20.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FloatingActionButton(
                heroTag: 'video-fab',
                onPressed: () {
                  if (_videoController.value.isPlaying) {
                    _animationController.forward();
                    _videoController.pause();
                    return;
                  }
                  _animationController.reverse();
                  _videoController.play();
                },
                elevation: 0.0,
                backgroundColor: Colors.white,
                child: AnimatedIcon(
                  icon: AnimatedIcons.pause_play,
                  progress: _animationController,
                  color: BrandColors.orange,
                ),
              ),
              40.emptyHeight,
              Text(
                appLocalizations.problemsSolved,
                style: textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.emptyHeight,
              Text(
                appLocalizations.consultantsHelp,
                style: textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
              40.emptyHeight,
              _buildItem(
                textTheme,
                icon: 'audio-message',
                title: appLocalizations.sendCounsultationTitle,
                body: appLocalizations.sendCounsultationSubtitle,
              ),
              _buildItem(
                textTheme,
                icon: 'receive-mail',
                title: appLocalizations.receiveReplyTitle,
                body: appLocalizations.receiveReplySubtitle,
              ),
              _buildItem(
                textTheme,
                icon: 'rating',
                title: appLocalizations.valueConsultationTitle,
                body: appLocalizations.valueConsultationSubtitle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox _buildItem(
    TextTheme textTheme, {
    required String icon,
    required String title,
    required String body,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 25.height,
            horizontal: 20.width,
          ),
          child: Column(
            children: [
              icon.svg,
              20.emptyHeight,
              Text(
                title,
                style: textTheme.headlineSmall!.copyWith(
                  color: BrandColors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.emptyHeight,
              Text(
                body,
                style: textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HowWeWork extends StatelessWidget {
  const _HowWeWork();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 26.width,
        vertical: 20.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.howWorkClientsTitle,
            style: textTheme.displayMedium,
          ),
          10.emptyHeight,
          Text(
            appLocalizations.howWorkClientsSubtitle,
            style: textTheme.titleLarge!.copyWith(color: Colors.grey),
          ),
          10.emptyHeight,
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(247.width, 64.height),
              backgroundColor: BrandColors.darkGreen,
              textStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.main,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(appLocalizations.contactUs),
                21.emptyWidth,
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return SizedBox(
      height: 197.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: 'about_header'.png,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appLocalizations.royakeForConsultations,
                style: textTheme.displayLarge,
              ),
              Text(
                appLocalizations.saudiArabia,
                style: textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
