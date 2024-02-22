import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:wrale/core/measurement.dart';
import 'package:wrale/core/preferences.dart';
import 'package:wrale/core/theme.dart';
import 'package:wrale/core/notifier.dart';
import 'package:wrale/pages/splash.dart';

const String measurementBoxName = 'measurements';

Future<void> main() async {
  // load singleton
  WidgetsFlutterBinding.ensureInitialized();
  final Preferences prefs = Preferences();
  await prefs.loaded;
  final WraleNotifier wraleNotifier = WraleNotifier();

  await Hive.initFlutter();
  Hive.registerAdapter<Measurement>(MeasurementAdapter());
  await Hive.openBox<Measurement>(measurementBoxName);

  return runApp(ChangeNotifierProvider<WraleNotifier>.value(
    value: wraleNotifier,
    child: const WraleMainApp(),
  ));
}

class WraleApp extends MaterialApp {
  /// Constructor
  WraleApp({
    super.key,
    required this.wraleNotifier,
    super.routes,
    required this.light,
    required this.dark,
    required this.amoled,
  }) : super(
            debugShowCheckedModeBanner: false,
            theme: light.themeData,
            darkTheme:
                wraleNotifier.isAmoled ? amoled.themeData : dark.themeData,
            themeMode: wraleNotifier.themeMode,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en'), // English
            ],
            locale: wraleNotifier.locale);

  final WraleNotifier wraleNotifier;
  final WraleTheme light;
  final WraleTheme dark;
  final WraleTheme amoled;
}

class WraleMainApp extends StatelessWidget {
  const WraleMainApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    final WraleNotifier wraleNotifier = Provider.of<WraleNotifier>(context);

// shared preferences instance
    final Preferences prefs = Preferences();

    return DynamicColorBuilder(builder: (
      ColorScheme? systemLight,
      ColorScheme? systemDark,
    ) {
      wraleNotifier.setColorScheme(systemLight, systemDark);
      return WraleApp(
        wraleNotifier: wraleNotifier,
        routes: <String, Widget Function(BuildContext)>{
          '/': (BuildContext context) {
            return const Splash();
          }
        },
        light: wraleNotifier.theme.light(context),
        dark: wraleNotifier.theme.dark(context),
        amoled: wraleNotifier.theme.amoled(context),
      );
    });
  }
}
