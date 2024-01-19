import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:smart_city/l10n/main.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key, required this.onDone, required this.onSkip})
      : super(key: key);

  final VoidCallback onDone;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final locale = getAppLoc(context);
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Moldbee',
          image: const Icon(Icons.emoji_nature_rounded, size: 80),
          body: locale!.intro_welcome,
        ),
        PageViewModel(
          title: locale.news,
          image: const Icon(
            Icons.newspaper_rounded,
            size: 50,
          ),
          body: locale.intro_news,
        ),
        PageViewModel(
          title: locale.events,
          image: const Icon(
            Icons.place_rounded,
            size: 50,
          ),
          body: locale.intro_events,
        ),
        PageViewModel(
          title: locale.services,
          image: const Icon(
            Icons.widgets_rounded,
            size: 50,
          ),
          body: locale.intro_services,
        ),
        PageViewModel(
          title: locale.other,
          image: const Icon(
            Icons.more_rounded,
            size: 50,
          ),
          body: locale.intro_other,
        ),
      ],
      back: const Icon(Icons.arrow_back),
      showBackButton: false,
      next: const Icon(Icons.arrow_forward),
      onSkip: onSkip,
      done: Text(locale.gotIt),
      showNextButton: true,
      onDone: onDone,
    );
  }
}
