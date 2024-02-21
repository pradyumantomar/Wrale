import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wrale/core/preferences.dart';
import 'package:wrale/pages/home.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  /// shared preferences instance
  final Preferences prefs = Preferences();

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push<void>(MaterialPageRoute<void>(builder: (_) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    final PageDecoration pageDecoration = PageDecoration(
        titleTextStyle: Theme.of(context).textTheme.headlineMedium!,
        bodyTextStyle: Theme.of(context).textTheme.bodyLarge!,
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 4.0,
          vertical: 16.0,
        ));

    final List<PageViewModel> pageViewModels = <PageViewModel>[
      PageViewModel(
        title: 'onBoarding screen demo one ',
        body: 'body demo',
        image: Icon(Icons.abc),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: 'onBoarding screen demo two ',
        body: 'body demo two',
        image: Icon(Icons.abc),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: 'onBoarding screen demo three ',
        body: 'body demo three',
        image: const Icon(Icons.abc),
        decoration: pageDecoration,
      ),
    ];

    void closingOnBoarding(BuildContext context) {
      prefs.showOnBoarding = false;
      _onIntroEnd(context);
    }

    return IntroductionScreen(
      pages: pageViewModels,
      onDone: () => closingOnBoarding(context),
      onSkip: () => closingOnBoarding(context),
      showSkipButton: true,
      skip: Text('skip'),
      next: Text('next'),
      done: Text('done'),
    );
  }
}
