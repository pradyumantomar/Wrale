import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wrale/core/notifier.dart';
import 'package:wrale/core/preferences.dart';
import 'package:wrale/core/theme.dart';
import 'package:wrale/pages/splash.dart';

const String measurementBoxName = 'measurements';

Future<void> main() async {
  //load singleton
  WidgetsFlutterBinding.ensureInitialized();
  final Preferences prefs = Preferences();
  await prefs.loaded;
  final WraleNotifier wraleNotifier = WraleNotifier();

  await Hive.initFlutter();
  // Hive.registerAdapter();
  await Hive.openBox(measurementBoxName);

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
    // required this.light,
    // required this.dark,
    // required this.amoled,
  }) : super(
        // theme: ,
        // darkTheme: ,
        // themeMode:  ,
        // localizationsDelegates: ,
        // supportedLocales:  ,
        // locale: ,
        );

  /// themeNotifier for interactive change of theme
  final WraleNotifier wraleNotifier;
  // final WraleTheme light;
  // final WraleTheme dark;
  // final WraleTheme amoled;
}

class WraleMainApp extends StatelessWidget {
  const WraleMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final WraleNotifier wraleNotifier = Provider.of<WraleNotifier>(context);

    final Preferences prefs = Preferences();

    return DynamicColorBuilder(builder: (
      ColorScheme? systemLight,
      ColorScheme? systemDark,
    ) {
      return WraleApp(
        wraleNotifier: wraleNotifier,
        routes: <String, Widget Function(BuildContext)>{
          '/': (BuildContext context) {
            return const Splash();
          }
        },
      );
    });
  }
}
