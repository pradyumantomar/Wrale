import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wrale/core/preferences.dart';
import 'package:wrale/pages/home.dart';
import 'package:wrale/pages/onBoarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ElevationOverlay.colorWithOverlay(
        Theme.of(context).colorScheme.surface,
        Theme.of(context).colorScheme.primary,
        3.0,
      ),
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Theme.of(context).brightness,
    ));
  }

  @override
  Widget build(BuildContext context) {
    void onStop() {
      final Preferences prefs = Preferences();
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute<Scaffold>(
        builder: (BuildContext context) {
          return (prefs.showOnBoarding || true)
              ? const OnBoardingPage()
              : const Home();
        },
      ));
    }

    final Future<void> loadMeasurements = Future<void>(
      () {
        // MeasurementDatabase().reinit();
      },
    ).then((_) => onStop());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SizedBox(
          width: 0.8 * MediaQuery.of(context).size.width,
          child: FutureBuilder<void>(
              future: loadMeasurements,
              builder: (
                BuildContext context,
                AsyncSnapshot<void> snapshot,
              ) {
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
